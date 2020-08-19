package com.tcs.ipp.model;

import java.util.List;

public class AppliedMatchedCandidates {

    String projectId;
    String projectName;
    String location;
    List<String> appliedCandidates;
    List<String> matchedCandidates;

    public AppliedMatchedCandidates(String projectId, String projectName, String location,
                                    List<String> appliedCandidates,
                                    List<String> matchedCandidates) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.location=location;
        this.appliedCandidates = appliedCandidates;
        this.matchedCandidates = matchedCandidates;
    }

    public String getProjectId() {
        return projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public List<String> getAppliedCandidates() {
        return appliedCandidates;
    }

    public List<String> getMatchedCandidates() {
        return matchedCandidates;
    }

    public String projLocation() {
        return location;
    }

    @Override
    public String toString() {
        return "AppliedMatchedCandidates{" +
                "projectId='" + projectId + '\'' +
                ", projectName='" + projectName + '\'' +
                ", location='" + location + '\'' +
                ", appliedCandidates=" + appliedCandidates +
                ", matchedCandidates=" + matchedCandidates +
                '}';
    }
}
