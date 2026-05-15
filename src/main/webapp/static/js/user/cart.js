// Format currency display Rs. X,XXX
function formatRs(amount) {
    return "Rs. " + amount.toLocaleString('en-IN');
}

// Convert "Rs. 1,500" -> 1500
function parseRs(stringRs) {
    return parseInt(stringRs.replace(/[Rs. ,]/g, '')) || 0;
}

// Update cart totals dynamically
function updateCartTotals() {

    const cartItems = document.querySelectorAll('.cart-item');

    let subtotal = 0;
    let totalItemsCount = 0;

    cartItems.forEach(item => {

        const priceDisplay =
            item.querySelector('.item-price-display').textContent;

        const price = parseRs(priceDisplay);

        const quantity =
            parseInt(item.querySelector('.quantity-input').value);

        const itemSubtotal = price * quantity;

        item.querySelector('.item-subtotal-display').textContent =
            formatRs(itemSubtotal);

        subtotal += itemSubtotal;

        totalItemsCount += quantity;
    });

    const shippingFee = subtotal > 0 ? 150 : 0;

    const grandTotal = subtotal + shippingFee;

    document.getElementById('cartSubtotalDisplay').textContent =
        formatRs(subtotal);

    document.getElementById('shippingFeeDisplay').textContent =
        formatRs(shippingFee);

    document.getElementById('cartTotalDisplay').textContent =
        formatRs(grandTotal);

    const itemCountDisplay =
        document.getElementById('itemCountDisplay');

    if (totalItemsCount === 0) {

        itemCountDisplay.textContent = "Your cart is empty.";

        // Reload page to show empty cart state
        setTimeout(() => {
            window.location.reload();
        }, 500);

    } else {

        itemCountDisplay.textContent =
            `${totalItemsCount} Item${totalItemsCount > 1 ? 's' : ''} in your cart`;
    }
}

// Function to update quantity via AJAX
async function updateQuantity(cartItemId, newQuantity) {
    try {
        const response = await fetch('${pageContext.request.contextPath}/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=update&cartItemId=${cartItemId}&quantity=${newQuantity}`
        });

        if (!response.ok) {
            throw new Error('Failed to update quantity');
        }

        return true;
    } catch (error) {
        console.error('Error updating quantity:', error);
        return false;
    }
}

