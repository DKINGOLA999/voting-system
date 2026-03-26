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

    // IMPORTANT: Generate a NEW App Password and put it here
    private static final String FROM_EMAIL = "davidolawore6@gmail.com";
    private static final String APP_PASSWORD = "jdzq agei wtif jsbc"; // Replace with actual Gmail App Password 

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
        sendEmail(toEmail, "Verify Your Account", getHtmlTemplate("Verify Your Account", "Welcome! Please use the code below to activate your account:", code));
    }

    public static void sendPasswordResetEmail(String toEmail, String otp) {
        sendEmail(toEmail, "Password Reset", getHtmlTemplate("Password Reset Request", "Use the following OTP to proceed with the reset:", otp));
    }

    public static void sendResendOtpEmail(String toEmail, String otp) {
        sendEmail(toEmail, "New Verification Code", getHtmlTemplate("New Verification Code", "As requested, here is your new verification code:", otp));
    }

    public static void sendEmail(String toEmail, String subject, String htmlContent) {
        Properties props = new Properties();
        
        // Use Port 465 for SSL (More likely to bypass network blocks)
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        
        // SSL specific settings
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        // Timeouts to prevent the app from hanging
        props.put("mail.smtp.connectiontimeout", "10000"); // 10 seconds
        props.put("mail.smtp.timeout", "10000");           // 10 seconds

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
            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Email sent successfully via Port 465 to " + toEmail);

        } catch (MessagingException e) {
            System.err.println("SMTP Error: " + e.getMessage());
            throw new RuntimeException("Failed to send email. Check network or App Password.");
        }
    }
}