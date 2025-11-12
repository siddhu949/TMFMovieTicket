package com.sat.tmf.movietkt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.Arrays;
import java.util.List;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home(Model model) {
        // Featured movies data
        List<Movie> featuredMovies = Arrays.asList(
            new Movie("Dune: Part Two", "Action, Sci-Fi", "https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&h=600&fit=crop", "8.5"),
            new Movie("The Batman Returns", "Action, Crime", "https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=400&h=600&fit=crop", "8.8"),
            new Movie("Interstellar Voyage", "Adventure, Sci-Fi", "https://images.unsplash.com/photo-1518676590629-3dcbd9c5a5c9?w=400&h=600&fit=crop", "9.0"),
            new Movie("The Last Kingdom", "Drama, History", "https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400&h=600&fit=crop", "8.3")
        );
        
        model.addAttribute("featuredMovies", featuredMovies);
        model.addAttribute("appName", "TMF Cinema");
        
        return "home";
    }
    
    // Inner class for Movie data
    public static class Movie {
        private String title;
        private String genre;
        private String imageUrl;
        private String rating;
        
        public Movie(String title, String genre, String imageUrl, String rating) {
            this.title = title;
            this.genre = genre;
            this.imageUrl = imageUrl;
            this.rating = rating;
        }
        
        // Getters
        public String getTitle() { return title; }
        public String getGenre() { return genre; }
        public String getImageUrl() { return imageUrl; }
        public String getRating() { return rating; }
    }
}