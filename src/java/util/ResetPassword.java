/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeUtility;
import java.security.SecureRandom;
import java.util.Properties;

/**
 *
 * @author ToiLaDuyGitHub
 */
public class ResetPassword {

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int LENGTH = 8; // Độ dài chuỗi là 6 ký tự

    public static String generateRandomString() {
        SecureRandom random = new SecureRandom();
        StringBuilder stringBuilder = new StringBuilder(LENGTH);

        for (int i = 0; i < LENGTH; i++) {
            int randomIndex = random.nextInt(CHARACTERS.length());
            stringBuilder.append(CHARACTERS.charAt(randomIndex));
        }

        return stringBuilder.toString();
    }

    // Gửi email với chuỗi ngẫu nhiên
    public static void sendEmail(String toEmail, String randomString) {
        String host = "smtp.gmail.com";
        String fromEmail = "quanlyvattu.fms@gmail.com";
        String password = "mkisisvjsmpdsfhk";
        String senderName = "Hệ thống Quản lý Vật tư - Facilities Management System (FMS)";

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, senderName, "UTF-8")); // Thêm charset
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            String subject = "🔑 Password Recovery";
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

            // HTML Template siêu đẹp
            String htmlContent = """
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <style>
                    body { 
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
                        margin: 0; 
                        padding: 0; 
                        background-color: #f5f9fc;
                    }
                    .email-container {
                        max-width: 600px;
                        margin: 20px auto;
                        background: linear-gradient(135deg, #f0fff4 0%, #e6ffed 100%);
                        border-radius: 10px;
                        overflow: hidden;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                    }
                    .header {
                        background: linear-gradient(135deg, #48bb78 0%, #81e6d9 100%);
                        padding: 30px 20px;
                        text-align: center;
                        color: white;
                    }
                    .logo-container {
                        width: 100px;
                        height: 100px;
                        margin: 0 auto 15px;
                        border-radius: 50%;
                        background-color: white;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        overflow: hidden;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    }
                    .logo-img {
                        width: 100%;
                        height: auto;
                        object-fit: cover;
                    }
                    
                    .content {
                        padding: 30px;
                        color: #333;
                    }
                    
                    .otp-box {
                        background: white;
                        border-radius: 8px;
                        padding: 15px;
                        margin: 25px 0;
                        text-align: center;
                        font-size: 28px;
                        font-weight: bold;
                        color: #0072ff;
                        border: 2px dashed #0072ff;
                    }
                    
                    .footer {
                        text-align: center;
                        padding: 20px;
                        font-size: 12px;
                        color: #7f8c8d;
                        background-color: #f0f7ff;
                    }
                    
                    .note {
                        font-size: 14px;
                        color: #666;
                        margin-top: 20px;
                        padding: 10px;
                        background-color: #f8f8f8;
                        border-left: 4px solid #0072ff;
                    }
                </style>
            </head>
            <body>
                <div class="email-container">
                    <div class="header">
                        <div class="logo-container">
                            <img src="https://images.emojiterra.com/google/android-12l/512px/1f3d7.png" class="logo-img" alt="FMS Logo">
                        </div>
                        <h1>Facilities Management System (FMS)</h1>
                    </div>
                        
                    <div class="content">
                        <p>Hello,</p>
                        <p>You have requested a password reset from our system. Please use the following NEW password:</p>
                        
                        <div class="otp-box">
                            {OTP}
                        </div>
                        
                        <p>This OTP is valid for <strong>5 minutes</strong>. For account security:</p>
                        <ul>
                            <li>Do not share this password with anyone</li>
                            <li>Delete this email after use</li>
                        </ul>
                        
                        <div class="note">
                            <p>If you didn't request this password, please ignore this email or contact support.</p>
                        </div>
                    </div>
                    
                    <div class="footer">
                        <p>© 2025 Facilities Management System (FMS)</p>
                        <p>This is an automated email, please do not reply</p>
                    </div>
                </div>
            </body>
            </html>
            """.replace("{OTP}", randomString);

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
            System.out.println("Email đã gửi thành công tới " + toEmail);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi gửi email: " + e.getMessage(), e);
        }
    }

    public static void main(String[] args) {
        String otp = generateRandomString();
        sendEmail("toiladuygg@gmail.com", otp);
    }
}
