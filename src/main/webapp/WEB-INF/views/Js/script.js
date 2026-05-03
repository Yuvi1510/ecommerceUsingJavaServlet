//js for category sidebar to make it functional

const categoryBtn = document.getElementById("category-btn");
  const sidebar = document.querySelector(".shortcut-links");

  const showMoreBtn = document.getElementById("showMoreBtn");
  const moreLinks = document.querySelector(".more-links");

  // Toggle sidebar
  categoryBtn.addEventListener("click", (e) => {
    e.stopPropagation(); // prevent closing instantly
    sidebar.classList.toggle("active");
  });

  // Show More / Show Less
  showMoreBtn.addEventListener("click", (e) => {
    e.preventDefault();

    moreLinks.classList.toggle("active");

    if (moreLinks.classList.contains("active")) {
      moreLinks.style.display = "block";
      showMoreBtn.innerText = "Show Less";
    } else {
      moreLinks.style.display = "none";
      showMoreBtn.innerText = "Show More";
    }
  });

  // Click outside to close sidebar
  document.addEventListener("click", (e) => {
    if (!sidebar.contains(e.target) && !categoryBtn.contains(e.target)) {
      sidebar.classList.remove("active");
    }
  });


  //Shop section pagination
  let currentGroup = 0; // 0 = pages 1-3, 1 = pages 4-6
const links = document.querySelectorAll('.link');
const pages = document.querySelectorAll('.product-page');

function showPage(num) {
    // 1. Remove 'active' class from all pagination numbers
    links.forEach(l => l.classList.remove('active'));
    
    // 2. Add 'active' class to the clicked number (index is num - 1)
    if (links[num - 1]) {
        links[num - 1].classList.add('active');
    }

    // 3. Hide all product pages and show the specific target page
    pages.forEach(p => p.classList.remove('active-page'));
    const targetPage = document.getElementById('p' + num);
    if (targetPage) {
        targetPage.classList.add('active-page');
    }

    // 4. Smooth scroll back to the top of the shop section
    const shopSection = document.getElementById('shop');
    if (shopSection) {
        shopSection.scrollIntoView({ behavior: 'smooth' });
    }
}

function changeGroup(dir) {
    // Move to next group (Pages 4-6)
    if (dir === 1 && currentGroup === 0) {
        currentGroup = 1;
        updatePagination();
        showPage(4); // Automatically show the first page of the new group
    } 
    // Move to previous group (Pages 1-3)
    else if (dir === -1 && currentGroup === 1) {
        currentGroup = 0;
        updatePagination();
        showPage(3); // Automatically show the last page of the old group
    }
}

function updatePagination() {
    links.forEach((link, index) => {
        const pageNum = index + 1;
        // Logic to show/hide numbers based on the current group
        if (currentGroup === 0 && pageNum <= 3) {
            link.classList.add('visible');
        } else if (currentGroup === 1 && pageNum > 3) {
            link.classList.add('visible');
        } else {
            link.classList.remove('visible');
        }
    });
}

// Initialize the view on load
window.onload = () => {
    updatePagination();
    showPage(1);
};