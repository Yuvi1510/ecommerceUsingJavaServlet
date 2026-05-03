 // Format currency display Rs. X,XXX
    function formatRs(amount) {
        return "Rs. " + amount.toLocaleString('en-IN');
    }

    // New helper to strip "Rs. " and "," and get integer
    function parseRs(stringRs) {
        // Rs. 1,500 -> 1500
        return parseInt(stringRs.replace(/[Rs. ,]/g, '')) || 0;
    }

    // =========================================
    // --- UPDATED LOGIC TO PARSE HTML PRICE ---
    // =========================================
    function updateCartTotals() {
        const cartItems = document.querySelectorAll('.cart-item');
        let subtotal = 0;
        let totalItemsCount = 0;

        cartItems.forEach(item => {
            // New logic: read the price directly from the display element
            const priceDisplay = item.querySelector('.item-price-display').textContent;
            const price = parseRs(priceDisplay);

            const quantity = parseInt(item.querySelector('.quantity-input').value);
            const itemSubtotal = price * quantity;
            item.querySelector('.item-subtotal-display').textContent = formatRs(itemSubtotal);
            subtotal += itemSubtotal;
            totalItemsCount += quantity;
        });

        const shippingFee = subtotal > 0 ? 150 : 0;
        const grandTotal = subtotal + shippingFee;

        document.getElementById('cartSubtotalDisplay').textContent = formatRs(subtotal);
        document.getElementById('shippingFeeDisplay').textContent = formatRs(shippingFee);
        document.getElementById('cartTotalDisplay').textContent = formatRs(grandTotal);

        const itemCountDisplay = document.getElementById('itemCountDisplay');
        if (totalItemsCount === 0) {
            itemCountDisplay.textContent = "Your cart is empty.";
        } else {
            itemCountDisplay.textContent = `${totalItemsCount} Item${totalItemsCount > 1 ? 's' : ''} in your cart`;
        }
    }

    // Main JavaScript
    document.addEventListener('DOMContentLoaded', () => {
        const cartTableBody = document.getElementById('cartTableBody');

        // =========================================
        // --- UPDATED MODAL HANDLING FOR DELETE ---
        // =========================================
        
        // Variable to temporarily store the row targeted for deletion
        let rowToDelete = null; 

        // General Modal Handling Functions
        function openModal(modalId, htmlContent = null) {
            const modalOverlay = document.getElementById(modalId);
            // Only update body if content is provided (delete modal doesn't need dynamic body update)
            if (htmlContent) {
                modalOverlay.querySelector('.modal-body').innerHTML = htmlContent;
            }
            modalOverlay.classList.add('show');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('show');
            // Reset rowToDelete when closing any modal to be safe
            rowToDelete = null; 
        }

        // Global listeners for closing any modal via its cancel buttons, 'X', or background click
        document.querySelectorAll('.modal-overlay').forEach(modal => {
            modal.querySelectorAll('.close-modal, .modal-btn').forEach(btn => {
                btn.addEventListener('click', (e) => {
                    // Specific logic for confirm buttons is handled separately
                    if (!btn.classList.contains('btn-confirm-checkout') && !btn.classList.contains('btn-confirm-delete')) {
                        closeModal(modal.id);
                    }
                });
            });

            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    closeModal(modal.id);
                }
            });

            modal.querySelector('.modal-content').addEventListener('click', (e) => {
                e.stopPropagation();
            });
        });


        // Event Delegation for Table Clicks
        cartTableBody.addEventListener('click', (event) => {
            const target = event.target;
            const row = target.closest('.cart-item');
            if (!row) return;

            // Handle Quantity Minus
            if (target.classList.contains('minus') || target.closest('.minus')) {
                const input = row.querySelector('.quantity-input');
                let currentVal = parseInt(input.value);
                if (currentVal > 1) {
                    input.value = currentVal - 1;
                    updateCartTotals();
                }
                event.preventDefault();
            }

            // Handle Quantity Plus
            if (target.classList.contains('plus') || target.closest('.plus')) {
                const input = row.querySelector('.quantity-input');
                let currentVal = parseInt(input.value);
                input.value = currentVal + 1;
                updateCartTotals();
                event.preventDefault();
            }

            // =========================================
            // --- UPDATED JS FOR DELETE POPUP ---
            // =========================================
            if (target.classList.contains('remove-btn') || target.closest('.remove-btn')) {
                
                // 1. Get the item name to display in popup
                const itemName = row.querySelector('.cart-item-details h4').textContent;
                document.getElementById('deleteItemName').textContent = itemName;

                // 2. Store the reference to the row to be deleted
                rowToDelete = row; 

                // 3. Open the beautiful delete modal
                openModal('deleteConfirmModal'); 
                
                event.preventDefault();
            }

            // Buy Now logic
            if (target.classList.contains('buy-now-item-btn') || target.closest('.buy-now-item-btn')) {
                const productName = row.querySelector('.cart-item-details h4').textContent;
                const quantity = row.querySelector('.quantity-input').value;
                const subtotalDisplay = row.querySelector('.item-subtotal-display').textContent;

                const htmlContent = `
                    <p>You have selected immediate checkout for:</p>
                    <p>Item: <strong>${productName}</strong></p>
                    <p>Quantity: ${quantity}</p>
                    <p>Item Subtotal: <strong>${subtotalDisplay}</strong></p>
                    <p>(Shipping fee of Rs. 150 will be applied at payment)</p>
                `;

                openModal('buyNowModal', htmlContent);

                event.preventDefault();
            }
        });

        // Grand Checkout logic
        document.getElementById('proceedCheckoutBtn').addEventListener('click', (event) => {
            const totalItemsCountHTML = document.getElementById('itemCountDisplay').textContent;
            
            if (totalItemsCountHTML === "Your cart is empty.") {
                alert("Your cart is empty. Add items before checking out.");
            } else {
                const grandTotal = document.getElementById('cartTotalDisplay').textContent;
                const totalItems = totalItemsCountHTML.split(' ')[0];

                const htmlContent = `
                    <p>You are about to checkout with your entire cart.</p>
                    <p>Total Items: <strong>${totalItems}</strong></p>
                    <p>Grand Total to Pay (inc. shipping): <strong class="highlight-price">${grandTotal}</strong></p>
                    <p>Please confirm your order details before proceeding to payment.</p>
                `;

                openModal('cartCheckoutModal', htmlContent);
            }
            event.preventDefault();
        });

        // Confirm buttons inside checkout modals
        document.querySelectorAll('.btn-confirm-checkout').forEach(btn => {
            btn.addEventListener('click', () => {
                const modalId = btn.closest('.modal-overlay').id;
                if(modalId === 'buyNowModal'){
                    alert("Redirecting to secure payment gateway for single item...");
                } else if (modalId === 'cartCheckoutModal'){
                    alert("Redirecting to secure payment gateway for full cart...");
                }
                
                closeModal(modalId);
            });
        });

        // =========================================
        // --- NEW JS FOR CONFIRM DELETE BUTTON ---
        // =========================================
        document.getElementById('confirmDeleteBtn').addEventListener('click', () => {
            if (rowToDelete) {
                // 1. Perform the actual deletion
                rowToDelete.remove();
                // 2. Update totals
                updateCartTotals();
                // 3. Close the modal
                closeModal('deleteConfirmModal');
            }
        });

        updateCartTotals();
    });
