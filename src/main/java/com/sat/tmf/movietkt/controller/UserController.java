package com.sat.tmf.movietkt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sat.tmf.movietkt.entities.User;
import com.sat.tmf.movietkt.service.UserService;

import jakarta.servlet.http.HttpSession;

import java.security.Principal;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // =================== REGISTER ===================
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("contentPage", "/WEB-INF/views/pages/register.jsp");
        model.addAttribute("pageTitle", "Register");
        return "layout/layout";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, Model model) {
        try {
            userService.register(user);
            model.addAttribute("message", "Registration successful! You can now log in.");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        model.addAttribute("contentPage", "/WEB-INF/views/pages/login.jsp");
        return "layout/layout";
    }
    
 


    // =================== PROFILE ===================
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Principal principal, Model model) {
        User user = null;

        // 1️⃣ Try to get from Principal (Spring Security)
        if (principal != null) {
            String username = principal.getName();
            user = userService.findByUsername(username);
        }

        // 2️⃣ Fallback to session (manual login)
        if (user == null) {
            user = (User) session.getAttribute("user");
        }

        // 3️⃣ If still null → not logged in
        if (user == null) {
            return "redirect:/login";
        }

        // 4️⃣ Add user to model
        model.addAttribute("user", user);
        model.addAttribute("contentPage", "/WEB-INF/views/profile.jsp");
        model.addAttribute("pageTitle", "My Profile");

        return "layout/layout";
    }



    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute User user, Principal principal, 
                                HttpSession session, Model model) {

        User currentUser = null;

        // 1️⃣ Try Principal
        if (principal != null) {
            currentUser = userService.findByUsername(principal.getName());
        }

        // 2️⃣ Fallback to session
        if (currentUser == null) {
            currentUser = (User) session.getAttribute("user");
        }

        // 3️⃣ If still null → not logged in
        if (currentUser == null) {
            return "redirect:/login";
        }

        // 4️⃣ Update profile
        userService.updateUserProfile(currentUser.getUsername(), user);

        // 5️⃣ Update session if using session login
        session.setAttribute("user", userService.findByUsername(currentUser.getUsername()));

        // 6️⃣ Add model attributes for feedback
        model.addAttribute("message", "Profile updated successfully!");
        model.addAttribute("user", userService.findByUsername(currentUser.getUsername()));
        model.addAttribute("contentPage", "/WEB-INF/views/profile.jsp");
        model.addAttribute("pageTitle", "My Profile");

        return "layout/layout";
    }


    // =================== ADMIN VIEW ALL USERS ===================
    @GetMapping("/list")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.findAllUsers());
        model.addAttribute("contentPage", "/WEB-INF/views/admin/adminUsers.jsp");
        model.addAttribute("pageTitle", "All Users");
        return "layout/layout";
    }

 
}

