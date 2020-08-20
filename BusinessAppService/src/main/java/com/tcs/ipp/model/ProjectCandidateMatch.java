package com.tcs.ipp.model;

import java.util.List;

public class ProjectCandidateMatch {

    private final Project project;
    private final List<Employee> appliedEmployees;
    private final List<Employee> matchedEmployees;
    private final List<Employee> confirmedEmployees;

    public ProjectCandidateMatch(Project project,
                                 List<Employee> appliedEmployees,
                                 List<Employee> matchedEmployees,
                                 List<Employee> confirmedEmployees) {
        this.project = project;
        this.appliedEmployees = appliedEmployees;
        this.matchedEmployees = matchedEmployees;
        this.confirmedEmployees = confirmedEmployees;
    }

    public Project getProject() {
        return project;
    }

    public List<Employee> getAppliedEmployees() {
        return appliedEmployees;
    }

    public List<Employee> getMatchedEmployees() {
        return matchedEmployees;
    }

    public List<Employee> getConfirmedEmployees() {
        return confirmedEmployees;
    }


}
