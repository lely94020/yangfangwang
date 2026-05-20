// 自动轮播
let count = 0;
const banner = document.querySelector('.main-banner');

setInterval(() => {
    count++;
    if (count % 2 === 0) {
        banner.style.background = '#81C784';
    } else {
        banner.style.background = '#66BB6A';
    }
}, 3000);

// 回到顶部
document.addEventListener('scroll', () => {
    if (window.scrollY > 300) {
        console.log('显示回到顶部');
    }
});