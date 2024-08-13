const slides = document.getElementById("ad-slider-row");
const slide = document.querySelectorAll(".ad-slider-col");

let slideWidth = 300;
let slideMargin = 10;

let slideCount = slide.length;
let currentIdx = 0;

const prevBtn = document.getElementById("prev");
const nextBtn = document.getElementById("next");

makeClone();

function makeClone(){
    for(let i = 0; i<slideCount; i++){
        let cloneSlide = slide[i].cloneNode(true);
        cloneSlide.classList.add('clone');
        slides.appendChild(cloneSlide);
    }
    for(let i = slideCount - 1; i>=0; i--){
        let cloneSlide = slide[i].cloneNode(true);
        cloneSlide.classList.add('clone');
        slides.prepend(cloneSlide);
    }
    updateWidth();
    setInitialPos();

    setTimeout(function (){
        slides.classList.add('animated');
    }, 100);
}

function updateWidth(){
    let currentSlides = document.querySelectorAll(".ad-slider-col");
    let newSlideCount = currentSlides.length;

    let newWidth = (slideWidth + slideMargin) * newSlideCount - slideMargin + 'px';
    slides.style.width = newWidth;
}

function setInitialPos(){
    let initialTranslateValue = -(slideWidth + slideMargin) * slideCount;
    slides.style.transform = 'translateX(' + initialTranslateValue + 'px)';
}

nextBtn.addEventListener('click', function () {
    moveSlide(currentIdx + 1);
})

prevBtn.addEventListener('click', function () {
    moveSlide(currentIdx - 1);
})

function moveSlide(num) {
    slides.style.left = -num * (slideWidth + slideMargin) + 'px';
    currentIdx = num;

    if(currentIdx == slideCount || currentIdx == -slideCount) {
        setTimeout(function (){
            slides.classList.remove('animated');
            slides.style.left = '0px';
            currentIdx = 0;
        }, 500);
        setTimeout(function (){
            slides.classList.add('animated');
        }, 600);
    }
}