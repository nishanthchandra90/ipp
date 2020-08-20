package com.tcs.ipp.model;

import java.util.List;

public class ProjectApplicationDTO {

    private final Project project;
    private final List<CandidateApplicationDTO> appliedCandidates;
    private final List<CandidateApplicationDTO> matchedCandidates;
    private final List<CandidateApplicationDTO> confirmedCandidates;

    public ProjectApplicationDTO(Project project,
                                 List<CandidateApplicationDTO> appliedCandidates,
                                 List<CandidateApplicationDTO> matchedCandidates,
                                 List<CandidateApplicationDTO> confirmedCandidates) {
        this.project = project;
        this.appliedCandidates = appliedCandidates;
        this.matchedCandidates = matchedCandidates;
        this.confirmedCandidates = confirmedCandidates;
    }

    public Project getProject() {
        return project;
    }

    public List<CandidateApplicationDTO> getAppliedCandidates() {
        return appliedCandidates;
    }

    public List<CandidateApplicationDTO> getMatchedCandidates() {
        return matchedCandidates;
    }

    public List<CandidateApplicationDTO> getConfirmedCandidates() {
        return confirmedCandidates;
    }


}
