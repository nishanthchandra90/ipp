package com.tcs.ipp.model;

import java.util.Objects;

public class EmployeeDto {

    String employeeId;

    String employeeName;

    String email;

    boolean isAdmin;

    public EmployeeDto(String employeeId, String employeeName, String email, boolean isAdmin) {
        this.employeeId = employeeId;
        this.employeeName = employeeName;
        this.email = email;
        this.isAdmin = isAdmin;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public String getEmail() {
        return email;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof EmployeeDto)) return false;
        EmployeeDto userDto = (EmployeeDto) o;
        return isAdmin() == userDto.isAdmin() &&
                getEmployeeId().equals(userDto.getEmployeeId()) &&
                getEmployeeName().equals(userDto.getEmployeeName()) &&
                getEmail().equals(userDto.getEmail());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getEmployeeId(), getEmployeeName(), getEmail(), isAdmin());
    }

    @Override
    public String toString() {
        return "EmployeeDto{" +
                "employeeId='" + employeeId + '\'' +
                ", employeeName='" + employeeName + '\'' +
                ", email='" + email + '\'' +
                ", isAdmin=" + isAdmin +
                '}';
    }
}
