package com.tcs.ipp.service;

import com.tcs.ipp.model.*;
import com.tcs.ipp.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DemoData {

    @Autowired
    private EmployeeRepo employeeRepo;

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private LocationRepo locationRepo;

    @Autowired
    private BuildingRepo buildingRepo;

    @Autowired
    private PlatformRepo platformRepo;

    @Autowired
    private CandidateApplicationRepo candidateApplicationRepo;

    @EventListener
    public void appReady(ApplicationReadyEvent event) {
        employeeRepo.deleteAll();
        employeeRepo.saveAll(List.of(
                new Employee("admin", "admin", "john.joey@tcs.com",
                        "john joey", 4, 6, "TCS - Goa", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", true),
                new Employee("emp-2332332", "12345", "blob.byne@tcs.com",
                        "blob byne", 6, 0, "TCS - Mumbai", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false),
                new Employee("emp-273698646", "12345", "alice.ar@tcs.com",
                        "alice ar", 3, 8, "TCS - Nagpur", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false),
                new Employee("emp-9876372", "12345", "wells.white@tcs.com",
                        "wells white", 10, 3, "TCS - Mumbai", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false),
                new Employee("emp-03843984", "12345", "micheal.est@tcs.com",
                        "micheal est", 0, 6, "TCS - Nagpur", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false)

        ));


        projectRepo.deleteAll();
        projectRepo.saveAll(List.of(
                new Project("2328356", "sita", "Manager1", "Hobby Project",
                        "Solution Architect", "2 Years & More", "APOL - Hyderabad",
                        "Hyderabad - Non STP", "Cloud", "GOOGLE"),
                new Project("2332332", "amex", "Manager2", "AMEX Project",
                        "Project Management", "1-3 Months", "TCS - Indore",
                        "Indore - Unit 1 - SEZ", "Cloud", "GOOGLE"),
                new Project("273698646", "clinton", "Manager3", "Clinton Project",
                        "Migration Expert", "6-12 Months", "TCS - Bangalore",
                        "Bangalore - Salarpuria - STP", "Cloud", "GOOGLE"),
                new Project("9876372", "dcs", "Manager4", "DCS Project",
                        "Design & Implementation", "3-6 Months", "TCS - Chennai",
                        "Chennai-Velachery Centre - STP", "Cloud", "GOOGLE"),
                new Project("03843984", "gsl", "Manager5", "GSL Project",
                        "Project Management", "2 Years & More", "TCS - Kochi",
                        "Kochi - Non-STP", "Cloud", "GOOGLE")
        ));

        locationRepo.deleteAll();
        locationRepo.saveAll(List.of(
                new Location("APOL - Hyderabad"),
                new Location("CEDG - Mumbai"),
                new Location("TCS - Ahmedabad"),
                new Location("TCS - Bangalore"),
                new Location("TCS - Bhopal"),
                new Location("TCS - Bhubaneswar"),
                new Location("TCS - Chennai"),
                new Location("TCS - Coimbatore"),
                new Location("TCS - Goa"),
                new Location("TCS - Hyderabad"),
                new Location("TCS - Indore"),
                new Location("TCS - Jamshedpur"),
                new Location("TCS - Kochi"),
                new Location("TCS - Kolkata"),
                new Location("TCS - Lucknow"),
                new Location("TCS - Mumbai"),
                new Location("TCS - Nagpur"),
                new Location("TCS - New Delhi"),
                new Location("TCS - Pune"),
                new Location("TCS - Trivandrum"),
                new Location("TCS - Vadodara"),
                new Location("TCS - Varanasi"),
                new Location("TCS e-Serve IL - Ahmedabad"),
                new Location("TCS e-Serve IL - Chennai"),
                new Location("TCS e-Serve IL - Kolkata"),
                new Location("TCS e-Serve IL - Mumbai"),
                new Location("TCS e-Serve IL - New Delhi"),
                new Location("TCS e-Serve IL - Pune")));
        buildingRepo.deleteAll();
        buildingRepo.saveAll(List.of(new Building("Abhilash - STP"),
                new Building("Adibatla - SEZ"),
                new Building("Adibatla - Unit 1 - SEZ"),
                new Building("Adibatla - Unit 2 - SEZ"),
                new Building("Ahmedabad - Kalpak - Non STP"),
                new Building("Akruti Trade Centre - STP"),
                new Building("Andheri(Suren Road) - STP"),
                new Building("APOL - Hyderabad Non STP"),
                new Building("Bangalore - SJM Towers - STP"),
                new Building("Bangalore - Think Campus BPO/ITIS STP"),
                new Building("Bangalore - Vydehi RC-1 Block - Non STP"),
                new Building("Banyan Park-STP"),
                new Building("Bhubaneswar-AUM-Non STP"),
                new Building("Bhubaneswar-Barabati-SEZ"),
                new Building("Bhubaneswar-IT Park-SEZ"),
                new Building("BLR-Global Axis H Block-SEZ"),
                new Building("BLR-Prestige Shantiniketan-Crescent 3-NSTP"),
                new Building("Borivali-Non STP"),
                new Building("CEDG-Vikhroli Non STP"),
                new Building("Cerebrum IT Park-Non STP"),
                new Building("Chandigarh-Non STP"),
                new Building("Chennai - EB2 - Siruseri - Unit 2 - SEZ"),
                new Building("Chennai - EB3 - Siruseri - Unit 2 - SEZ"),
                new Building("Chhattisgarh-Non STP"),
                new Building("CMC - Bangalore - Non STP"),
                new Building("CMC - Bhilai - Non STP"),
                new Building("CMC - Chandigarh - Non STP"),
                new Building("Herald House - Non STP"),
                new Building("HP Centre - Non STP"),
                new Building("Hyderabad - JST - STP"),
                new Building("Hyderabad ILP Centre - Non STP"),
                new Building("Indore - SEZ"),
                new Building("Indore - Unit 1 - SEZ"),
                new Building("International Tech Park - Cypress - SEZ"),
                new Building("Jamshedpur - Non STP"),
                new Building("Jamshedpur- Sakchi - Non STP"),
                new Building("Kerala PSK Non STP"),
                new Building("Kochi - Non-STP"),
                new Building("Kochi - Vismaya STP"),
                new Building("Kohinor Park - STP"),
                new Building("Kolkata - Gitanjali Park - SEZ"),
                new Building("Kolkata-WEBEL Building - STPII"),
                new Building(" Lucknow (Gomti Nagar) - STP"),
                new Building(" Madhapur - STP"),
                new Building(" Mahape - STP")));
        platformRepo.deleteAll();
        platformRepo.saveAll(List.of(
                new PrimarySkill("API Platform", List.of("RedHat", "Scale", "API Connect", "APIgee", "Dell Boomi", "Kong API Platform", "Mulesoft", "WSO2 OpenSource", "Zuul API Platform")),
                new PrimarySkill("Automation", List.of("Ansible", "Chef", "Puppet", "Terraform", "CFEngine", "Python", "Json", "Shell", "Power Shell")),
                new PrimarySkill("Batch", List.of("Automic",
                        "Autosys",
                        "CA7",
                        "ControlM",
                        "ESP",
                        "TWS")),
                new PrimarySkill("BigData", List.of("Hadoop",
                        "NoSql",
                        "Kafka",
                        "Spark")),
                new PrimarySkill("Blockchain Platform", List.of("Corda",
                        "Ethereum",
                        "Hyperledger",
                        "Quorum")),
                new PrimarySkill("Cloud", List.of("AZURE",
                        "AWS",
                        "GOOGLE")),
                new PrimarySkill("Command Center", List.of("Command Center Mgmt",
                        "IoT CC Mgmt"))));
        candidateApplicationRepo.deleteAll();
        candidateApplicationRepo.saveAll(List.of(new CandidateApplication("2328356",
                        List.of("emp-2332332"), List.of("emp-2332332", "emp-9876372", "emp-03843984"), List.of()),
                new CandidateApplication("273698646",
                        List.of("emp-9876372", "emp-03843984"), List.of("emp-2332332", "emp-9876372", "emp-03843984", "emp-273698646"), List.of()),
                new CandidateApplication("9876372",
                        List.of("emp-9876372", "emp-273698646"), List.of("emp-273698646", "emp-9876372"), List.of()),
                new CandidateApplication("2332332",
                        List.of("emp-9876372"), List.of("emp-273698646", "emp-9876372"), List.of()),
                new CandidateApplication("03843984",
                        List.of(), List.of("emp-273698646"), List.of())));


    }


}