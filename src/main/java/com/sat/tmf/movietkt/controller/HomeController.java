package com.sat.tmf.movietkt.controller;

import com.sat.tmf.movietkt.entities.Movie;
import com.sat.tmf.movietkt.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private MovieService movieService;

    @GetMapping("/")
    public String home(Model model) {

        // Fetch movies from DB
        List<Movie> featuredMovies = movieService.findAllMovies();

        model.addAttribute("featuredMovies", featuredMovies);
        model.addAttribute("appName", "TMF Cinema");

        return "home";
    }
}