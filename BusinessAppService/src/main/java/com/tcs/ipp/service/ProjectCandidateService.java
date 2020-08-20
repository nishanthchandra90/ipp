package com.tcs.ipp.service;

import com.tcs.ipp.model.Employee;
import com.tcs.ipp.model.ProjectCandidateMatch;
import com.tcs.ipp.model.Project;
import com.tcs.ipp.model.CandidateApplication;
import com.tcs.ipp.repository.EmployeeRepo;
import com.tcs.ipp.repository.CandidateApplicationRepo;
import com.tcs.ipp.repository.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class ProjectCandidateService {

    @Autowired
    private EmployeeRepo employeesRepo;

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private CandidateApplicationRepo candidateApplicationRepo;

    public List<Project> getMyMatchedProjects(String employeeID) {
        List<String> projectIds = candidateApplicationRepo.findAll().stream()
                .filter(pe -> pe.getMatchedEmpIds().contains(employeeID))
                .map(CandidateApplication::getProjectId).collect(Collectors.toList());
        return projectIds.stream().map(pid -> projectRepo.findById(pid).orElse(null)).collect(Collectors.toList());
    }

    public List<Project> getAppliedProjectByEmpId(String employeeID) {
        List<String> projectIds = candidateApplicationRepo.findAll().stream()
                .filter(pe -> pe.getAppliedEmpIds().contains(employeeID))
                .map(CandidateApplication::getProjectId).collect(Collectors.toList());
        return projectIds.stream().map(pid -> projectRepo.findById(pid).orElse(null)).collect(Collectors.toList());
    }


    public List<Project> getConfirmedProjects(String employeeID) {
        List<String> projectIds = candidateApplicationRepo.findAll().stream()
                .filter(pe -> pe.getConfirmedEmpIds().contains(employeeID))
                .map(CandidateApplication::getProjectId).collect(Collectors.toList());
        return projectIds.stream().map(pid -> projectRepo.findById(pid).orElse(null)).collect(Collectors.toList());
    }

    private List<Employee> getAppliedEmployeesById(List<String> empIds) {
        return empIds.stream().map(empId -> employeesRepo.findById(empId).get()).collect(Collectors.toList());
    }

    private List<Employee> getMatchedEmployeesById(List<String> empIds) {
        return empIds.stream().map(empId -> employeesRepo.findById(empId).get()).collect(Collectors.toList());
    }

    private List<Employee> getConfirmedEmployeesById(List<String> empIds) {
        return empIds.stream().map(empId -> employeesRepo.findById(empId).get()).collect(Collectors.toList());
    }

    public List<ProjectCandidateMatch> getPotentialCandidates() {
        List<CandidateApplication> candidateApplications = candidateApplicationRepo.findAll();
        List<ProjectCandidateMatch> ProjectEmployeeMatches = new ArrayList<>();
        for (CandidateApplication candidateApplication : candidateApplications) {
            Project project = projectRepo.findById(candidateApplication.getProjectId()).orElse(null);
            if (project != null) {
                List<Employee> appliedEmps = getAppliedEmployeesById(candidateApplication.getAppliedEmpIds());
                List<Employee> matchedEmps = getMatchedEmployeesById(candidateApplication.getMatchedEmpIds());
                List<Employee> confirmedEmps = getConfirmedEmployeesById(candidateApplication.getConfirmedEmpIds());
                ProjectEmployeeMatches.add(new ProjectCandidateMatch(project, appliedEmps, matchedEmps, confirmedEmps));
            }
        }
        return ProjectEmployeeMatches;
    }


    public void confirmCandidate(String projectId, String empId) {
        System.out.println("Confirmed project :" + projectId);
        System.out.println(" for emp:" + empId);
        CandidateApplication candidateApplication = candidateApplicationRepo.findById(projectId).get();
        List<String> confirmedEmpIds = candidateApplication.getConfirmedEmpIds();
        if (confirmedEmpIds.contains(empId)) {
            confirmedEmpIds.remove(empId);
        } else {
            confirmedEmpIds.add(empId);

        }
        candidateApplicationRepo.save(candidateApplication);
    }
}

