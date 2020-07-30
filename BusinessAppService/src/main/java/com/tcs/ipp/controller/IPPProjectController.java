package com.tcs.ipp.controller;

import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.service.AppliedProjectsRepo;
import com.tcs.ipp.service.ProjectsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
public class IPPProjectController {
    @Autowired
    private ProjectsRepo projectsRepo;

    @Autowired
    private AppliedProjectsRepo appliedProjectsRepo;

    private Map<String, List<String>> getProjectWithSkills() {
        return projectsRepo.getAllProjects().stream().collect(Collectors.toMap(ProjectDTO::getProjectName, ProjectDTO::getRequiredSkills));
    }

    @GetMapping("/getProjectById")
    public ProjectDTO getProjectById(@RequestParam String projectId) {
        System.out.println("Sending all projects as response...");
        return projectsRepo.getProjectById(projectId);
    }

    @GetMapping("/getAllProjects")
    public List<ProjectDTO> getAllProjects() {
        System.out.println("Sending all projects as response...");
        return projectsRepo.getAllProjects();
    }

    @GetMapping("/getAppliedCandidates")
    public List<String> getAppliedCandidates(@RequestParam String projectId) {
        System.out.println(projectId);
        return appliedProjectsRepo.getAppliedCandidatesByProjectId(projectId);
    }

    @GetMapping("/getMatchedCandidates")
    public List<String> getMatchedCandidates(@RequestParam String projectId) {
        System.out.println(projectId);
        return appliedProjectsRepo.getMatchedCandidatesByProjectId(projectId);
    }

}
