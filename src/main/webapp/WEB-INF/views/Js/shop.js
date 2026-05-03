 let currentProductImg = '';

    document.querySelectorAll('.category-sidebar a').forEach(link => {
      link.addEventListener('click', function (e) {
        document.querySelectorAll('.category-sidebar a').forEach(l => l.classList.remove('active'));
        this.classList.add('active');
      });
    });

    function toggleCatMore() {
      const moreLinks = document.getElementById('catMoreLinks');
      const btn = document.getElementById('catShowMoreBtn');
      const btnText = document.getElementById('catMoreBtnText');
      const icon = document.getElementById('catMoreBtnIcon');
      const isVisible = moreLinks.classList.contains('visible');
      if (isVisible) {
        moreLinks.classList.remove('visible');
        btnText.textContent = 'Show More';
        btn.classList.remove('open');
      } else {
        moreLinks.classList.add('visible');
        btnText.textContent = 'Show Less';
        btn.classList.add('open');
      }
    }

    function activeLink(event) {
      document.querySelectorAll('#pagination .link').forEach(li => li.classList.remove('active'));
      event.currentTarget.classList.add('active');
    }

    const categoryBtn = document.getElementById('category-btn');
    const shortcutLinks = document.querySelector('.shortcut-links');
    if (categoryBtn && shortcutLinks) {
      categoryBtn.addEventListener('click', function (e) {
        e.preventDefault();
        shortcutLinks.classList.toggle('active');
      });
      document.addEventListener('click', function (e) {
        if (!categoryBtn.contains(e.target) && !shortcutLinks.contains(e.target)) {
          shortcutLinks.classList.remove('active');
        }
      });
    }

    const showMoreBtn = document.getElementById('showMoreBtn');
    const moreLinksNav = document.querySelector('.more-links');
    if (showMoreBtn && moreLinksNav) {
      moreLinksNav.style.display = 'none';
      showMoreBtn.addEventListener('click', function (e) {
        e.preventDefault();
        const isHidden = moreLinksNav.style.display === 'none';
        moreLinksNav.style.display = isHidden ? 'block' : 'none';
        showMoreBtn.textContent = isHidden ? 'Show Less' : 'Show More';
      });
    }

    function openPopup(itemName, itemPrice, imgSrc) {
      document.getElementById('popupItemName').textContent = itemName;
      document.getElementById('popupItemPrice').textContent = itemPrice;
      currentProductImg = imgSrc || '';
      document.getElementById('popupOverlay').classList.add('show');
      document.body.style.overflow = 'hidden';
    }

    function closePopup() {
      document.getElementById('popupOverlay').classList.remove('show');
      document.body.style.overflow = '';
    }

    function handleOverlayClick(e) {
      if (e.target === document.getElementById('popupOverlay')) closePopup();
    }

    function proceedToPayment() {
      const name = document.getElementById('popupItemName').textContent;
      const price = document.getElementById('popupItemPrice').textContent;
      let orders = JSON.parse(localStorage.getItem('orders')) || [];
      orders.push({
        name: name,
        price: price.replace('Rs ', '').replace(',', ''),
        img: currentProductImg,
        status: 'Pending'
      });
      localStorage.setItem('orders', JSON.stringify(orders));
      closePopup();
      window.location.href = 'Cart.html';
    }

    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') closePopup();
    });