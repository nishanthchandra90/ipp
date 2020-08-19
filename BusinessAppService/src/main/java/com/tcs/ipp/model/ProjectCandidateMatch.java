package com.tcs.ipp.model;

import java.util.List;

public class ProjectCandidateMatch {

    private final ProjectDTO project;
    private final List<EmployeeDto> appliedEmployees;
    private final List<EmployeeDto> matchedEmployees;
    private final List<EmployeeDto> confirmedEmployees;

    public ProjectCandidateMatch(ProjectDTO project,
                                 List<EmployeeDto> appliedEmployees,
                                 List<EmployeeDto> matchedEmployees,
                                 List<EmployeeDto> confirmedEmployees) {
        this.project = project;
        this.appliedEmployees = appliedEmployees;
        this.matchedEmployees = matchedEmployees;
        this.confirmedEmployees = confirmedEmployees;
    }

    public ProjectDTO getProject() {
        return project;
    }

    public List<EmployeeDto> getAppliedEmployees() {
        return appliedEmployees;
    }

    public List<EmployeeDto> getMatchedEmployees() {
        return matchedEmployees;
    }

    public List<EmployeeDto> getConfirmedEmployees() {
        return confirmedEmployees;
    }


}
