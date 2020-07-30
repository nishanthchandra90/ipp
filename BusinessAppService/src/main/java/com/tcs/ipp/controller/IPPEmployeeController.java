package com.tcs.ipp.controller;

import com.tcs.ipp.model.EmployeeDto;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.service.AppliedProjectsRepo;
import com.tcs.ipp.service.EmployeesRepo;
import com.tcs.ipp.service.ProjectsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class IPPEmployeeController {
    @Autowired
    private EmployeesRepo employeeRepo;

    @Autowired
    private ProjectsRepo projectsRepo;

    @Autowired
    private AppliedProjectsRepo appliedProjectsRepo;

    @GetMapping("/getAllEmployees")
    public List<EmployeeDto> getAllEmployees() {
        System.out.println("Sending all employees as response...");
        return employeeRepo.getAllEmployees();
    }

    @GetMapping("/getEmployeeByEmailName")
    public EmployeeDto getEmployee(@RequestParam String emailOrName) {
        System.out.println("Getting Employee with name/email:" + emailOrName);
        return employeeRepo.getEmployeeByName(emailOrName);

    }

    @GetMapping("/getEmployeeById")
    public EmployeeDto getEmployeeById(@RequestParam String empId) {
        System.out.println("Getting Employee with Id:" + empId);
        return employeeRepo.getEmployeeById(empId);
    }

    @GetMapping("/getAppliedProjects")
    public List<ProjectDTO> getAppliedProjectsById(@RequestParam String empId) {
        System.out.println("Getting Projects applied by Employee with Id:" + empId);
        return appliedProjectsRepo.getAppliedProjectByEmpId(empId).stream()
                .map(p -> projectsRepo.getProjectById(p)).collect(Collectors.toList());
    }

    @GetMapping("/getMatchedProjects")
    public List<ProjectDTO> getMatchedProjects(@RequestParam String empId) {
        System.out.println("Getting Projects matching with Employee skills with for Employee:" + empId);
        return appliedProjectsRepo.getMyMatchedProjects(empId).stream()
                .map(p -> projectsRepo.getProjectById(p)).collect(Collectors.toList());
    }

}
