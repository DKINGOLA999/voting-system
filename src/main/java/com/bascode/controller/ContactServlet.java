package com.bascode.controller;

import com.bascode.util.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/contacts.jsp").forward(request, response);
            return;
        }

        // Send email to admin
        String adminEmail = "admin@votify.com"; // Change to actual admin email
        String subject = "Contact Form Message from " + name;
        String body = "From: " + name + " (" + email + ")\n\nMessage:\n" + message;

        try {
            EmailService.sendEmail(adminEmail, subject, body);
            request.setAttribute("success", "Message sent successfully. We will get back to you soon.");
        } catch (Exception e) {
            request.setAttribute("error", "Failed to send message. Please try again.");
        }

        request.getRequestDispatcher("/contacts.jsp").forward(request, response);
    }
}