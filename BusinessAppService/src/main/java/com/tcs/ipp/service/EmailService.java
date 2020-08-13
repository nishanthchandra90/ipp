package com.tcs.ipp.service;

import java.util.Properties;

public class EmailService {
    public void sendOTP(String emailId) {

        System.out.println("Sending email to " + emailId);
        // Recipient's email ID needs to be mentioned.
        String to = "abcd@gmail.com";

        // Sender's email ID needs to be mentioned
        String from = "web@gmail.com";

        // Assuming you are sending email from localhost
        System.out.println("SimpleEmail Start");

        String smtpHostServer = "smtp.example.com";
        String emailID = "email_me@example.com";

        Properties props = System.getProperties();

        props.put("mail.smtp.host", smtpHostServer);


    }
}
