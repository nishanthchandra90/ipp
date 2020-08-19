package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Objects;

@Document(collection = "employee")
public class EmployeeDto {

    @Id
    private String employeeId;

    private String password;

    private String email;

    private String empName;

    private int expYears;

    private int expMonths;

    private String currLocation;

    private String building;

    private String platform;

    private String platformName;

    private String secSkills;

    private String certificates;

    private boolean isAdmin;

    public EmployeeDto(String employeeId, String password, String email, String empName, int expYears, int expMonths,
                       String currLocation, String building, String platform, String platformName, String secSkills,
                       String certificates, boolean isAdmin) {
        this.employeeId = employeeId;
        this.password = password;
        this.email = email;
        this.empName = empName;
        this.expYears = expYears;
        this.expMonths = expMonths;
        this.currLocation = currLocation;
        this.building = building;
        this.platform = platform;
        this.platformName = platformName;
        this.secSkills = secSkills;
        this.certificates = certificates;
        this.isAdmin = isAdmin;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getEmpName() {
        return empName;
    }

    public int getExpYears() {
        return expYears;
    }

    public int getExpMonths() {
        return expMonths;
    }

    public String getCurrLocation() {
        return currLocation;
    }

    public String getBuilding() {
        return building;
    }

    public String getPlatform() {
        return platform;
    }

    public String getPlatformName() {
        return platformName;
    }

    public String getSecSkills() {
        return secSkills;
    }

    public String getCertificates() {
        return certificates;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    @Override
    public String toString() {
        return "EmployeeDto{" +
                "employeeId='" + employeeId + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", empName='" + empName + '\'' +
                ", expYears=" + expYears +
                ", expMonths=" + expMonths +
                ", currLocation='" + currLocation + '\'' +
                ", building='" + building + '\'' +
                ", platform='" + platform + '\'' +
                ", platformName='" + platformName + '\'' +
                ", secSkills='" + secSkills + '\'' +
                ", certificates='" + certificates + '\'' +
                ", isAdmin=" + isAdmin +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof EmployeeDto)) return false;
        EmployeeDto that = (EmployeeDto) o;
        return getExpYears() == that.getExpYears() &&
                getExpMonths() == that.getExpMonths() &&
                isAdmin() == that.isAdmin() &&
                getEmployeeId().equals(that.getEmployeeId()) &&
                getPassword().equals(that.getPassword()) &&
                getEmail().equals(that.getEmail()) &&
                getEmpName().equals(that.getEmpName()) &&
                getCurrLocation().equals(that.getCurrLocation()) &&
                getBuilding().equals(that.getBuilding()) &&
                getPlatform().equals(that.getPlatform()) &&
                getPlatformName().equals(that.getPlatformName()) &&
                getSecSkills().equals(that.getSecSkills()) &&
                getCertificates().equals(that.getCertificates());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getEmployeeId(), getPassword(), getEmail(), getEmpName(), getExpYears(), getExpMonths(),
                getCurrLocation(), getBuilding(), getPlatform(), getPlatformName(), getSecSkills(), getCertificates(),
                isAdmin());
    }
}
