package com.tcs.ipp.service;

import com.tcs.ipp.model.EmployeeDto;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.repository.EmployeeRepo;
import com.tcs.ipp.repository.ProjectRepo;
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

    @EventListener
    public void appReady(ApplicationReadyEvent event) {

        employeeRepo.saveAll(List.of(
                new EmployeeDto("emp-2328356", "admin", "john.joey@tcs.com", true),
                new EmployeeDto("emp-2332332", "blob", "blob.byne@tcs.com", false),
                new EmployeeDto("emp-273698646", "alice", "alice.ar@tcs.com", false),
                new EmployeeDto("emp-9876372", "wells", "wells.white@tcs.com", false),
                new EmployeeDto("emp-03843984", "micheal", "micheal.est@tcs.com", false)

        ));

        projectRepo.saveAll(List.of(
                new ProjectDTO("project-2328356", "sita", "Manager1", "Hobby Project",
                        List.of("Java", "Spring", "Hibernates", "Docker"), "5 Years"),
                new ProjectDTO("project-2332332", "amex", "Manager2", "AMEX Project",
                        List.of("#NET", "asp", "Database", "Docker"), "2 Years"),
                new ProjectDTO("project-273698646", "clinton", "Manager3", "Clinton Project",
                        List.of("BigData", "AWS", "ML", "AI"), "5 Years"),
                new ProjectDTO("project-9876372", "dcs", "Manager4", "DCS Project",
                        List.of("Java", "Spring", "AWS", "Elastic"), "8 Years"),
                new ProjectDTO("project-03843984", "gsl", "Manager5", "GSL Project",
                        List.of("Java", "Spring", "Hibernates", "AWS"), "temporary")
        ));

    }
}