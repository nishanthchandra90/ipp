package com.tcs.ipp.controller;

import com.tcs.ipp.model.EmployeeDto;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.repository.EmployeeRepo;
import com.tcs.ipp.repository.ProjectRepo;
import com.tcs.ipp.service.AppliedProjectsRepo;
import com.tcs.ipp.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
public class IPPEmployeeController {

    @Autowired
    private EmployeeRepo employeeRepo;


    @Autowired
    private ProjectRepo projectsRepo;

    @Autowired
    private AppliedProjectsRepo appliedProjectsRepo;


    @GetMapping(value = "/verifyOTP", produces = "application/json")
    public Map<String, Boolean> verifyOTP(@RequestParam String otp) {
        System.out.println("verifying OTP...");
        if (otp.equalsIgnoreCase("12345")) {
            System.out.println("Delete email id and otp from db");
            return Collections.singletonMap("valid", true);
        }
        return Collections.singletonMap("valid", false);
    }

    @GetMapping(value = "/isNewUser", produces = "application/json")
    public Map<String, Boolean> isNewUser(@RequestParam String email) {
        System.out.println("checking email...");
        EmployeeDto employeeDto = employeeRepo.findByEmail(email);
        if (employeeDto == null) {
            boolean mailSent = new EmailService().sendOTP(email);
            if (mailSent) {
                return Collections.singletonMap("newUser", true);
            }
        }
        return Collections.singletonMap("newUser", false);
    }


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

    @PostMapping("/saveEmployee")
    public EmployeeDto saveEmployee(@RequestBody EmployeeDto employee) {
        System.out.println("Saving Employee with Id:" + employee.getEmployeeId());
        return employeeRepo.save(employee);
    }

    @PostMapping("/updateEmployee")
    public EmployeeDto updateEmployee(@RequestBody EmployeeDto employee) {
        System.out.println("Updating Employee with Id:" + employee.getEmployeeId());
        return employeeRepo.save(employee);
    }

    @GetMapping("/deleteEmployee")
    public void deleteEmployee(@RequestParam String employeeId) {
        System.out.println("Deleting Employee with Id:" + employeeId);
        employeeRepo.deleteById(employeeId);
    }

    @GetMapping("/getAppliedProjects")
    public List<ProjectDTO> getAppliedProjectsById(@RequestParam String empId) {
        System.out.println("Getting Projects applied by Employee with Id:" + empId);
        return appliedProjectsRepo.getAppliedProjectByEmpId(empId).stream()
                .filter(p -> projectsRepo.findById(p).isPresent())
                .map(p -> projectsRepo.findById(p).get()).collect(Collectors.toList());
    }

    @GetMapping("/getMatchedProjects")
    public List<ProjectDTO> getMatchedProjects(@RequestParam String empId) {
        System.out.println("Getting Projects matching with Employee skills for Employee:" + empId);
        return appliedProjectsRepo.getMyMatchedProjects(empId).stream()
                .filter(p -> projectsRepo.findById(p).isPresent())
                .map(p -> projectsRepo.findById(p).get()).collect(Collectors.toList());
    }

}
