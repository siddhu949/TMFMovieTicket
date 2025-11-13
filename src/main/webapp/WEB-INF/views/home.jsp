<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${appName} - Book Your Movie Tickets</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
            color: #fff;
            min-height: 100vh;
        }

        /* Header */
        .navbar {
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(10px);
            padding: 1.5rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        }

        .logo {
            font-size: 2rem;
            font-weight: bold;
            background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            list-style: none;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 0.5rem 1rem;
            border-radius: 8px;
        }

        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            padding: 6rem 5% 4rem;
            text-align: center;
            background: linear-gradient(180deg, rgba(0,0,0,0.6) 0%, rgba(0,0,0,0.3) 100%);
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #ffd89b 0%, #19547b 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: fadeInDown 1s ease;
        }

        .hero p {
            font-size: 1.3rem;
            color: #ddd;
            margin-bottom: 2rem;
            animation: fadeInUp 1s ease;
        }

        .cta-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
            animation: fadeInUp 1.2s ease;
        }

        .btn {
            padding: 1rem 2.5rem;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(245, 87, 108, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(245, 87, 108, 0.6);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
        }

        /* Movies Section */
        .movies-section {
            padding: 4rem 5%;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            position: relative;
        }

        .section-title::after {
            content: '';
            display: block;
            width: 100px;
            height: 4px;
            background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
            margin: 1rem auto 0;
            border-radius: 2px;
        }

        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        .movie-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.4s ease;
            cursor: pointer;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(240, 147, 251, 0.3);
            border-color: rgba(240, 147, 251, 0.5);
        }

        .movie-poster {
            width: 100%;
            height: 400px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .movie-info {
            padding: 1.5rem;
        }

        .movie-title {
            font-size: 1.4rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .movie-genre {
            color: #bbb;
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }

        .movie-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .rating {
            display: flex;
            align-items: center;
            gap: 0.3rem;
            background: rgba(255, 193, 7, 0.2);
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: bold;
        }

        .book-btn {
            background: linear-gradient(45deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 0.6rem 1.5rem;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .book-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
        }

        /* Features Section */
        .features {
            padding: 4rem 5%;
            background: rgba(0, 0, 0, 0.3);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            text-align: center;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .feature-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.08);
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .feature-card p {
            color: #bbb;
            line-height: 1.6;
        }

        /* Footer */
        footer {
            background: rgba(0, 0, 0, 0.8);
            padding: 2rem 5%;
            text-align: center;
            margin-top: 4rem;
        }

        footer p {
            color: #888;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .nav-links {
                gap: 1rem;
            }

            .movies-grid {
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="logo">
            🎬 ${appName}
        </div>
        <ul class="nav-links">
            <li><a href="/">Home</a></li>
            <li><a href="/movies">Movies</a></li>
            <li><a href="/theaters">Theaters</a></li>
            <li><a href="/offers">Offers</a></li>
            <li><a href="login">Login</a></li>
        </ul>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <h1>🎬 Book Your Movie Tickets</h1>
        <p>Experience the magic of cinema with just a few clicks!</p>
        <div class="cta-buttons">
            <a href="/movies" class="btn btn-primary">Browse Movies</a>
            <a href="/offers" class="btn btn-secondary">View Offers</a>
        </div>
    </section>

    <!-- Featured Movies -->
    <section class="movies-section">
        <h2 class="section-title">Now Showing</h2>
        <div class="movies-grid">
            <c:forEach var="movie" items="${featuredMovies}">
                <div class="movie-card">
                    <img src="${movie.imageUrl}" alt="${movie.title}" class="movie-poster">
                    <div class="movie-info">
                        <h3 class="movie-title">${movie.title}</h3>
                        <p class="movie-genre">${movie.genre}</p>
                        <div class="movie-footer">
                            <div class="rating">
                                ⭐ ${movie.rating}
                            </div>
                            <button class="book-btn">Book Now</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Features -->
    <section class="features">
        <h2 class="section-title">Why Choose Us?</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">🎫</div>
                <h3>Easy Booking</h3>
                <p>Book your tickets in seconds with our user-friendly interface</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">💺</div>
                <h3>Select Your Seats</h3>
                <p>Choose your preferred seats from interactive seat maps</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🎁</div>
                <h3>Exclusive Offers</h3>
                <p>Get amazing discounts and cashback on every booking</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3>Mobile Tickets</h3>
                <p>Get instant e-tickets on your mobile device</p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 ${appName}. All rights reserved. | Privacy Policy | Terms of Service</p>
    </footer>
</body>
</html>