package com.tcs.ipp.service;

import com.tcs.ipp.model.EmployeeDto;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.repo.ProjectsRepo;
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
                new EmployeeDto("EMP-2328356", "Admin", "john.joey@tcs.com", true),
                new EmployeeDto("EMP-2332332", "Blob", "blob.byne@tcs.com", false),
                new EmployeeDto("EMP-273698646", "Alice", "alice.ar@tcs.com", false),
                new EmployeeDto("EMP-9876372", "Wells", "wells.white@tcs.com", false),
                new EmployeeDto("EMP-03843984", "Micheal", "micheal.est@tcs.com", false)

        ));

        projectRepo.saveAll(List.of(
                new ProjectDTO("Project-2328356", "SITA", "Manager1", "Hobby Project",
                        List.of("Java", "Spring", "Hibernates", "Docker"), "5 Years"),
                new ProjectDTO("Project-2332332", "AMEX", "Manager2", "AMEX Project",
                        List.of("#NET", "asp", "Database", "Docker"), "2 Years"),
                new ProjectDTO("Project-273698646", "Clinton", "Manager3", "Clinton Project",
                        List.of("BigData", "AWS", "ML", "AI"), "5 Years"),
                new ProjectDTO("Project-9876372", "DCS", "Manager4", "DCS Project",
                        List.of("Java", "Spring", "AWS", "Elastic"), "8 Years"),
                new ProjectDTO("Project-03843984", "GSL", "Manager5", "GSL Project",
                        List.of("Java", "Spring", "Hibernates", "AWS"), "temporary")
        ));

    }
}