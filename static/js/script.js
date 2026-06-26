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
