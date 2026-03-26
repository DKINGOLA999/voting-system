//package com.bascode.controller;
//
//import com.bascode.dto.UserRequest;
//import com.bascode.model.entity.User;
//import com.bascode.model.enums.Role;
//import com.bascode.services.UserService;
//import com.bascode.services.UserServiceImpl;
//import com.bascode.util.JPAUtil;
//
//import jakarta.persistence.EntityManager;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import jakarta.validation.Validation;
//import jakarta.validation.Validator;
//import jakarta.validation.ValidatorFactory;
//import jakarta.validation.ConstraintViolation;
//
//import java.io.IOException;
//import java.time.Year;
//import java.util.Set;
//
//@WebServlet("/register")
//public class RegisterServlet extends HttpServlet {
//
//    private static final long serialVersionUID = 1L;
//
//    // Show registration page
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
//               .forward(request, response);
//    }
//
//    // Handle form submission
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        // 1️⃣ Map form data to DTO
//        UserRequest dto = new UserRequest();
//        dto.setFirstName(request.getParameter("firstName"));
//        dto.setLastName(request.getParameter("lastName"));
//        dto.setEmail(request.getParameter("email"));
//        dto.setPassword(request.getParameter("password"));
//        dto.setConfirmPassword(request.getParameter("confirmPassword"));
//
//        // Convert birthYear string to int
//        String birthYearStr = request.getParameter("birthYear");
//        int birthYear = 0;
//        try {
//            birthYear = Integer.parseInt(birthYearStr);
//        } catch (NumberFormatException e) {
//            request.setAttribute("error", "Invalid birth year format.");
//            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
//                   .forward(request, response);
//            return;
//        }
//        dto.setBirthYear(birthYear);
//
//        dto.setState(request.getParameter("state"));
//        dto.setCountry(request.getParameter("country"));
//
//        // 2️⃣ Bean validation
//        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
//        Validator validator = factory.getValidator();
//        Set<ConstraintViolation<UserRequest>> violations = validator.validate(dto);
//
//        if (!violations.isEmpty()) {
//            request.setAttribute("errors", violations);
//            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
//                   .forward(request, response);
//            return;
//        }
//
//        // 3️⃣ Password validation
//        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
//            request.setAttribute("error", "Passwords do not match!");
//            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
//                   .forward(request, response);
//            return;
//        }
//
//        // 4️⃣ Age validation (must be at least 18)
//        int currentYear = Year.now().getValue();
//        if ((currentYear - dto.getBirthYear()) < 18) {
//            request.setAttribute("error", "You must be at least 18 years old to register.");
//            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
//                   .forward(request, response);
//            return;
//        }
//
//        // 5️⃣ Create User entity
//        User newUser = new User();
//        newUser.setFirstName(dto.getFirstName());
//        newUser.setLastName(dto.getLastName());
//        newUser.setEmail(dto.getEmail());
//        newUser.setPasswordHash(dto.getPassword()); // assuming service handles hashing
//        newUser.setBirthYear(dto.getBirthYear());
//        newUser.setState(dto.getState());
//        newUser.setCountry(dto.getCountry());
//        newUser.setRole(Role.VOTER);
//        newUser.setEmailVerified(false);
//
//        // 6️⃣ Get EntityManager
//        EntityManager em = JPAUtil.getEntityManager();
//        boolean success;
//        try {
//            UserService service = new UserServiceImpl(em);
//            success = service.registerUser(newUser);
//        } finally {
//            em.close(); // always close
//        }
//
//        // 7️⃣ Handle result
//        if (success) {
//            response.sendRedirect("login");
//        } else {
//            request.setAttribute("error", "Email already exists!");
//            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
//                   .forward(request, response);
//        }
//    }
//}


package com.bascode.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Set;

import com.bascode.dto.UserRequest;
import com.bascode.model.entity.User;
import com.bascode.model.enums.Role;
import com.bascode.services.UserService;
import com.bascode.services.UserServiceImpl;
import com.bascode.util.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserRequest dto = new UserRequest();
        dto.setFirstName(request.getParameter("firstName"));
        dto.setLastName(request.getParameter("lastName"));
        dto.setEmail(request.getParameter("email").trim().toLowerCase());
        dto.setPassword(request.getParameter("password"));
        dto.setConfirmPassword(request.getParameter("confirmPassword"));

        String birthDateStr = request.getParameter("birthDate");
        LocalDate birthDate = null;
        try {
            birthDate = LocalDate.parse(birthDateStr);
        } catch (Exception e) {
            request.setAttribute("error", "Invalid birth date format. Use YYYY-MM-DD.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                   .forward(request, response);
            return;
        }
        dto.setBirthDate(birthDate);

        dto.setState(request.getParameter("state"));
        dto.setCountry(request.getParameter("country"));

        // Bean Validation
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<UserRequest>> violations = validator.validate(dto);

        if (!violations.isEmpty()) {
            request.setAttribute("errors", violations);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                   .forward(request, response);
            return;
        }

        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                   .forward(request, response);
            return;
        }

        LocalDate today = LocalDate.now();
        if (dto.getBirthDate().plusYears(18).isAfter(today)) {
            request.setAttribute("error", "You must be at least 18 years old to register.");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                   .forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setFirstName(dto.getFirstName());
        newUser.setLastName(dto.getLastName());
        newUser.setEmail(dto.getEmail());
        newUser.setPasswordHash(dto.getPassword());
        newUser.setBirthDate(dto.getBirthDate());
        newUser.setState(dto.getState());
        newUser.setCountry(dto.getCountry());
        newUser.setRole(Role.VOTER);
        newUser.setEmailVerified(false);

        EntityManager em = JPAUtil.getEntityManager();

        try {
            UserService service = new UserServiceImpl(em);
            service.registerUser(newUser);

            // Success
            response.sendRedirect("verify");

        } catch (RuntimeException e) {
            if ("USER_EXISTS".equals(e.getMessage())) {
                request.setAttribute("error", "User already registered!");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
            }
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                   .forward(request, response);

        } finally {
            if (em.isOpen()) em.close();
        }
    }
}