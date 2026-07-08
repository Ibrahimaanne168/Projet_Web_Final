import subprocess
import os
from flask import Flask, render_template, request, redirect, flash, url_for, session
from flask_mysqldb import MySQL
from MySQLdb.cursors import DictCursor
from werkzeug.security import generate_password_hash

app = Flask(__name__)
app.secret_key = "ufr_sta"

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "sta_bd"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
app.config["MYSQL_CHARSET"] = "utf8mb4"

mysql = MySQL(app)

def sauvegarder_bdd():

    print("Sauvegarde lancée")

    chemin = os.path.join(
        "database",
        "sta.sql"
    )

    commande = [
        r"C:\xampp\mysql\bin\mysqldump.exe",
        "-u",
        "root",
        "sta_bd"
    ]

    with open(chemin, "w", encoding="utf-8") as fichier:

        subprocess.run(
            commande,
            stdout=fichier
        )

    print("Sauvegarde terminée")

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/actualites")
def actualites():

    cursor = mysql.connection.cursor(DictCursor)

    cursor.execute("""SELECT * FROM actualites""")

    actualites = cursor.fetchall()

    cursor.close()

    return render_template(
        "actualites.html",
        actualites=actualites
    )

@app.route("/activites")
def activites():

    cursor = mysql.connection.cursor(DictCursor)

    cursor.execute("""SELECT * FROM activites""")

    activites = cursor.fetchall()

    cursor.close()

    return render_template(
        "activites.html",
        activites=activites
    )

@app.route("/departements")
def departements():

    cursor = mysql.connection.cursor()

    cursor.execute("SELECT * FROM departements")

    departements = cursor.fetchall()

    cursor.close()

    return render_template(
        "departements.html",
        departements=departements
    )

@app.route("/formations")
def formations():

    cursor = mysql.connection.cursor()

    # Départements
    cursor.execute("SELECT * FROM departements ORDER BY ordre")
    departements = cursor.fetchall()

    for departement in departements:

        # Filières du département
        cursor.execute("""
            SELECT *
            FROM filieres
            WHERE departement_id=%s
            ORDER BY ordre
        """, (departement["id"],))

        filieres = cursor.fetchall()

        departement["filieres"] = filieres

        for filiere in filieres:

            # Maquettes
            cursor.execute("""
                SELECT *
                FROM maquettes
                WHERE filiere_id=%s
                ORDER BY semestre
            """, (filiere["id"],))

            filiere["maquettes"] = cursor.fetchall()

            # Semestres
            cursor.execute("""
                SELECT *
                FROM semestres
                WHERE filiere_id=%s
                ORDER BY numero
            """, (filiere["id"],))

            semestres = cursor.fetchall()

            filiere["semestres"] = semestres

            for semestre in semestres:

                # UE
                cursor.execute("""
                    SELECT *
                    FROM ues
                    WHERE semestre_id=%s
                    ORDER BY ordre
                """, (semestre["id"],))

                semestre["ues"] = cursor.fetchall()

    cursor.close()

    return render_template(
        "formations.html",
        departements=departements
    )

@app.route("/galerie")
def galerie():

    cursor = mysql.connection.cursor(DictCursor)

    cursor.execute("""
        SELECT *
        FROM albums
        ORDER BY date_album DESC
    """)

    albums = cursor.fetchall()

    for album in albums:

        cursor.execute("""
            SELECT image_album
            FROM photos
            WHERE album_id=%s
        """,(album["id_album"],))

        album["photos"]=cursor.fetchall()

    cursor.close()

    return render_template(
        "galerie.html",
        albums=albums
    )

