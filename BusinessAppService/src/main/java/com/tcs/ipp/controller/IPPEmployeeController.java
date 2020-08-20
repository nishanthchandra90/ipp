package com.tcs.ipp.controller;

import com.tcs.ipp.model.Employee;
import com.tcs.ipp.repository.EmployeeRepo;
import com.tcs.ipp.repository.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
public class IPPEmployeeController {

    @Autowired
    private EmployeeRepo employeeRepo;

    @Autowired
    private ProjectRepo projectsRepo;

    @GetMapping(value = "/isNewUser", produces = "application/json")
    public Map<String, Boolean> isNewUser(@RequestParam String email) {
        System.out.println("checking email...");
        Employee employee = employeeRepo.findByEmail(email);
        if (employee == null) {
            return Collections.singletonMap("newUser", true);
        }
        return Collections.singletonMap("newUser", false);
    }

    @GetMapping(value = "/isRegisteredUser", produces = "application/json")
    public Map<String, Boolean> isRegisteredUser(@RequestParam String email) {
        System.out.println("checking for Registered email..." + email);
        Employee employee = employeeRepo.findByEmail(email.toLowerCase());
        if (employee != null) {
            return Collections.singletonMap("registeredUser", true);
        }
        return Collections.singletonMap("registeredUser", false);
    }


    @GetMapping("/getAllEmployees")
    public List<Employee> getAllEmployees() {
        System.out.println("Sending all employees as response...");
        return employeeRepo.findAll();
    }

    @GetMapping("/getEmployeeById")
    public Employee getEmployeeById(@RequestParam String empId) {
        System.out.println("Getting Employee with Id:" + empId);
        return employeeRepo.findById(empId).orElse(null);
    }

    @PostMapping("/saveEmployee")
    public Employee saveEmployee(@RequestBody Employee employee) {
        System.out.println("Saving Employee with Id:" + employee.getEmployeeId());
        return employeeRepo.save(employee);
    }

    @PostMapping("/updateEmployee")
    public Employee updateEmployee(@RequestBody Employee employee) {
        System.out.println("Updating Employee with Id:" + employee.getEmployeeId());
        return employeeRepo.save(employee);
    }

    @PostMapping("/updatePWD")
    public void updatePWD(@RequestBody String data) {
        System.out.println("Saving new password");
        String[] split = data.split(":");
        Employee emp = employeeRepo.findByEmployeeId(split[0]);
        emp.setPassword(split[1].trim());
        employeeRepo.save(emp);
    }

    @GetMapping("/deleteEmployee")
    public void deleteEmployee(@RequestParam String employeeId) {
        System.out.println("Deleting Employee with Id:" + employeeId);
        employeeRepo.deleteById(employeeId);
    }

}
