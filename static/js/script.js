const menuBtn = document.querySelector(".menu-defilant");
const nav = document.querySelector("nav");

menuBtn.addEventListener("click", function () {
    nav.classList.toggle("active");
});

const slides = document.querySelectorAll('.slide');
const dots = document.querySelectorAll('.dot');

let current = 0;

function showSlide(index){
    slides.forEach(slide => slide.classList.remove('active'));
    dots.forEach(dot => dot.classList.remove('active'));

    slides[index].classList.add('active');
    dots[index].classList.add('active');
}

document.querySelector('.next').onclick = () => {
    current = (current + 1) % slides.length;
    showSlide(current);
};

document.querySelector('.prev').onclick = () => {
    current = (current - 1 + slides.length) % slides.length;
    showSlide(current);
};

setInterval(() => {
    current = (current + 1) % slides.length;
    showSlide(current);
}, 5000);

function ouvrirPopupDepuisCarte(card) {
    document.getElementById("popup-nom").innerText = card.dataset.nom;
    document.getElementById("popup-grade").innerText = card.dataset.grade;
    document.getElementById("popup-departement").innerText = card.dataset.departement;
    document.getElementById("popup-email").innerText = card.dataset.email;
    document.getElementById("popup-email").href = "mailto:" + card.dataset.email;
    document.getElementById("popup-recherche").innerText = card.dataset.recherche;
    document.getElementById("popup-photo").src = card.dataset.photo;

document.getElementById("popup-prof").classList.add("active");}

function fermerPopup(){

    document.getElementById("popup-prof").classList.remove("active");

}
    setTimeout(() => {
        const flashes = document.querySelectorAll('.flash');
        flashes.forEach(f => {
            f.style.transition = "0.5s";
            f.style.opacity = "0";
            setTimeout(() => f.remove(), 500);
        });
    }, 3000);

    function showTab(id){

    document.querySelectorAll('.tab').forEach(t=>{
        t.style.display='none';
    });

    document.getElementById(id).style.display='block';
}

function afficherModificationPhoto(id){

    let form = document.getElementById(
        "modifier-photo-" + id
    );

    if(form.style.display === "none"){
        form.style.display = "block";
    }
    else{
        form.style.display = "none";
    }

}


function afficherAjoutPhoto(id){

let form=document.getElementById(
"ajout-photo-"+id
);


form.style.display =
form.style.display==="none"
?
"block"
:
"none";

}



