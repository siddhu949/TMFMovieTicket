package com.sat.tmf.movietkt.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sat.tmf.movietkt.entities.Booking;
import com.sat.tmf.movietkt.entities.Payment;
import com.sat.tmf.movietkt.entities.User;
import com.sat.tmf.movietkt.service.BookingService;
import com.sat.tmf.movietkt.service.PaymentService;
import com.sat.tmf.movietkt.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired private PaymentService paymentService;
    @Autowired private BookingService bookingService;
    @Autowired private UserService userService;

    // Initiate payment
    @GetMapping("/start/{bookingId}")
    public String startPayment(@PathVariable Integer bookingId,
                               Principal principal,
                               HttpSession session,
                               Model model) {

        User currentUser = null;

        // 1️⃣ Try fetching logged-in user from Principal (Spring Security)
        if (principal != null) {
            currentUser = userService.findByUsername(principal.getName());
        }

        // 2️⃣ Fallback to session login (manual login)
        if (currentUser == null) {
            currentUser = (User) session.getAttribute("user");
        }

        // 3️⃣ If still null, user is NOT logged in
        if (currentUser == null) {
            return "redirect:/user/login";
        }

        // 4️⃣ Get the booking
        Booking booking = bookingService.findById(bookingId);
        if (booking == null) {
            model.addAttribute("error", "Booking not found!");
            return "redirect:/";
        }

        // 5️⃣ Initiate payment
        Payment payment = paymentService.initiatePayment(booking, currentUser, "RAZORPAY");

        // 6️⃣ Store updated user back in session (if session login is used)
        session.setAttribute("user", currentUser);

        // 7️⃣ Add data to model
        model.addAttribute("payment", payment);
        model.addAttribute("booking", booking);
        model.addAttribute("contentPage", "/WEB-INF/views/user/paymentPage.jsp");
        model.addAttribute("pageTitle", "Make Payment");

        return "layout/layout";
    }

    // Razorpay or Stripe webhook (callback)
    @PostMapping("/webhook")
    @ResponseBody
    public String handleWebhook(@RequestBody String payload) {
        // Example payload parsing
        if (payload.contains("payment_success")) {
            String txnId = extractTxnId(payload);
            paymentService.handlePaymentSuccess(txnId, "RAZORPAY");
        } else if (payload.contains("payment_failed")) {
            String txnId = extractTxnId(payload);
            paymentService.handlePaymentFailure(txnId, "RAZORPAY");
        }
        return "OK";
    }

    private String extractTxnId(String payload) {
        // In real use, parse JSON from Razorpay/Stripe webhook payload
        int start = payload.indexOf("txn_");
        return start != -1 ? payload.substring(start, start + 36) : "unknown";
    }
    @GetMapping("/confirm")
    public String confirmBookingGet(@RequestParam Integer bookingId, Model model) {

        Booking booking = bookingService.confirmBooking(bookingId);

        model.addAttribute("booking", booking);
        model.addAttribute("contentPage", "/WEB-INF/views/user/bookingSuccess.jsp");
        model.addAttribute("pageTitle", "Booking Confirmed");

        return "layout/layout";
    }
    @PostMapping("/confirm")
    public String confirmBooking(@RequestParam Integer bookingId, Model model) {
        Booking booking = bookingService.confirmBooking(bookingId);
        model.addAttribute("booking", booking);
        model.addAttribute("contentPage", "/WEB-INF/views/user/bookingSuccess.jsp");
        model.addAttribute("pageTitle", "Booking Confirmed");
        return "layout/layout";
    }

}

