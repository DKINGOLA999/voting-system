package com.bascode.services;

import java.util.List;

import com.bascode.model.entity.User;

public interface UserService {
    boolean registerUser(User user);           // Register & send verification email
    User login(String email, String password); // Login with verification check
    boolean verifyEmail(String email, String code); // Verify OTP
    boolean resendOtp(String email);           // Resend verification OTP
    boolean initiatePasswordReset(String email); // Send OTP to reset password
    boolean resetPassword(String email, String code, String newPassword); // Reset password using OTP

    // Voting and contest logic
    boolean registerContester(User user, com.bascode.model.enums.Position position, String manifesto);
    boolean withdrawContester(User user);
    boolean voteForContester(User voter, Long contesterId);
    boolean hasUserVoted(User voter);
    boolean isUserContester(User user);
    com.bascode.model.enums.ContesterStatus getContesterStatus(User user);
    java.util.List<com.bascode.model.entity.Contester> getApprovedContesters();
    long countVotesForContester(com.bascode.model.entity.Contester contester);
    boolean updateProfile(User user, String firstName, String lastName, String newPassword);
    boolean changePassword(User user, String currentPassword, String newPassword);

    List<User> getAllUsers();
    // Election management
    com.bascode.model.entity.Election getCurrentElection();
    boolean setElectionDates(java.time.LocalDateTime start, java.time.LocalDateTime end);
    boolean startElection();
    boolean endElection();
    java.util.Map<com.bascode.model.enums.Position, java.util.List<com.bascode.model.entity.Contester>> getElectionResults();
}