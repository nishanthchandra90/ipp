package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document("project_employee")
public class ProjectEmployee {

    @Id
    private final String projectId;

    private final List<String> appliedEmpIds;

    private final List<String> matchedEmpIds;

    private final List<String> confirmedEmpIds;


    public String getProjectId() {
        return projectId;
    }

    public List<String> getAppliedEmpIds() {
        return appliedEmpIds;
    }

    public List<String> getMatchedEmpIds() {
        return matchedEmpIds;
    }

    public List<String> getConfirmedEmpIds() {
        return confirmedEmpIds;
    }

    public ProjectEmployee(String projectId,
                           List<String> appliedEmpIds,
                           List<String> matchedEmpIds,
                           List<String> confirmedEmpIds) {
        this.projectId = projectId;
        this.appliedEmpIds = appliedEmpIds;
        this.matchedEmpIds = matchedEmpIds;
        this.confirmedEmpIds = confirmedEmpIds;
    }


}