@app.route("/contact", methods=["GET", "POST"])
def contact():

    if request.method == "POST":

        prenom = request.form["prenom"]
        nom = request.form["nom"]
        email = request.form["email"]
        sujet = request.form["sujet"]
        message = request.form["message"]

        cur = mysql.connection.cursor()

        cur.execute("""
        INSERT INTO contacts(prenom_contact, nom_contact, email_contact, sujet_contact, message_contact)
        VALUES(%s,%s,%s,%s,%s)
        """, (prenom, nom, email, sujet, message))

        mysql.connection.commit()
        sauvegarder_bdd()
        cur.close()

        flash("Message envoyé avec succès.")

        return redirect("/contact")

    return render_template("contact.html")

@app.route("/enseignants")
def enseignants():
    cur = mysql.connection.cursor(DictCursor)

    cur.execute("SELECT * FROM enseignants")

    enseignants = cur.fetchall()

    cur.close()

    return render_template(
        "enseignants.html",
        enseignants=enseignants
    )

@app.route("/admin/login", methods=["GET", "POST"])
def admin_login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM admin WHERE username=%s", (username,))
        admin = cur.fetchone()

        if not admin:
            flash("❌ utilisateur incorrect", "error")
            return redirect(url_for("admin_login"))

        if password != admin["password"]:
            flash("❌ mot de passe incorrect", "error")

        session["admin"] = admin["username"]
        flash("✅ connexion réussie", "success")
        return redirect(url_for("dashboard"))

    return render_template("admin/login.html")

@app.route("/admin/dashboard")
def dashboard():

    if "admin" not in session:
        flash("Veuillez vous connecter", "error")
        return redirect(url_for("admin_login"))
    return render_template("admin/dashboard.html")

@app.route("/admin/logout")
def logout():
    session.pop("admin", None)
    flash("Déconnexion réussie", "success")
    return redirect(url_for("admin_login"))


@app.route("/admin/acceder_actu", methods=["GET", "POST"])
def acceder_actu():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    # SUPPRESSION ACTUALITE

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM actualites WHERE id_actu=%s",
            (supprimer,)
        )

        mysql.connection.commit()

        sauvegarder_bdd()

        flash("Actualité supprimée.", "success")

        return redirect(url_for("acceder_actu"))

    #MODIFIER ACTUALITE

    actualite = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute(
            "SELECT * FROM actualites WHERE id_actu=%s",
            (modifier,)
        )

        actualite = cur.fetchone()

    # AJOUT ACTUALITE

    if request.method == "POST":

        id_actu = request.form.get("id_actu")

        titre = request.form["titre_actu"]
        contenu = request.form["contenu_actu"]
        categorie = request.form["categorie_actu"]
        image = request.form["image_actu"]
        date = request.form["date_publication"]

        if id_actu:

            cur.execute("""
                UPDATE actualites
                SET
                    titre_actu=%s,
                    contenu_actu=%s,
                    image_actu=%s,
                    categorie_actu=%s,
                    date_publication=%s
                WHERE id_actu=%s
            """,(
                titre,
                contenu,
                image,
                categorie,
                date,
                id_actu
            ))

            flash("Actualité modifiée.", "success")

        else:

            cur.execute("""
                INSERT INTO actualites
                (
                    titre_actu,
                    contenu_actu,
                    image_actu,
                    categorie_actu,
                    date_publication
                )
                VALUES (%s,%s,%s,%s,%s)
            """,(
                titre,
                contenu,
                image,
                categorie,
                date
            ))

            flash("Actualité ajoutée.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        return redirect(url_for("acceder_actu"))

    # LISTER ACTUALITE

    cur.execute("""
        SELECT *
        FROM actualites
        ORDER BY date_publication DESC
    """)

    actualites = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_actu.html",
        actualites=actualites,
        actualite=actualite
    )

