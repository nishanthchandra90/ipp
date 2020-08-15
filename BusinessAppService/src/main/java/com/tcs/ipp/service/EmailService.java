package com.tcs.ipp.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class EmailService {

    private static final JavaMailSender emailSender = new JavaMailSenderImpl();

    @Value("${spring.mail.username}")
    private String from;


    public int sendOTP(String emailId) {

        int otp = getOTP();
        System.out.println("Sending email to " + emailId);
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(emailId);
        message.setSubject("<No-Reply>: Email verification OTP");
        message.setText("This is an email by TCS internal job portal. " +
                "Please enter the below 5-Digit in the App to Sign Up.\n" + otp);
        try {
            emailSender.send(message);
            return otp;
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    private int getOTP() {
        return 10484 + new Random().nextInt(99999);
    }
}
