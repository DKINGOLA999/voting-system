package com.bascode.util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailService {

    private static final String FROM_EMAIL = "ihannahekundayo@gmail.com";
    private static final String APP_PASSWORD = "dirw duve ikvf gjex";

    // Helper method to wrap content in a nice HTML/CSS frame
    private static String getHtmlTemplate(String title, String message, String code) {
        return "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 8px; overflow: hidden;'>" +
                "  <div style='background-color: #007bff; color: white; padding: 20px; text-align: center;'>" +
                "    <h1 style='margin: 0; font-size: 24px;'>Online Voting System</h1>" +
                "  </div>" +
                "  <div style='padding: 30px; line-height: 1.6; color: #333;'>" +
                "    <h2 style='color: #007bff;'>" + title + "</h2>" +
                "    <p>" + message + "</p>" +
                "    <div style='text-align: center; margin: 30px 0;'>" +
                "      <span style='background-color: #f8f9fa; border: 2px dashed #007bff; padding: 15px 30px; font-size: 28px; font-weight: bold; letter-spacing: 5px; color: #007bff; border-radius: 5px;'>" + code + "</span>" +
                "    </div>" +
                "    <p>If you didn't request this, please ignore this email.</p>" +
                "  </div>" +
                "  <div style='background-color: #f1f1f1; padding: 15px; text-align: center; font-size: 12px; color: #777;'>" +
                "    &copy; 2024 Online Voting System. All Rights Reserved." +
                "  </div>" +
                "</div>";
    }

    public static void sendVerificationEmail(String toEmail, String code) {
        String title = "Verify Your Account";
        String message = "Welcome! Thank you for joining the Online Voting System. Please use the verification code below to activate your account:";
        String htmlBody = getHtmlTemplate(title, message, code);
        
        sendEmail(toEmail, "Verify Your Account", htmlBody);
    }

    public static void sendPasswordResetEmail(String toEmail, String otp) {
        String title = "Password Reset Request";
        String message = "We received a request to reset your password. Use the following OTP to proceed with the reset:";
        String htmlBody = getHtmlTemplate(title, message, otp);

        sendEmail(toEmail, "Password Reset", htmlBody);
    }

    public static void sendResendOtpEmail(String toEmail, String otp) {
        String title = "New Verification Code";
        String message = "As requested, here is your new verification code for the Online Voting System:";
        String htmlBody = getHtmlTemplate(title, message, otp);

        sendEmail(toEmail, "New OTP Received", htmlBody);
    }

    public static void sendEmail(String toEmail, String subject, String htmlContent) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Trust Gmail explicitly

        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // CRITICAL CHANGE: Use setContent with "text/html" instead of setText
            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("OTP Code sent successfully to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException("Error sending email: " + e.getMessage());
        }
    }
}
