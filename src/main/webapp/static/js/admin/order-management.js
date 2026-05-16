// Order Management JavaScript - Simple Filter and Modal Logic

// Toggle order items visibility
document.addEventListener('DOMContentLoaded', function() {
    // View items buttons
    const viewButtons = document.querySelectorAll('.view-items-btn');
    viewButtons.forEach(button => {
        button.addEventListener('click', function() {
            const orderId = this.getAttribute('data-order-id');
            const itemsRow = document.getElementById('items-' + orderId);
            if (itemsRow.style.display === 'none') {
                itemsRow.style.display = 'table-row';
                this.textContent = 'Hide Items';
            } else {
                itemsRow.style.display = 'none';
                this.textContent = 'View Items';
            }
        });
    });

    // Status dropdown change
    const statusDropdowns = document.querySelectorAll('.status-dropdown');
    statusDropdowns.forEach(dropdown => {
        dropdown.addEventListener('change', function() {
            const orderId = this.getAttribute('data-order-id');
            const currentStatus = this.getAttribute('data-current-status');
            const newStatus = this.value;

            if (currentStatus === newStatus) {
                return;
            }

            // Show modal popup
            showStatusModal(orderId, newStatus);

            // Reset dropdown to original value until confirmed
            this.value = currentStatus;
        });
    });

    // Filter buttons
    const filterBtns = document.querySelectorAll('.filter-btn');
    filterBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            // Update active class
            filterBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            const status = this.getAttribute('data-status');
            filterOrders(status);
        });
    });
});

// Filter orders based on status
function filterOrders(status) {
    const rows = document.querySelectorAll('.order-row');

    rows.forEach(row => {
        const rowStatus = row.getAttribute('data-status');

        if (status === 'all') {
            row.style.display = '';
            // Also show associated items row if it was visible
            const nextRow = row.nextElementSibling;
            if (nextRow && nextRow.classList.contains('order-items-row')) {
                if (nextRow.style.display !== 'none') {
                    // Keep it as is
                }
            }
        } else {
            if (rowStatus === status) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
                // Hide associated items row as well
                const nextRow = row.nextElementSibling;
                if (nextRow && nextRow.classList.contains('order-items-row')) {
                    nextRow.style.display = 'none';
                    // Reset the view button text
                    const viewBtn = row.querySelector('.view-items-btn');
                    if (viewBtn) {
                        viewBtn.textContent = 'View Items';
                    }
                }
            }
        }
    });
}

// Show modal for status update
function showStatusModal(orderId, newStatus) {
    const modal = document.getElementById('statusModal');
    const modalOrderId = document.getElementById('modalOrderId');
    const modalStatus = document.getElementById('modalStatus');
    const statusMessage = document.getElementById('statusChangeMessage');

    modalOrderId.value = orderId;
    modalStatus.value = newStatus;

    let statusText = '';
    switch(newStatus) {
        case 'PENDING':
            statusText = 'Pending';
            break;
        case 'SHIPPED':
            statusText = 'Shipped';
            break;
        case 'DELIVERED':
            statusText = 'Delivered';
            break;
        case 'CANCELLED':
            statusText = 'Cancelled';
            break;
    }

    statusMessage.innerHTML = 'Are you sure you want to change the status of Order #' + orderId + ' to <strong>' + statusText + '</strong>?';

    modal.style.display = 'flex';
}

// Close modal
function closeModal() {
    const modal = document.getElementById('statusModal');
    modal.style.display = 'none';
}

// Modal close on outside click
window.onclick = function(event) {
    const modal = document.getElementById('statusModal');
    if (event.target === modal) {
        closeModal();
    }
}

// Function to refresh page after form submission (optional)
function refreshPage() {
    location.reload();
}