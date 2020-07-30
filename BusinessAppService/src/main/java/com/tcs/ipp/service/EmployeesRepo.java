package com.tcs.ipp.service;

import com.tcs.ipp.model.EmployeeDto;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class EmployeesRepo {


    private static final List<EmployeeDto> employees = new ArrayList<>();

    static {
        employees.add(new EmployeeDto("EMP-2328356", "Admin", "john.joey@tcs.com", true));
        employees.add(new EmployeeDto("EMP-2332332", "Blob", "blob.byne@tcs.com", false));
        employees.add(new EmployeeDto("EMP-273698646", "Alice", "alice.ar@tcs.com", false));
        employees.add(new EmployeeDto("EMP-9876372", "Wells", "wells.white@tcs.com", false));
        employees.add(new EmployeeDto("EMP-03843984", "Micheal", "micheal.est@tcs.com", false));
    }

    public List<EmployeeDto> getAllEmployees() {
        return employees;
    }

    public EmployeeDto getEmployeeByName(String name) {
        return employees.stream()
                .filter(employee -> (employee.getEmployeeName().equalsIgnoreCase(name)
                        || employee.getEmail().equalsIgnoreCase(name)))
                .findFirst()
                .orElse(null);
    }

    public EmployeeDto getEmployeeById(String id) {
        return employees.stream()
                .filter(employee -> employee.getEmployeeId().equalsIgnoreCase(id))
                .findFirst()
                .orElse(null);
    }
}
