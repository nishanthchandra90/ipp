package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "otp")

public class OTPDTO {

    @Id
    private String email;

    private int otp;

    public OTPDTO(String email, int otp) {
        this.email = email;
        this.otp = otp;
    }

    public String getEmail() {
        return email;
    }

    public int getOtp() {
        return otp;
    }

    @Override
    public String toString() {
        return "OTPDTO{" +
                "email='" + email + '\'' +
                ", otp=" + otp +
                '}';
    }
}
