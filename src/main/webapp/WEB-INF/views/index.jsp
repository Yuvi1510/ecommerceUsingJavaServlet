<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 3/24/2026
  Time: 5:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>Categories</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<nav class="navbar">
    <div class="navbar-item">
        <div class="logo">
            <img src="images/logo2.png" alt="FataFat Kin Logo">
        </div>

        <div class="search-container">
            <input type="text" placeholder="Search product" class="search-input">
            <button class="search-btn">
                <img src="images/search.png" class="search-icon">
            </button>
        </div>

        <ul class="nav-links">
            <li><a href="#">Home</a></li>
            <li><a href="#">Shop</a></li>
            <li><a href="#">Top Sales</a></li>
            <li><a href="#">New Arrivals</a></li>
            <li><a href="#">Offer</a></li>
            <li><a href="#">About</a></li>
            <!--<li class="icon"><a href="#"><i class="bx bx-menu"></i></a></li>-->
            <li class="icon"><a href="#"><i class='bx bx-help-circle icon' ></i><span>customer service</span></a></li>
            <li class="icon"><a href="#"><i class='bx bx-shopping-bag icon' ></i><span>cart</span></a></li>
            <li class="icon"><a href="login.html"><i class='bx bx-user icon'></i><span>login</span></a></li>
        </ul>
    </div>
</nav>
</nav>

<section id="home">
    <div class="container">
        <h5>EXCLUSIVE OFFERS</h5>
        <h1><span>Best Deals</span> This Season</h1>
        <p>Fatafat Kin offers the most competitive prices on top-tier <br> electronics, fashion, and daily essentials.</p>
        <button>Shop Now</button>
    </div>
</section>

<section id="brand">
    <div class="row">
        <img src="images/brands/8.png" class="brand-logo">
        <img src="images/brands/7.jpg" class="brand-logo">
        <img src="images/brands/1.png" class="brand-logo">
        <img src="images/brands/2.jpg" class="brand-logo">
        <img src="images/brands/11.jpg" class="brand-logo">
        <img src="images/brands/4.png" class="brand-logo">
        <img src="images/brands/5.png" class="brand-logo">
        <img src="images/brands/6.png" class="brand-logo">
        <img src="images/brands/9.png" class="brand-logo">
        <img src="images/brands/goldstar-logo.png" class="brand-logo">
    </div>
</section>

<section id="new">
    <div class="product-container">
        <div class="one">
            <img class="img-fluid" src="images/shoe/download.jpg" alt="Rare Sneakers 1">
            <div class="details">
                <h2 class="text-uppercase">Extreme Rare Sneakers</h2>
                <button>Shop Now</button>

            </div>
        </div>

        <div class="one">
            <img class="img-fluid" src="images/shoe/black.png" alt="Black Sneakers">
            <div class="details">
                <h2 class="text-uppercase">Awesome Black Outfit</h2>
                <button>Shop Now</button>

            </div>
        </div>

        <div class="one">
            <img class="img-fluid" src="images/shoe/watch.png" alt="Rare Watch">
            <div class="details">
                <h2 class="text-uppercase">Sport wear up to 50% off</h2>
                <button>Shop Now</button>
            </div>
        </div>

    </div>
</section>

<section id="featured">
    <div class="container">
        <h3>Top Picks for You</h3>
        <hr>
        <p>High-quality essentials at prices that make sense. Fresh stock has just landed at Fatafat Kin.</p>
    </div>

    <div class="product-list">
        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/featured/1.png" alt="">
            </div>
            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">Nebula Blue Pro-Runners</h5>
            <h4 class="p-price">Rs 3500</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>


        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/featured/3.png" alt="">
            </div>
            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">Skechers Uno - Stand on Air</h5>
            <h4 class="p-price">Rs 12000</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>


        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/featured/2.png" alt="">
            </div>

            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">Ziranu Fashion Multi-Pocket Aesthetic Backpack.</h5>
            <h4 class="p-price">Rs 3500</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>


        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/featured/4.avif" alt="">
            </div>
            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">COS Cropped Cotton-Blend Twill Jacket</h5>
            <h4 class="p-price">Rs 14000</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>
    </div>

