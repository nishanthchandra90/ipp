package com.tcs.ipp.controller;

import com.tcs.ipp.model.EmployeeDto;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.repository.EmployeeRepo;
import com.tcs.ipp.repository.ProjectRepo;
import com.tcs.ipp.service.AppliedProjectsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class IPPEmployeeController {

    @Autowired
    private EmployeeRepo employeeRepo;


    @Autowired
    private ProjectRepo projectsRepo;

    @Autowired
    private AppliedProjectsRepo appliedProjectsRepo;


    @GetMapping("/getAllEmployees")
    public List<EmployeeDto> getAllEmployees() {
        System.out.println("Sending all employees as response...");
        return employeeRepo.findAll();
    }

    @GetMapping("/getEmployeeByName")
    public EmployeeDto getEmployeeByName(@RequestParam String name) {
        System.out.println("Getting Employee with email:" + name);
        return employeeRepo.findByEmployeeName(name);

    }

    @GetMapping("/getEmployeeByEmail")
    public EmployeeDto getEmployeeByEmail(@RequestParam String email) {
        System.out.println("Getting Employee with email:" + email);
        return employeeRepo.findByEmail(email);

    }

    @GetMapping("/getEmployeeById")
    public EmployeeDto getEmployeeById(@RequestParam String empId) {
        System.out.println("Getting Employee with Id:" + empId);
        return employeeRepo.findById(empId).orElse(null);
    }

    @GetMapping("/getAppliedProjects")
    public List<ProjectDTO> getAppliedProjectsById(@RequestParam String empId) {
        System.out.println("Getting Projects applied by Employee with Id:" + empId);
        return appliedProjectsRepo.getAppliedProjectByEmpId(empId).stream()
                .map(p -> projectsRepo.findById(p).orElse(null)).collect(Collectors.toList());
    }

    @GetMapping("/getMatchedProjects")
    public List<ProjectDTO> getMatchedProjects(@RequestParam String empId) {
        System.out.println("Getting Projects matching with Employee skills for Employee:" + empId);
        return appliedProjectsRepo.getMyMatchedProjects(empId).stream()
                .map(p -> projectsRepo.findById(p).orElse(null)).collect(Collectors.toList());
    }

}
