package com.tcs.ipp.service;

import com.tcs.ipp.model.EmployeeDto;
import com.tcs.ipp.model.ProjectCandidateMatch;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.model.ProjectEmployee;
import com.tcs.ipp.repository.EmployeeRepo;
import com.tcs.ipp.repository.ProjectEmployeeRepo;
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
    private ProjectEmployeeRepo projectEmployeeRepo;

    public List<ProjectDTO> getMyMatchedProjects(String employeeID) {
        List<String> projectIds = projectEmployeeRepo.findAll().stream()
                .filter(pe -> pe.getMatchedEmpIds().contains(employeeID))
                .map(ProjectEmployee::getProjectId).collect(Collectors.toList());
        return projectIds.stream().map(pid -> projectRepo.findById(pid).orElse(null)).collect(Collectors.toList());
    }

    public List<ProjectDTO> getAppliedProjectByEmpId(String employeeID) {
        List<String> projectIds = projectEmployeeRepo.findAll().stream()
                .filter(pe -> pe.getAppliedEmpIds().contains(employeeID))
                .map(ProjectEmployee::getProjectId).collect(Collectors.toList());
        return projectIds.stream().map(pid -> projectRepo.findById(pid).orElse(null)).collect(Collectors.toList());
    }


    public List<ProjectDTO> getConfirmedProjects(String employeeID) {
        List<String> projectIds = projectEmployeeRepo.findAll().stream()
                .filter(pe -> pe.getConfirmedEmpIds().contains(employeeID))
                .map(ProjectEmployee::getProjectId).collect(Collectors.toList());
        return projectIds.stream().map(pid -> projectRepo.findById(pid).orElse(null)).collect(Collectors.toList());
    }

    private List<EmployeeDto> getAppliedEmployeesById(List<String> empIds) {
        return empIds.stream().map(empId -> employeesRepo.findById(empId).get()).collect(Collectors.toList());
    }

    private List<EmployeeDto> getMatchedEmployeesById(List<String> empIds) {
        return empIds.stream().map(empId -> employeesRepo.findById(empId).get()).collect(Collectors.toList());
    }

    private List<EmployeeDto> getConfirmedEmployeesById(List<String> empIds) {
        return empIds.stream().map(empId -> employeesRepo.findById(empId).get()).collect(Collectors.toList());
    }

    public List<ProjectCandidateMatch> getPotentialCandidates() {
        List<ProjectEmployee> projectEmployees = projectEmployeeRepo.findAll();
        List<ProjectCandidateMatch> ProjectEmployeeMatches = new ArrayList<>();
        for (ProjectEmployee projectEmployee : projectEmployees) {
            ProjectDTO projectDTO = projectRepo.findById(projectEmployee.getProjectId()).orElse(null);
            if (projectDTO != null) {
                List<EmployeeDto> appliedEmps = getAppliedEmployeesById(projectEmployee.getAppliedEmpIds());
                List<EmployeeDto> matchedEmps = getMatchedEmployeesById(projectEmployee.getMatchedEmpIds());
                List<EmployeeDto> confirmedEmps = getConfirmedEmployeesById(projectEmployee.getConfirmedEmpIds());
                ProjectEmployeeMatches.add(new ProjectCandidateMatch(projectDTO, appliedEmps, matchedEmps, confirmedEmps));
            }
        }
        return ProjectEmployeeMatches;
    }

}

