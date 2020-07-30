package com.tcs.ipp.service;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class AppliedProjectsRepo {

    private static final Map<String, List<String>> employeeProjectMatches = new HashMap<>();
    private static final Map<String, List<String>> appliedProjects = new HashMap<>();

    static {
        employeeProjectMatches.put("EMP-2332332", List.of("Project-2328356", "Project-273698646"));
        employeeProjectMatches.put("EMP-273698646", List.of("Project-9876372", "Project-2332332", "Project-03843984", "Project-273698646"));
        employeeProjectMatches.put("EMP-9876372", List.of("Project-273698646", "Project-2332332", "Project-9876372", "Project-2328356"));
        employeeProjectMatches.put("EMP-03843984", List.of("Project-2328356", "Project-273698646"));
    }


    static {
        appliedProjects.put("EMP-2332332", List.of("Project-2328356"));
        appliedProjects.put("EMP-273698646", List.of("Project-9876372"));
        appliedProjects.put("EMP-9876372", List.of("Project-273698646", "Project-2332332", "Project-9876372"));
        appliedProjects.put("EMP-03843984", List.of("Project-273698646"));
    }

    public List<String> getMyMatchedProjects(String employeeID) {
        return employeeProjectMatches.get(employeeID);
    }

    public List<String> getAppliedProjectByEmpId(String employeeID) {
        return appliedProjects.get(employeeID);
    }

    public List<String> getMatchedCandidatesByProjectId(String projectId) {
        return employeeProjectMatches.entrySet().stream()
                .filter((e) -> e.getValue().contains(projectId))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }

    public List<String> getAppliedCandidatesByProjectId(String projectId) {
        return appliedProjects.entrySet().stream()
                .filter((e) -> e.getValue().contains(projectId))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }
}