@app.route("/admin/acceder_activite", methods=["GET", "POST"])
def acceder_activite():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    # ---------------- SUPPRESSION ----------------

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM activites WHERE id_activite=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Activité supprimée avec succès.", "success")

        return redirect(url_for("acceder_activite"))

    # ---------------- MODIFICATION ----------------

    activite = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute(
            "SELECT * FROM activites WHERE id_activite=%s",
            (modifier,)
        )

        activite = cur.fetchone()

    # ---------------- AJOUT / MODIFICATION ----------------

    if request.method == "POST":

        id_activite = request.form.get("id_activite")

        titre = request.form["titre_activite"]
        description = request.form["description_activite"]
        image = request.form["image_activite"]
        date = request.form["date_activite"]

        if id_activite:

            cur.execute("""
                UPDATE activites
                SET
                    titre_activite=%s,
                    description_activite=%s,
                    image_activite=%s,
                    date_activite=%s
                WHERE id_activite=%s
            """, (
                titre,
                description,
                image,
                date,
                id_activite
            ))

            flash("Activité modifiée avec succès.", "success")

        else:

            cur.execute("""
                INSERT INTO activites
                (
                    titre_activite,
                    description_activite,
                    image_activite,
                    date_activite
                )
                VALUES (%s,%s,%s,%s)
            """, (
                titre,
                description,
                image,
                date
            ))

            flash("Activité ajoutée avec succès.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        return redirect(url_for("acceder_activite"))

    # ---------------- LISTE ----------------

    cur.execute("""
        SELECT *
        FROM activites
        ORDER BY date_activite DESC
    """)

    activites = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_activite.html",
        activites=activites,
        activite=activite
    )

@app.route("/admin/acceder_enseignant", methods=["GET", "POST"])
def acceder_enseignant():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    # SUPPRESSION 

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM enseignants WHERE id_enseignant=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Enseignant supprimé avec succès.", "success")

        return redirect(url_for("acceder_enseignant"))

    #  MODIFICATION 

    enseignant = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute(
            "SELECT * FROM enseignants WHERE id_enseignant=%s",
            (modifier,)
        )

        enseignant = cur.fetchone()

    #  AJOUT / MODIFICATION 

    if request.method == "POST":

        id_enseignant = request.form.get("id_enseignant")

        nom = request.form["nom"]
        grade = request.form["grade"]
        departement = request.form["departement"]
        email = request.form["email"]
        recherche = request.form["recherche"]
        photo = request.form["photo"]

        if id_enseignant:

            cur.execute("""
                UPDATE enseignants
                SET
                    nom=%s,
                    grade=%s,
                    departement=%s,
                    email=%s,
                    recherche=%s,
                    photo=%s
                WHERE id_enseignant=%s
            """, (
                nom,
                grade,
                departement,
                email,
                recherche,
                photo,
                id_enseignant
            ))

            flash("Enseignant modifié avec succès.", "success")

        else:

            cur.execute("""
                INSERT INTO enseignants
                (
                    nom,
                    grade,
                    departement,
                    email,
                    recherche,
                    photo
                )
                VALUES (%s,%s,%s,%s,%s,%s)
            """, (
                nom,
                grade,
                departement,
                email,
                recherche,
                photo
            ))

            flash("Enseignant ajouté avec succès.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        return redirect(url_for("acceder_enseignant"))

    #  LISTE 

    cur.execute("""
        SELECT *
        FROM enseignants
        ORDER BY nom
    """)

    enseignants = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_enseignant.html",
        enseignants=enseignants,
        enseignant=enseignant
    )

