package com.tcs.ipp.service;


import com.tcs.ipp.model.CandidateApplication;
import com.tcs.ipp.model.CandidateApplicationDTO;
import com.tcs.ipp.model.Project;
import com.tcs.ipp.model.ProjectApplicationDTO;
import com.tcs.ipp.repository.CandidateApplicationRepo;
import com.tcs.ipp.repository.EmployeeRepo;
import com.tcs.ipp.repository.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Component
public class ProjectApplicationsService {

    @Autowired
    private EmployeeRepo employeesRepo;

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private CandidateApplicationRepo candidateApplicationRepo;

    private List<CandidateApplicationDTO> getAppliedCandidatesById(List<String> empIds) {
        return empIds.stream()
                .map(empId -> employeesRepo.findById(empId).orElse(null))
                .filter(Objects::nonNull)
                .map(emp -> new CandidateApplicationDTO(emp, false, true, false))
                .collect(Collectors.toList());
    }

    private List<CandidateApplicationDTO> getMatchedCandidatesById(List<String> empIds) {
        return empIds.stream()
                .map(empId -> employeesRepo.findById(empId).orElse(null))
                .filter(Objects::nonNull)
                .map(emp -> new CandidateApplicationDTO(emp, true, false, false))
                .collect(Collectors.toList());
    }

    private List<CandidateApplicationDTO> getConfirmedCandidatesById(List<String> empIds) {
        return empIds.stream()
                .map(empId -> employeesRepo.findById(empId).orElse(null))
                .filter(Objects::nonNull)
                .map(emp -> new CandidateApplicationDTO(emp, false, false, true))
                .collect(Collectors.toList());
    }

    public List<ProjectApplicationDTO> getProjectApplications() {
        List<CandidateApplication> candidateApplications = candidateApplicationRepo.findAll();
        List<ProjectApplicationDTO> ProjectCandidateMatches = new ArrayList<>();
        for (CandidateApplication candidateApplication : candidateApplications) {
            Project project = projectRepo.findById(candidateApplication.getProjectId()).orElse(null);
            if (project != null) {
                List<CandidateApplicationDTO> appliedCandidates = getAppliedCandidatesById(candidateApplication.getAppliedEmpIds());
                List<CandidateApplicationDTO> matchedCandidates = getMatchedCandidatesById(candidateApplication.getMatchedEmpIds());
                List<CandidateApplicationDTO> confirmedCandidates = getConfirmedCandidatesById(candidateApplication.getConfirmedEmpIds());
                ProjectCandidateMatches.add(new ProjectApplicationDTO(project, appliedCandidates, matchedCandidates, confirmedCandidates));
            }
        }
        return ProjectCandidateMatches;
    }

}
