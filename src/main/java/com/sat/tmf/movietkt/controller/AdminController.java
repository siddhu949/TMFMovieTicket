package com.sat.tmf.movietkt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sat.tmf.movietkt.entities.User;
import com.sat.tmf.movietkt.service.MovieService;
import com.sat.tmf.movietkt.service.ScreenService;
import com.sat.tmf.movietkt.service.ShowService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private MovieService movieService;

    @Autowired
    private ScreenService screenService;

    @Autowired
    private ShowService showService;
	 // ================= DASHBOARD =================
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");

        if (admin == null) {
            return "redirect:/login";
        }

        // Load all data
        model.addAttribute("movies", movieService.findAllMovies());
        model.addAttribute("screens", screenService.findAll());
        model.addAttribute("shows", showService.findAll());

        // Pass content page and title for layout
        model.addAttribute("contentPage", "/WEB-INF/views/admin/adminDashboard.jsp");
        model.addAttribute("pageTitle", "Admin Dashboard");

        return "layout/layout";
    }
    @PostMapping("/admin/deleteMovie")
    public String deleteMovie(@RequestParam("movieId") Integer movieId) {
        movieService.deleteMovie(movieId);
        return "redirect:/admin/movies"; // go back to movies tab
    }


}
