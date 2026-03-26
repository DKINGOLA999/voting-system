package com.bascode.dto;

import java.time.LocalDate;

/*
 DTO (Data Transfer Object)

 This class represents the data sent from the frontend
 (JSP forms) to the backend.

 We do NOT expose the User entity directly in the controller
 because DTOs provide:

 - cleaner architecture
 - separation between database model and API request
 - validation layer possibility

 The RegisterServlet will receive form parameters
 and map them into this DTO.
*/

public class UserRequest {

    private String firstName;
    private String lastName;
    private String email;

    private String password;
    private String confirmPassword;

    private LocalDate birthDate;
    private String state;
    private String country;

    // ===== getters and setters =====

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}