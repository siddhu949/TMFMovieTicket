package com.sat.tmf.movietkt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.sat.tmf.movietkt.entities.User;
import com.sat.tmf.movietkt.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	  @Autowired
	    private UserService userService;
	 @GetMapping("/login")
	    public String showLoginPage(Model model) {
	        model.addAttribute("user", new User());
	        model.addAttribute("contentPage", "/WEB-INF/views/pages/login.jsp");
	        model.addAttribute("pageTitle", "login");
	        return "layout/layout";
	    }

	 @PostMapping("/login")
	 public String loginUser(@ModelAttribute User user, Model model, HttpSession session) {

	     User loggedUser = null;

	     try {
	         loggedUser = userService.authentication(user.getUsername(), user.getPassword());

	         if (loggedUser != null) {
	             // Store in session
	             session.setAttribute("user", loggedUser);

	             // Redirect based on role
	             if ("ADMIN".equalsIgnoreCase(loggedUser.getRole())) {
	                 // Admin dashboard
	                 return "redirect:/admin/dashboard";
	             } 
	             else if ("USER".equalsIgnoreCase(loggedUser.getRole())) {
	                 // User dashboard
	                 return "redirect:/";
	             } 
	             else {
	                 // Unknown role
	                 model.addAttribute("error", "Unknown role assigned to this user.");
	                 model.addAttribute("contentPage", "/WEB-INF/views/pages/login.jsp");
	                 return "layout/layout";
	             }
	         } else {
	             model.addAttribute("error", "Invalid username or password");
	         }

	     } catch (Exception e) {
	         model.addAttribute("error", e.getMessage());
	     }

	     // Login failed → show login page again
	     model.addAttribute("contentPage", "/WEB-INF/views/pages/login.jsp");
	     return "layout/layout";
	 }

	    @GetMapping("/logout")
	    public String logout(HttpSession session){
	        session.invalidate();
	        return "redirect:/login";
	    }
}