@app.route("/admin/acceder_galerie", methods=["GET", "POST"])
def acceder_galerie():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)


    # ================= SUPPRIMER ALBUM =================

    delete_album = request.args.get("delete_album")

    if delete_album:

        cur.execute(
            "DELETE FROM albums WHERE id_album=%s",
            (delete_album,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Album supprimé.", "success")

        cur.close()

        return redirect(url_for("acceder_galerie"))



    # ================= SUPPRIMER PHOTO =================

    delete_photo = request.args.get("delete_photo")

    if delete_photo:

        cur.execute(
            "DELETE FROM photos WHERE id_photo=%s",
            (delete_photo,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Photo supprimée.", "success")

        cur.close()

        return redirect(url_for("acceder_galerie"))




    # ================= ACTIONS POST =================

    if request.method == "POST":


        action = request.form.get("type")



        # ================= CREER ALBUM =================


        if action == "add_album":


            cur.execute("""
                INSERT INTO albums
                (
                    titre_album,
                    description_album,
                    date_album
                )
                VALUES (%s,%s,%s)
            """,
            (
                request.form["titre_album"],
                request.form["description_album"],
                request.form["date_album"]
            ))


            mysql.connection.commit()
            sauvegarder_bdd()


            album_id = cur.lastrowid



            images = request.form["images_album"].splitlines()



            for image in images:

                image = image.strip()


                if image:


                    cur.execute("""
                        INSERT INTO photos
                        (
                            album_id,
                            image_album
                        )
                        VALUES (%s,%s)
                    """,
                    (
                        album_id,
                        image
                    ))



            mysql.connection.commit()
            sauvegarder_bdd()


            flash("Album créé avec succès.", "success")


            cur.close()

            return redirect(url_for("acceder_galerie"))




        # ================= AJOUTER PHOTOS =================


        elif action == "add_photo":


            album_id = request.form["album_id"]


            images = request.form["images_album"].splitlines()



            for image in images:


                image = image.strip()


                if image:


                    cur.execute("""
                        INSERT INTO photos
                        (
                            album_id,
                            image_album
                        )
                        VALUES (%s,%s)
                    """,
                    (
                        album_id,
                        image
                    ))



            mysql.connection.commit()
            sauvegarder_bdd()


            flash("Photos ajoutées avec succès.", "success")


            cur.close()

            return redirect(url_for("acceder_galerie"))




        # ================= MODIFIER ALBUM =================


        elif action == "update_album":


            cur.execute("""
                UPDATE albums
                SET
                    titre_album=%s,
                    description_album=%s,
                    date_album=%s
                WHERE id_album=%s
            """,
            (
                request.form["titre_album"],
                request.form["description_album"],
                request.form["date_album"],
                request.form["id_album"]
            ))



            mysql.connection.commit()
            sauvegarder_bdd()


            flash("Album modifié avec succès.", "success")


            cur.close()

            return redirect(url_for("acceder_galerie"))




        # ================= MODIFIER PHOTO =================


        elif action == "update_photo":


            cur.execute("""
                UPDATE photos
                SET image_album=%s
                WHERE id_photo=%s
            """,
            (
                request.form["image_album"],
                request.form["id_photo"]
            ))



            mysql.connection.commit()
            sauvegarder_bdd()


            flash("Nom de la photo modifié.", "success")


            cur.close()

            return redirect(url_for("acceder_galerie"))





    # ================= RECUPERATION ALBUMS =================


    cur.execute("""
        SELECT *
        FROM albums
        ORDER BY id_album DESC
    """)


    albums = cur.fetchall()



    for album in albums:


        cur.execute("""
            SELECT *
            FROM photos
            WHERE album_id=%s
            ORDER BY id_photo DESC
        """,
        (
            album["id_album"],
        ))


        album["photos"] = cur.fetchall()



    cur.close()



    return render_template(
        "admin/acceder_galerie.html",
        albums=albums
    )   

@app.route("/admin/acceder_departement", methods=["GET", "POST"])
def acceder_departement():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    # ---------------- SUPPRESSION ----------------

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM departements WHERE id=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Département supprimé avec succès.", "success")

        cur.close()

        return redirect(url_for("acceder_departement"))

    # ---------------- MODIFICATION ----------------

    departement = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute(
            "SELECT * FROM departements WHERE id=%s",
            (modifier,)
        )

        departement = cur.fetchone()

    # ---------------- AJOUT / MODIFICATION ----------------

    if request.method == "POST":

        id = request.form.get("id")

        nom = request.form["nom"]
        description = request.form["description"]
        image = request.form["image"]
        chef_nom = request.form["chef_nom"]
        chef_email = request.form["chef_email"]
        chef_photo = request.form["chef_photo"]
        ordre = request.form["ordre"]

        if id:

            cur.execute("""
                UPDATE departements
                SET
                    nom=%s,
                    description=%s,
                    image=%s,
                    chef_nom=%s,
                    chef_email=%s,
                    chef_photo=%s,
                    ordre=%s
                WHERE id=%s
            """, (
                nom,
                description,
                image,
                chef_nom,
                chef_email,
                chef_photo,
                ordre,
                id
            ))

            flash("Département modifié avec succès.", "success")

        else:

            cur.execute("""
                INSERT INTO departements
                (
                    nom,
                    description,
                    image,
                    chef_nom,
                    chef_email,
                    chef_photo,
                    ordre
                )
                VALUES (%s,%s,%s,%s,%s,%s,%s)
            """, (
                nom,
                description,
                image,
                chef_nom,
                chef_email,
                chef_photo,
                ordre
            ))

            flash("Département ajouté avec succès.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        cur.close()

        return redirect(url_for("acceder_departement"))

    # ---------------- LISTE ----------------

    cur.execute("""
        SELECT *
        FROM departements
        ORDER BY ordre ASC, nom ASC
    """)

    departements = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_departement.html",
        departements=departements,
        departement=departement
    )

@app.route("/admin/acceder_formation", methods=["GET", "POST"])
def acceder_formation():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    #  SUPPRESSION 

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM filieres WHERE id=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Formation supprimée avec succès.", "success")

        cur.close()

        return redirect(url_for("acceder_formation"))

    #  MODIFICATION 

    filiere = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute(
            "SELECT * FROM filieres WHERE id=%s",
            (modifier,)
        )

        filiere = cur.fetchone()

    #  AJOUT / MODIFICATION 

    if request.method == "POST":

        id = request.form.get("id")

        departement_id = request.form["departement_id"]
        nom = request.form["nom"]
        description = request.form["description"]
        image = request.form["image"]
        texte_specialisation = request.form["texte_specialisation"]
        ordre = request.form["ordre"]

        if id:

            cur.execute("""
                UPDATE filieres
                SET
                    departement_id=%s,
                    nom=%s,
                    description=%s,
                    image=%s,
                    texte_specialisation=%s,
                    ordre=%s
                WHERE id=%s
            """, (
                departement_id,
                nom,
                description,
                image,
                texte_specialisation,
                ordre,
                id
            ))

            flash("Formation modifiée avec succès.", "success")

        else:

            cur.execute("""
                INSERT INTO filieres
                (
                    departement_id,
                    nom,
                    description,
                    image,
                    texte_specialisation,
                    ordre
                )
                VALUES (%s,%s,%s,%s,%s,%s)
            """, (
                departement_id,
                nom,
                description,
                image,
                texte_specialisation,
                ordre
            ))

            flash("Formation ajoutée avec succès.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        cur.close()

        return redirect(url_for("acceder_formation"))

    # DEPARTEMENTS 

    cur.execute("""
        SELECT id, nom
        FROM departements
        ORDER BY ordre ASC
    """)

    departements = cur.fetchall()

    #  LISTE DES FILIERES 

    cur.execute("""
        SELECT
            f.*,
            d.nom AS departement
        FROM filieres f
        JOIN departements d
            ON f.departement_id = d.id
        ORDER BY d.ordre ASC, f.ordre ASC
    """)

    filieres = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_formation.html",
        departements=departements,
        filieres=filieres,
        filiere=filiere
    )


@app.route("/admin/ajouter_admin", methods=["GET", "POST"])
def ajouter_admin():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    if request.method == "POST":

        username = request.form["username"].strip()
        password = request.form["password"]

        cur = mysql.connection.cursor(DictCursor)

        cur.execute(
            "SELECT id FROM admin WHERE username=%s",
            (username,)
        )

        existe = cur.fetchone()

        if existe:

            flash("Ce nom d'utilisateur existe déjà.", "danger")

        else:

            mot_de_passe = generate_password_hash(password)

            cur.execute("""
                INSERT INTO admin(username, password)
                VALUES(%s, %s)
            """, (
                username,
                mot_de_passe
            ))

            mysql.connection.commit()
            sauvegarder_bdd()

            flash("Administrateur ajouté avec succès.", "success")

        cur.close()

    return render_template("admin/ajouter_admin.html")

@app.route("/admin/acceder_maquette", methods=["GET", "POST"])
def acceder_maquette():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    # SUPPRESSION

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM maquettes WHERE id=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Maquette supprimée avec succès.", "success")

        cur.close()

        return redirect(url_for("acceder_maquette"))

    #  MODIFICATION

    maquette = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute(
            "SELECT * FROM maquettes WHERE id=%s",
            (modifier,)
        )

        maquette = cur.fetchone()

    #  AJOUT / MODIFICATION

    if request.method == "POST":

        id = request.form.get("id")

        filiere_id = request.form["filiere_id"]
        semestre = request.form["semestre"]
        image = request.form["image"]

        if id:

            cur.execute("""
                UPDATE maquettes
                SET
                    filiere_id=%s,
                    semestre=%s,
                    image=%s
                WHERE id=%s
            """, (
                filiere_id,
                semestre,
                image,
                id
            ))

            flash("Maquette modifiée avec succès.", "success")

        else:

            cur.execute("""
                INSERT INTO maquettes
                (
                    filiere_id,
                    semestre,
                    image
                )
                VALUES (%s,%s,%s)
            """, (
                filiere_id,
                semestre,
                image
            ))

            flash("Maquette ajoutée avec succès.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        return redirect(url_for("acceder_maquette"))

    #  FILIERES 

    cur.execute("""
        SELECT id, nom
        FROM filieres
        ORDER BY nom
    """)

    filieres = cur.fetchall()

    #  LISTE 

    cur.execute("""
        SELECT
            m.*,
            f.nom
        FROM maquettes m
        JOIN filieres f
        ON m.filiere_id=f.id
        ORDER BY f.nom,m.semestre
    """)

    maquettes = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_maquette.html",
        maquettes=maquettes,
        maquette=maquette,
        filieres=filieres
    )

@app.route("/admin/acceder_ue", methods=["GET", "POST"])
def acceder_ue():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    #  SUPPRESSION 

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM ues WHERE id=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("UE supprimée avec succès.", "success")

        cur.close()

        return redirect(url_for("acceder_ue"))

    #  MODIFICATION 

    ue = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute("""
            SELECT *
            FROM ues
            WHERE id=%s
        """, (modifier,))

        ue = cur.fetchone()

    #  AJOUT / MODIFICATION

    if request.method == "POST":

        id = request.form.get("id")

        semestre_id = request.form["semestre_id"]
        nom_ue = request.form["ue"]
        ec = request.form["ec"]
        credits = request.form["credits"]
        ordre = request.form["ordre"]

        if id:

            cur.execute("""
                UPDATE ues
                SET
                    semestre_id=%s,
                    ue=%s,
                    ec=%s,
                    credits=%s,
                    ordre=%s
                WHERE id=%s
            """, (
                semestre_id,
                nom_ue,
                ec,
                credits,
                ordre,
                id
            ))

            flash("UE modifiée avec succès.", "success")

        else:

            cur.execute("""
                INSERT INTO ues
                (
                    semestre_id,
                    ue,
                    ec,
                    credits,
                    ordre
                )
                VALUES (%s,%s,%s,%s,%s)
            """, (
                semestre_id,
                nom_ue,
                ec,
                credits,
                ordre
            ))

            flash("UE ajoutée avec succès.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        return redirect(url_for("acceder_ue"))

    #  LISTE DES SEMESTRES 

    cur.execute("""
        SELECT
            s.id,
            s.numero,
            f.nom AS filiere
        FROM semestres s
        JOIN filieres f
            ON s.filiere_id = f.id
        ORDER BY
            f.nom,
            s.numero
    """)

    semestres = cur.fetchall()

    #  LISTE DES UE 

    cur.execute("""
        SELECT
            u.id,
            u.ue,
            u.ec,
            u.credits,
            u.ordre,
            s.numero,
            f.nom AS filiere
        FROM ues u
        JOIN semestres s
            ON u.semestre_id = s.id
        JOIN filieres f
            ON s.filiere_id = f.id
        ORDER BY
            f.nom,
            s.numero,
            u.ordre,
            u.ue
    """)

    ues = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_ue.html",
        ue=ue,
        ues=ues,
        semestres=semestres
    )

@app.route("/admin/acceder_semestre", methods=["GET", "POST"])
def acceder_semestre():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    # ---------------- SUPPRESSION ----------------

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM semestres WHERE id=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Semestre supprimé avec succès.", "success")

        cur.close()

        return redirect(url_for("acceder_semestre"))

    # ---------------- MODIFICATION ----------------

    semestre = None

    modifier = request.args.get("modifier")

    if modifier:

        cur.execute(
            "SELECT * FROM semestres WHERE id=%s",
            (modifier,)
        )

        semestre = cur.fetchone()

    #  AJOUT / MODIFICATION 

    if request.method == "POST":

        id = request.form.get("id")

        filiere_id = request.form["filiere_id"]
        numero = request.form["numero"]

        if id:

            cur.execute("""
                UPDATE semestres
                SET
                    filiere_id=%s,
                    numero=%s
                WHERE id=%s
            """, (
                filiere_id,
                numero,
                id
            ))

            flash("Semestre modifié avec succès.", "success")

        else:

            cur.execute("""
                INSERT INTO semestres
                (
                    filiere_id,
                    numero
                )
                VALUES (%s,%s)
            """, (
                filiere_id,
                numero
            ))

            flash("Semestre ajouté avec succès.", "success")

        mysql.connection.commit()
        sauvegarder_bdd()

        cur.close()

        return redirect(url_for("acceder_semestre"))

    #  FILIERES 

    cur.execute("""
        SELECT id, nom
        FROM filieres
        ORDER BY nom
    """)

    filieres = cur.fetchall()

    #  LISTE 

    cur.execute("""
        SELECT
            s.*,
            f.nom
        FROM semestres s
        JOIN filieres f
        ON s.filiere_id = f.id
        ORDER BY f.nom, s.numero
    """)

    semestres = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_semestre.html",
        semestre=semestre,
        semestres=semestres,
        filieres=filieres
    )

@app.route("/admin/acceder_contact")
def acceder_contact():

    if "admin" not in session:
        return redirect(url_for("admin_login"))

    cur = mysql.connection.cursor(DictCursor)

    #  SUPPRESSION 

    supprimer = request.args.get("supprimer")

    if supprimer:

        cur.execute(
            "DELETE FROM contacts WHERE id_contact=%s",
            (supprimer,)
        )

        mysql.connection.commit()
        sauvegarder_bdd()

        flash("Message supprimé avec succès.", "success")

        cur.close()

        return redirect(url_for("acceder_contact"))

    #  LECTURE 

    contact_selectionne = None

    lire = request.args.get("lire")

    if lire:

        cur.execute(
            "SELECT * FROM contacts WHERE id_contact=%s",
            (lire,)
        )

        contact_selectionne = cur.fetchone()

    #  LISTE 

    cur.execute("""
        SELECT *
        FROM contacts
        ORDER BY id_contact DESC
    """)

    contacts = cur.fetchall()

    cur.close()

    return render_template(
        "admin/acceder_contact.html",
        contacts=contacts,
        contact_selectionne=contact_selectionne
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
