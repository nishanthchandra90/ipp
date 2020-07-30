package com.tcs.ipp.service;

import com.tcs.ipp.model.EmployeeDto;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class EmployeesRepo {


    private static final List<EmployeeDto> users = new ArrayList<>();

    static {
        users.add(new EmployeeDto("EMP-2328356", "Admin", "john.joey@tcs.com", true));
        users.add(new EmployeeDto("EMP-2332332", "Blob", "blob.byne@tcs.com", false));
        users.add(new EmployeeDto("EMP-273698646", "Alice", "alice.ar@tcs.com", false));
        users.add(new EmployeeDto("EMP-9876372", "Wells", "wells.white@tcs.com", false));
        users.add(new EmployeeDto("EMP-03843984", "Micheal", "micheal.est@tcs.com", false));
    }

    public List<EmployeeDto> getAllEmployees() {
        return users;
    }
}
