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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class ProjectCandidateService {

    @Autowired
    private EmployeeRepo employeesRepo;

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private ProjectEmployeeRepo projectEmployeeRepo;

    private static final Map<String, List<String>> employeeProjectMatches = new HashMap<>();
    private static final Map<String, List<String>> appliedProjects = new HashMap<>();

    static {
        employeeProjectMatches.put("emp-2332332", List.of("2328356", "273698646"));
        employeeProjectMatches.put("emp-273698646", List.of("9876372", "2332332", "03843984", "273698646"));
        employeeProjectMatches.put("emp-9876372", List.of("273698646", "2332332", "9876372", "2328356"));
        employeeProjectMatches.put("emp-03843984", List.of("2328356", "273698646"));
    }

    static {
        appliedProjects.put("emp-2332332", List.of("2328356"));
        appliedProjects.put("emp-273698646", List.of("9876372"));
        appliedProjects.put("emp-9876372", List.of("273698646", "2332332", "9876372"));
        appliedProjects.put("emp-03843984", List.of("273698646"));
    }

    public List<String> getMyMatchedProjects(String employeeID) {
        return employeeProjectMatches.get(employeeID);
    }

    public List<String> getAppliedProjectByEmpId(String employeeID) {
        return appliedProjects.get(employeeID);
    }

    public List<String> getMatchedCandidates(String projectId) {
        return employeeProjectMatches.entrySet().stream()
                .filter((e) -> e.getValue().contains(projectId))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList()).stream().filter(eId -> employeesRepo.findById(eId).isPresent())
                .map(emp -> employeesRepo.findById(emp).get().getEmpName())
                .collect(Collectors.toList());
    }

    public List<String> getAppliedCandidates(String projectId) {
        return appliedProjects.entrySet().stream()
                .filter((e) -> e.getValue().contains(projectId))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList()).stream().filter(eId -> employeesRepo.findById(eId).isPresent())
                .map(emp -> employeesRepo.findById(emp).get().getEmpName())
                .collect(Collectors.toList());
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