</section>


<section id="banner">
    <div class="banner">
        <h4>MID SEASON'S SALE</h4>
        <h1>Autumn Collection<br><span> Up to 25% OFF</span></h1>
        <p>Step into Spring with Style: Basanta Deals are Blooming <br> at FataFat Kin!</p>
        <button>Shop Now</button>
    </div>
</section>

<section id="featured">
    <div class="container">
        <h3>Refined Layers for Autumn Mornings.</h3>
        <hr>
        <p>Quick Fashion for a Fast Life – Grab your Mid-Season picks today!</p>
    </div>

    <div class="product-list">
        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/spring/download.png" alt="">
            </div>
            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">Classic Navy Linen Button-Down Shirt.</h5>
            <h4 class="p-price">Rs 4200</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>

        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/spring/4.png">
            </div>
            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">Rust Knitted Wrap Dress & Camel Overcoat Set.</h5>
            <h4 class="p-price">Rs 8500</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>

        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/spring/2.png">
            </div>
            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">705 Classic Logo Black T-Shirt.</h5>
            <h4 class="p-price">Rs 1200</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>


        <div class="product-container">
            <div class="img-box">
                <img class="product-img" src="images/spring/8.jpg" alt="">
            </div>
            <div class="star">
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
                <i class='bx bxs-star'></i>
            </div>
            <h5 class="p-name">Midnight Tweed Blazer & Skirt Set</h5>
            <h4 class="p-price">Rs 5500</h4>
            <button class="buy-btn">BUY NOW</button>
        </div>
    </div>

    <section id="watches">
        <div class="container">
            <h3>Track your Time in Luxury.</h3>
            <hr>
            <p>Instant Elegance on your Wrist – Shop the Mid-Season Watch Edit.</p>
        </div>

        <div class="product-list">
            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w.png" alt="">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">Meikle Skeleton Automatic Rose Gold</h5>
                <h4 class="p-price">Rs 12,500</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>

            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w2.png">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">Timex Deepwater Reef Automatic</h5>
                <h4 class="p-price">Rs 12000</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>

            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w3.png">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">Bvlgari Serpenti Seduttori Replica</h5>
                <h4 class="p-price">Rs 7,500</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>


            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w4.png" alt="">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">Midnight Tweed Blazer & Skirt Set</h5>
                <h4 class="p-price">Rs 5500</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>
        </div>
    </section>
    <section id="shoes">
        <div class="container">
            <h3>Elite Performance</h3>
            <hr>
            <p>Quick styles for a fast-paced life. Grab your mid-season pairs today!</p>
        </div>

        <div class="product-list">
            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w.png" alt="">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">Classic Navy Linen Button-Down Shirt.</h5>
                <h4 class="p-price">Rs 4200</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>

            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w2.png">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">Rust Knitted Wrap Dress & Camel Overcoat Set.</h5>
                <h4 class="p-price">Rs 8500</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>

            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w3.png">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">705 Classic Logo Black T-Shirt.</h5>
                <h4 class="p-price">Rs 1200</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>


            <div class="product-container">
                <div class="img-box">
                    <img class="product-img" src="images/spring/w4.png" alt="">
                </div>
                <div class="star">
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                    <i class='bx bxs-star'></i>
                </div>
                <h5 class="p-name">Midnight Tweed Blazer & Skirt Set</h5>
                <h4 class="p-price">Rs 5500</h4>
                <button class="buy-btn">BUY NOW</button>
            </div>
        </div>
    </section>
</section>

<footer class="footer">
    <div class="row">
        <div class="footer-one"></div>
        <!--<img src="images/logo1.png" alt="">-->
        <p>Fatafat Kin is Nepal’s premier destination for fast, reliable, and premium online shopping.
            Bringing the best of tech and fashion directly to your doorstep.</p>
    </div>
</footer>
</body>
</html>
