package com.tcs.ipp.model;

import java.util.List;

public class AppliedMatchedCandidates {

    String projectId;
    String projectName;
    List<String> appliedCandidates;
    List<String> matchedCandidates;

    public AppliedMatchedCandidates(String projectId, String projectName,
                                    List<String> appliedCandidates,
                                    List<String> matchedCandidates) {
        this.projectId = projectId;
        this.projectName = projectName;
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


}
