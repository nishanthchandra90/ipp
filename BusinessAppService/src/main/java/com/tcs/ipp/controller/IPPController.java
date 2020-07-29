package com.tcs.ipp.controller;

import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.service.ProjectsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
public class IPPController {
    @Autowired
    private ProjectsRepo projectsRepo;

    @PostMapping("/getMatchedProjects")
    public List<ProjectDTO> getMatchedProjects(@RequestBody String skills) {
        Map<String, List<String>> projectsSkillsMap = getProjectWithSkills();
        System.out.println("Sending 2 projects as response...");
        return projectsRepo.getAllProjects().stream().limit(2).collect(Collectors.toList());
    }

    private Map<String, List<String>> getProjectWithSkills() {
        return projectsRepo.getAllProjects().stream().collect(Collectors.toMap(ProjectDTO::getProjectName, ProjectDTO::getRequiredSkills));
    }

    @PostMapping("/getAllProjects")
    public List<ProjectDTO> getAllProjects() {
        System.out.println("Sending all projects as response...");
        return projectsRepo.getAllProjects();
    }


}
