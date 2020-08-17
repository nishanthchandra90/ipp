package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Map;
import java.util.Objects;

@Document(collection = "employee")
public class EmployeeDto {

    @Id
    String employeeId;

    String empFName;

    String empLName;

    int experience;

    String workLocation;

    String building;

    Map<String, String> primarySecondarySkills;

    String password;

    String email;

    boolean isAdmin;

    public EmployeeDto(String employeeId, String empFName, String empLName, String password, String email, boolean isAdmin) {
        this.employeeId = employeeId;
        this.empFName = empFName;
        this.empLName = empLName;
        this.password = password;
        this.email = email;
        this.isAdmin = isAdmin;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public String getEmpFName() {
        return empFName;
    }

    public String getEmpLName() {
        return empLName;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public void setEmpFName(String empFName) {
        this.empFName = empFName;
    }

    public void setEmpLName(String empLName) {
        this.empLName = empLName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof EmployeeDto)) return false;
        EmployeeDto that = (EmployeeDto) o;
        return isAdmin() == that.isAdmin() &&
                getEmployeeId().equals(that.getEmployeeId()) &&
                getEmpFName().equals(that.getEmpFName()) &&
                getEmpLName().equals(that.getEmpLName()) &&
                getPassword().equals(that.getPassword()) &&
                getEmail().equals(that.getEmail());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getEmployeeId(), getEmpFName(), getEmpLName(), getPassword(), getEmail(), isAdmin());
    }

    @Override
    public String toString() {
        return "EmployeeDto{" +
                "employeeId='" + employeeId + '\'' +
                ", empFName='" + empFName + '\'' +
                ", empLName='" + empLName + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", isAdmin=" + isAdmin +
                '}';
    }
}
