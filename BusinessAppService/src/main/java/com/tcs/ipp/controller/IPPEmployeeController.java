package com.tcs.ipp.controller;

import com.tcs.ipp.model.EmployeeDto;
import com.tcs.ipp.service.EmployeesRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class IPPEmployeeController {
    @Autowired
    private EmployeesRepo employeeRepo;

    @GetMapping("/getAllEmployees")
    public List<EmployeeDto> getAllEmployees() {
        System.out.println("Sending all employees as response...");
        return employeeRepo.getAllEmployees();
    }

    @GetMapping("/getEmployeeByEmailName")
    public EmployeeDto getEmployee(@RequestParam String emailOrName) {
        System.out.println(emailOrName);
        EmployeeDto employeedto = employeeRepo.getAllEmployees().stream()
                .filter(employee -> employee.getEmployeeName().equalsIgnoreCase(emailOrName)
                        || employee.getEmail().equalsIgnoreCase(emailOrName))
                .findFirst().orElse(null);
        System.out.println("Sending employee as response..." + employeedto);
        return employeedto;

    }

}