document.addEventListener('DOMContentLoaded', () => {

    const cartTableBody =
        document.getElementById('cartTableBody');

    // Modal functions
    function openModal(modalId, htmlContent = null) {

        const modal =
            document.getElementById(modalId);

        if (htmlContent) {

            const modalBody =
                modal.querySelector('.modal-body');

            if (modalBody) {
                modalBody.innerHTML = htmlContent;
            }
        }

        modal.classList.add('show');
    }

    function closeModal(modalId) {

        document
            .getElementById(modalId)
            .classList
            .remove('show');
    }

    // Close modal logic
    document.querySelectorAll('.modal-overlay').forEach(modal => {

        modal.querySelectorAll('.close-modal, .btn-cancel')
            .forEach(btn => {

                btn.addEventListener('click', () => {
                    closeModal(modal.id);
                });
            });

        modal.addEventListener('click', (e) => {

            if (e.target === modal) {
                closeModal(modal.id);
            }
        });

        modal.querySelector('.modal-content')
            .addEventListener('click', (e) => {
                e.stopPropagation();
            });
    });

    // Cart table events
    cartTableBody.addEventListener('click', async (event) => {

        const target = event.target;

        const row = target.closest('.cart-item');

        if (!row) return;

        // MINUS BUTTON
        if (
            target.classList.contains('minus') ||
            target.closest('.minus')
        ) {

            event.preventDefault();

            const input =
                row.querySelector('.quantity-input');

            let currentVal = parseInt(input.value);

            if (currentVal > 1) {

                const newVal = currentVal - 1;
                const cartItemId = target.getAttribute('data-cart-item-id') ||
                    target.closest('.minus').getAttribute('data-cart-item-id');

                // Update via AJAX
                const success = await updateQuantity(cartItemId, newVal);

                if (success) {
                    input.value = newVal;
                    updateCartTotals();
                } else {
                    alert('Failed to update quantity. Please try again.');
                }
            }
        }

        // PLUS BUTTON
        if (
            target.classList.contains('plus') ||
            target.closest('.plus')
        ) {

            event.preventDefault();

            const input =
                row.querySelector('.quantity-input');

            let currentVal = parseInt(input.value);

            const newVal = currentVal + 1;
            const cartItemId = target.getAttribute('data-cart-item-id') ||
                target.closest('.plus').getAttribute('data-cart-item-id');

            // Update via AJAX
            const success = await updateQuantity(cartItemId, newVal);

            if (success) {
                input.value = newVal;
                updateCartTotals();
            } else {
                alert('Failed to update quantity. Please try again.');
            }
        }

        // DELETE BUTTON - FIXED LOGIC
        if (
            target.classList.contains('remove-btn') ||
            target.closest('.remove-btn')
        ) {

            event.preventDefault();

            const itemName =
                row.querySelector('.cart-item-details h4').textContent;

            document.getElementById('deleteItemName').textContent =
                itemName;

            // Get cart item id from the button's data attribute or from the hidden input in the row
            let cartItemId;

            // Check if there's a hidden input in the row
            const hiddenInput = row.querySelector('input[name="cartItemId"]');
            if (hiddenInput) {
                cartItemId = hiddenInput.value;
            } else {
                // Try to get from the remove button's data attribute
                const removeBtn = target.closest('.remove-btn');
                cartItemId = removeBtn.getAttribute('data-cart-item-id');
            }

            console.log('Deleting cart item ID:', cartItemId); // Debug log

            // Set modal hidden input
            document.getElementById('deleteCartItemId').value =
                cartItemId;

            openModal('deleteConfirmModal');
        }

        // BUY NOW BUTTON
        if (
            target.classList.contains('buy-now-item-btn') ||
            target.closest('.buy-now-item-btn')
        ) {

            event.preventDefault();

            const productName =
                row.querySelector('.cart-item-details h4').textContent;

            const quantity =
                row.querySelector('.quantity-input').value;

            const subtotalDisplay =
                row.querySelector('.item-subtotal-display').textContent;

            const htmlContent = `
                <p>You have selected immediate checkout for:</p>
                <p>Item: <strong>${productName}</strong></p>
                <p>Quantity: ${quantity}</p>
                <p>Item Subtotal: <strong>${subtotalDisplay}</strong></p>
                <p>(Shipping fee of Rs. 150 will be applied at payment)</p>
            `;

            openModal('buyNowModal', htmlContent);
        }
    });

    // Handle delete form submission
    const deleteForm = document.getElementById('deleteCartForm');
    if (deleteForm) {
        deleteForm.addEventListener('submit', function(e) {
            console.log('Delete form submitted with cartItemId:',
                document.getElementById('deleteCartItemId').value);
            // Form will submit normally to the server
        });
    }

    // FULL CART CHECKOUT
    const checkoutBtn = document.getElementById('proceedCheckoutBtn');
    if (checkoutBtn) {
        checkoutBtn.addEventListener('click', (event) => {

            event.preventDefault();

            const totalItemsText =
                document.getElementById('itemCountDisplay').textContent;

            if (totalItemsText === "Your cart is empty.") {

                alert("Your cart is empty. Add items before checking out.");

                return;
            }

            const grandTotal =
                document.getElementById('cartTotalDisplay').textContent;

            const totalItems =
                totalItemsText.split(' ')[0];

            const htmlContent = `
                <p>You are about to checkout with your entire cart.</p>
                <p>Total Items: <strong>${totalItems}</strong></p>
                <p>
                    Grand Total to Pay:
                    <strong class="highlight-price">
                        ${grandTotal}
                    </strong>
                </p>
                <p>Please confirm your order before payment.</p>
            `;

            openModal('cartCheckoutModal', htmlContent);
        });
    }

    // Initial totals
    updateCartTotals();
});