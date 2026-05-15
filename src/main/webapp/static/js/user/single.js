// --- 1. Gallery Image Switcher ---
const MainImg = document.getElementById("MainImg");
const smallimg = document.getElementsByClassName("small-img");

// Using a loop to handle any number of small images
for (let i = 0; i < smallimg.length; i++) {
    smallimg[i].onclick = function() {
        MainImg.src = smallimg[i].src;
    };
}

// --- 2. Cart Badge & Popup Logic ---
const addToCartBtn = document.querySelector('.description .btn');
const cartPopup = document.getElementById('cart-popup');
const cartBadge = document.getElementById('cart-count');
// Note: Using querySelector because ID might be missing in your HTML
const qtyInput = document.querySelector('.number');

let currentCount = 0;

addToCartBtn.onclick = function() {
    // A. Calculate new total
    // We parse the value from the input field; default to 1 if empty
    let addedQty = parseInt(qtyInput.value) || 1;
    currentCount += addedQty;

    // B. Update the Badge
    cartBadge.textContent = currentCount;

    // C. Show the Badge (it is 'hidden' by default in your CSS)
    cartBadge.classList.add('show');

    // D. Trigger the Popup Notification
    cartPopup.classList.add('show');

    // E. Remove the Popup after 3 seconds
    setTimeout(function() {
        cartPopup.classList.remove('show');
    }, 3000);
};