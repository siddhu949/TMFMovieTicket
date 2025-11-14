<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .animate-fadeInUp { animation: fadeInUp 0.6s ease-out; }
        .animate-slideIn { animation: slideIn 0.5s ease-out; }

        .gradient-red {
            background: linear-gradient(135deg, #dc2626 0%, #ef4444 50%, #f87171 100%);
        }
        .gradient-red-dark {
            background: linear-gradient(135deg, #991b1b 0%, #dc2626 50%, #ef4444 100%);
        }

        .text-gradient-red {
            background: linear-gradient(135deg, #dc2626 0%, #f87171 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .movie-card { position: relative; overflow: hidden; }
        .movie-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            transition: left 0.5s;
        }
        .movie-card:hover::before { left: 100%; }

        .glass-effect {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1);
        }

        .search-glow:focus {
            box-shadow: 0 0 20px rgba(220,38,38,0.3);
        }
    </style>
</head>

<body class="bg-gray-900">



    <!-- Header -->
    <div class="max-w-7xl mx-auto mb-12 animate-fadeInUp">
        <div class="text-center mb-8">
            <h1 class="text-5xl md:text-6xl font-extrabold mb-4">
                <span class="text-gradient-red">Now Showing</span>
            </h1>
            <p class="text-gray-300 text-lg">Discover the latest blockbusters and upcoming releases</p>
        </div>

        <!-- Search -->
        <div class="max-w-3xl mx-auto animate-slideIn">
            <form method="get" action="${pageContext.request.contextPath}/movies" class="relative">
                <div class="flex flex-col sm:flex-row gap-3">
                    <div class="flex-1 relative">
                        <input type="text" name="search" value="${search}"
                               placeholder="Search movies by title or genre..."
                               class="w-full px-6 py-4 pl-12 rounded-2xl glass-effect text-white
                                      placeholder-gray-400 focus:outline-none search-glow
                                      transition-all duration-300 border-2 border-red-500/20
                                      focus:border-red-500"/>
                        <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-red-400"></i>
                    </div>

                    <button type="submit"
                            class="px-8 py-4 gradient-red rounded-2xl text-white font-bold shadow-lg
                                   shadow-red-500/30 hover:shadow-red-500/50 hover:scale-105
                                   transition-all duration-300 flex items-center gap-2">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Movie Grid -->
    <div class="max-w-7xl mx-auto">

        <c:choose>

            <c:when test="${not empty movies}">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">

                    <c:forEach var="m" items="${movies}">
                        <div class="movie-card group glass-effect rounded-3xl overflow-hidden transform
                                    hover:-translate-y-2 hover:scale-105 transition-all duration-500
                                    shadow-xl hover:shadow-2xl hover:shadow-red-500/20">

                            <!-- Poster -->
                            <div class="relative overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty m.posterUrl}">
                                        <img src="${m.posterUrl}" alt="${m.title}"
                                             class="w-full h-80 object-cover group-hover:scale-110
                                                    transition-transform duration-500"/>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="w-full h-80 gradient-red-dark flex items-center justify-center">
                                            <i class="fas fa-film text-6xl text-white/30"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="absolute inset-0 bg-gradient-to-t from-black via-black/50 to-transparent
                                            opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                            </div>

                          <!-- Info -->
<div class="p-5 bg-gray-900/95 backdrop-blur-sm 
            bg-gradient-to-br from-gray-900 to-black">
    
    <h3 class="text-xl font-bold text-white mb-3 line-clamp-2
               group-hover:text-red-400 transition-colors duration-300">
        ${m.title}
    </h3>

    <div class="space-y-2 mb-4 text-sm text-gray-300">
        <div class="flex items-center gap-2">
            <i class="fas fa-language text-red-400 w-4"></i>
            <span class="font-medium text-white">Language:</span> ${m.language}
        </div>

        <div class="flex items-center gap-2">
            <i class="fas fa-masks-theater text-red-400 w-4"></i>
            <span class="font-medium text-white">Genre:</span> ${m.genre}
        </div>

        <div class="flex items-center gap-2">
            <i class="fas fa-clock text-red-400 w-4"></i>
            <span class="font-medium text-white">Duration:</span> ${m.duration} min
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/movies/${m.id}/shows"
       class="block w-full text-center py-3 gradient-red rounded-xl text-white font-bold
              shadow-lg shadow-red-500/20 hover:shadow-red-500/40 hover:scale-105
              transition-all duration-300">
        <i class="fas fa-ticket-alt mr-2"></i> View Showtimes
    </a>
</div>

                        </div>
                    </c:forEach>

                </div>
            </c:when>

            <c:otherwise>
                <div class="text-center py-20 animate-fadeInUp">
                    <div class="glass-effect rounded-3xl p-12 max-w-md mx-auto">
                        <i class="fas fa-film text-6xl text-red-400 mb-4"></i>
                        <h3 class="text-2xl font-bold text-white mb-3">No Movies Found</h3>
                        <p class="text-gray-400 mb-6">We couldn't find any movies matching your search.</p>

                        <a href="${pageContext.request.contextPath}/movies"
                           class="inline-block px-8 py-3 gradient-red rounded-xl text-white font-bold
                                  hover:scale-105 transition-all duration-300">
                            <i class="fas fa-refresh mr-2"></i> View All Movies
                        </a>
                    </div>
                </div>
            </c:otherwise>

        </c:choose>

    </div>



</body>
</html>
