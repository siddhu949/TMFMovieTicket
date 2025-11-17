package com.sat.tmf.movietkt.controller;

import java.security.Principal;
import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sat.tmf.movietkt.entities.Booking;
import com.sat.tmf.movietkt.entities.Show;
import com.sat.tmf.movietkt.entities.User;
import com.sat.tmf.movietkt.service.BookingService;
import com.sat.tmf.movietkt.service.ShowService;
import com.sat.tmf.movietkt.service.TemplateSeatService;
import com.sat.tmf.movietkt.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/booking")
public class BookingController {

    @Autowired private BookingService bookingService;
    @Autowired private ShowService showService;
    @Autowired private TemplateSeatService seatService;
    @Autowired private UserService userService;

    // View seat map for a show
    @GetMapping("/select/{showId}")
    @Transactional
    public String selectSeats(@PathVariable Integer showId, Model model) {
        Show show = showService.findById(showId);
     // Initialize lazy association
        Hibernate.initialize(show.getSeatTemplate());
        // Get booked seat IDs for this show
        List<Integer> bookedSeatIds = bookingService.getBookedSeatIds(showId);
        model.addAttribute("show", show);
        model.addAttribute("templateSeats", seatService.findByTemplateId(show.getSeatTemplate().getId()));
        model.addAttribute("bookedSeatIds", bookedSeatIds); // Add booked seats
        model.addAttribute("contentPage", "/WEB-INF/views/user/selectSeats.jsp");
        model.addAttribute("pageTitle", "Select Seats for " + show.getMovie().getTitle());
        return "layout/layout";
    }

 // Hold seats
    @PostMapping("/hold")
    public String holdSeats(@RequestParam Integer showId,
                            @RequestParam List<Integer> seatIds,
                            HttpServletRequest request,  // Use HTTP request
                            Model model) {

        HttpSession session = request.getSession(false); // get existing session
        if (session == null || session.getAttribute("user") == null) {
            // Redirect to login page with redirect param
            return "redirect:/login?redirect=/booking/select/" + showId;
        }

        // Get logged-in user from session
        User user = (User) session.getAttribute("user");

        // Get show and hold seats
        Show show = showService.findById(showId);
        Booking booking = bookingService.holdSeats(user, show, seatIds);

        // Add attributes to model
        model.addAttribute("booking", booking);
        model.addAttribute("contentPage", "/WEB-INF/views/user/confirmBooking.jsp");
        model.addAttribute("pageTitle", "Confirm Booking");

        return "layout/layout";
    }


    // Confirm booking
    @PostMapping("/confirm")
    public String confirmBooking(@RequestParam Integer bookingId, Model model) {
        Booking booking = bookingService.confirmBooking(bookingId);
        model.addAttribute("booking", booking);
        model.addAttribute("contentPage", "/WEB-INF/views/user/bookingSuccess.jsp");
        model.addAttribute("pageTitle", "Booking Confirmed");
        return "layout/layout";
    }

    // View booking history
    @GetMapping("/history")
    public String viewHistory(Principal principal, HttpSession session, Model model) {
        User user = null;

        // Try to get the user from Principal (Spring Security)
        if (principal != null) {
            user = userService.findByUsername(principal.getName());
        } 
        // Otherwise, get from session (matches your navbar)
        else if (session.getAttribute("user") != null) {
            user = (User) session.getAttribute("user");
        }

        if (user == null) {
            // If still null, redirect to login
            return "redirect:/login";
        }

        List<Booking> bookings = bookingService.findByUser(user);

        model.addAttribute("bookings", bookings);
        model.addAttribute("contentPage", "/WEB-INF/views/user/bookingHistory.jsp");
        model.addAttribute("pageTitle", "My Bookings");
        return "layout/layout";
    }
}

