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
    private ProjectEmployeeRepo projectEmployeeRepo;

    @EventListener
    public void appReady(ApplicationReadyEvent event) {
        employeeRepo.deleteAll();
        employeeRepo.saveAll(List.of(
                new EmployeeDto("admin", "admin", "john.joey@tcs.com",
                        "john joey", 4, 6, "TCS - Goa", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", true),
                new EmployeeDto("emp-2332332", "12354", "blob.byne@tcs.com",
                        "blob byne", 6, 0, "TCS - Mumbai", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false),
                new EmployeeDto("emp-273698646", "12354", "alice.ar@tcs.com",
                        "alice ar", 3, 8, "TCS - Nagpur", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false),
                new EmployeeDto("emp-9876372", "12354", "wells.white@tcs.com",
                        "wells white", 10, 3, "TCS - Mumbai", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false),
                new EmployeeDto("emp-03843984", "12354", "micheal.est@tcs.com",
                        "micheal est", 0, 6, "TCS - Nagpur", "GG VII - STP",
                        "Cloud", "GOOGLE", "", "java", false)

        ));
        projectRepo.deleteAll();
        projectRepo.saveAll(List.of(
                new ProjectDTO("2328356", "sita", "Manager1", "Hobby Project",
                        List.of("Java", "Spring", "Hibernates", "Docker"), "5 Years", "APOL - Hyderabad",
                        "Hyderabad - Non STP", "Cloud", "GOOGLE"),
                new ProjectDTO("2332332", "amex", "Manager2", "AMEX Project",
                        List.of("#NET", "asp", "Database", "Docker"), "2 Years", "TCS - Indore",
                        "Indore - Unit 1 - SEZ", "Cloud", "GOOGLE"),
                new ProjectDTO("273698646", "clinton", "Manager3", "Clinton Project",
                        List.of("BigData", "AWS", "ML", "AI"), "5 Years", "TCS - Bangalore",
                        "Bangalore - Salarpuria - STP", "Cloud", "GOOGLE"),
                new ProjectDTO("9876372", "dcs", "Manager4", "DCS Project",
                        List.of("Java", "Spring", "AWS", "Elastic"), "8 Years", "TCS - Chennai",
                        "Chennai-Velachery Centre - STP", "Cloud", "GOOGLE"),
                new ProjectDTO("03843984", "gsl", "Manager5", "GSL Project",
                        List.of("Java", "Spring", "Hibernates", "AWS"), "temporary", "TCS - Kochi",
                        "Kochi - Non-STP", "Cloud", "GOOGLE")
        ));

        locationRepo.deleteAll();
        locationRepo.saveAll(List.of(
                new LocationDTO("APOL - Hyderabad"),
                new LocationDTO("CEDG - Mumbai"),
                new LocationDTO("TCS - Ahmedabad"),
                new LocationDTO("TCS - Bangalore"),
                new LocationDTO("TCS - Bhopal"),
                new LocationDTO("TCS - Bhubaneswar"),
                new LocationDTO("TCS - Chennai"),
                new LocationDTO("TCS - Coimbatore"),
                new LocationDTO("TCS - Goa"),
                new LocationDTO("TCS - Hyderabad"),
                new LocationDTO("TCS - Indore"),
                new LocationDTO("TCS - Jamshedpur"),
                new LocationDTO("TCS - Kochi"),
                new LocationDTO("TCS - Kolkata"),
                new LocationDTO("TCS - Lucknow"),
                new LocationDTO("TCS - Mumbai"),
                new LocationDTO("TCS - Nagpur"),
                new LocationDTO("TCS - New Delhi"),
                new LocationDTO("TCS - Pune"),
                new LocationDTO("TCS - Trivandrum"),
                new LocationDTO("TCS - Vadodara"),
                new LocationDTO("TCS - Varanasi"),
                new LocationDTO("TCS e-Serve IL - Ahmedabad"),
                new LocationDTO("TCS e-Serve IL - Chennai"),
                new LocationDTO("TCS e-Serve IL - Kolkata"),
                new LocationDTO("TCS e-Serve IL - Mumbai"),
                new LocationDTO("TCS e-Serve IL - New Delhi"),
                new LocationDTO("TCS e-Serve IL - Pune")));
        buildingRepo.deleteAll();
        buildingRepo.saveAll(List.of(new BuildingDTO("Abhilash - STP"),
                new BuildingDTO("Adibatla - SEZ"),
                new BuildingDTO("Adibatla - Unit 1 - SEZ"),
                new BuildingDTO("Adibatla - Unit 2 - SEZ"),
                new BuildingDTO("Ahmedabad - Kalpak - Non STP"),
                new BuildingDTO("Akruti Trade Centre - STP"),
                new BuildingDTO("Andheri(Suren Road) - STP"),
                new BuildingDTO("APOL - Hyderabad Non STP"),
                new BuildingDTO("Bangalore - SJM Towers - STP"),
                new BuildingDTO("Bangalore - Think Campus BPO/ITIS STP"),
                new BuildingDTO("Bangalore - Vydehi RC-1 Block - Non STP"),
                new BuildingDTO("Banyan Park-STP"),
                new BuildingDTO("Bhubaneswar-AUM-Non STP"),
                new BuildingDTO("Bhubaneswar-Barabati-SEZ"),
                new BuildingDTO("Bhubaneswar-IT Park-SEZ"),
                new BuildingDTO("BLR-Global Axis H Block-SEZ"),
                new BuildingDTO("BLR-Prestige Shantiniketan-Crescent 3-NSTP"),
                new BuildingDTO("Borivali-Non STP"),
                new BuildingDTO("CEDG-Vikhroli Non STP"),
                new BuildingDTO("Cerebrum IT Park-Non STP"),
                new BuildingDTO("Chandigarh-Non STP"),
                new BuildingDTO("Chennai - EB2 - Siruseri - Unit 2 - SEZ"),
                new BuildingDTO("Chennai - EB3 - Siruseri - Unit 2 - SEZ"),
                new BuildingDTO("Chhattisgarh-Non STP"),
                new BuildingDTO("CMC - Bangalore - Non STP"),
                new BuildingDTO("CMC - Bhilai - Non STP"),
                new BuildingDTO("CMC - Chandigarh - Non STP"),
                new BuildingDTO("Herald House - Non STP"),
                new BuildingDTO("HP Centre - Non STP"),
                new BuildingDTO("Hyderabad - JST - STP"),
                new BuildingDTO("Hyderabad ILP Centre - Non STP"),
                new BuildingDTO("Indore - SEZ"),
                new BuildingDTO("Indore - Unit 1 - SEZ"),
                new BuildingDTO("International Tech Park - Cypress - SEZ"),
                new BuildingDTO("Jamshedpur - Non STP"),
                new BuildingDTO("Jamshedpur- Sakchi - Non STP"),
                new BuildingDTO("Kerala PSK Non STP"),
                new BuildingDTO("Kochi - Non-STP"),
                new BuildingDTO("Kochi - Vismaya STP"),
                new BuildingDTO("Kohinor Park - STP"),
                new BuildingDTO("Kolkata - Gitanjali Park - SEZ"),
                new BuildingDTO("Kolkata-WEBEL Building - STPII"),
                new BuildingDTO(" Lucknow (Gomti Nagar) - STP"),
                new BuildingDTO(" Madhapur - STP"),
                new BuildingDTO(" Mahape - STP")));
        platformRepo.deleteAll();
        platformRepo.saveAll(List.of(
                new PrimarySkillsDTO("API Platform", List.of("RedHat", "Scale", "API Connect", "APIgee", "Dell Boomi", "Kong API Platform", "Mulesoft", "WSO2 OpenSource", "Zuul API Platform")),
                new PrimarySkillsDTO("Automation", List.of("Ansible", "Chef", "Puppet", "Terraform", "CFEngine", "Python", "Json", "Shell", "Power Shell")),
                new PrimarySkillsDTO("Batch", List.of("Automic",
                        "Autosys",
                        "CA7",
                        "ControlM",
                        "ESP",
                        "TWS")),
                new PrimarySkillsDTO("BigData", List.of("Hadoop",
                        "NoSql",
                        "Kafka",
                        "Spark")),
                new PrimarySkillsDTO("Blockchain Platform", List.of("Corda",
                        "Ethereum",
                        "Hyperledger",
                        "Quorum")),
                new PrimarySkillsDTO("Cloud", List.of("AZURE",
                        "AWS",
                        "GOOGLE")),
                new PrimarySkillsDTO("Command Center", List.of("Command Center Mgmt",
                        "IoT CC Mgmt"))));
        projectEmployeeRepo.deleteAll();
        projectEmployeeRepo.saveAll(List.of(new ProjectEmployee("2328356",
                        List.of("emp-2332332"), List.of("emp-2332332", "emp-9876372", "emp-03843984"), List.of()),
                new ProjectEmployee("273698646",
                        List.of("emp-9876372", "emp-03843984"), List.of("emp-2332332", "emp-9876372", "emp-03843984", "emp-273698646"), List.of()),
                new ProjectEmployee("9876372",
                        List.of("emp-9876372", "emp-273698646"), List.of("emp-273698646", "emp-9876372"), List.of()),
                new ProjectEmployee("2332332",
                        List.of("emp-9876372"), List.of("emp-273698646", "emp-9876372"), List.of()),
                new ProjectEmployee("03843984",
                        List.of(), List.of("emp-273698646"), List.of())));


    }


}