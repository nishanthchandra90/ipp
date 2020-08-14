package com.tcs.ipp;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ProjectManagementApp {

    public static void main(String[] args) {
        System.setProperty("spring.config.name", "application");

        SpringApplication.run(ProjectManagementApp.class, args);
    }
}
