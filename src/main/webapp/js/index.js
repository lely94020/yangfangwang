// 轮播图
let slideIndex = 0;
const slides = document.querySelectorAll('#banner .slide');
const dots = document.querySelectorAll('#dots span');
let timer;

function showSlide(n) {
    slides.forEach(s => s.classList.remove('active'));
    dots.forEach(d => d.classList.remove('active'));
    slideIndex = (n + slides.length) % slides.length;
    slides[slideIndex].classList.add('active');
    dots[slideIndex].classList.add('active');
}

function nextSlide() { showSlide(slideIndex + 1); resetTimer(); }
function prevSlide() { showSlide(slideIndex - 1); resetTimer(); }

function resetTimer() {
    clearInterval(timer);
    timer = setInterval(nextSlide, 2000);
}

dots.forEach((dot, i) => {
    dot.addEventListener('click', () => { showSlide(i); resetTimer(); });
});

timer = setInterval(nextSlide, 2000);

// 回到顶部
const backTop = document.querySelector('.tool-btn:last-child');
if (backTop) {
    backTop.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
}
