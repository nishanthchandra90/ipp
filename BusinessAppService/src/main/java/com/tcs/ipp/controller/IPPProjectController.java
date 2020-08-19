package com.tcs.ipp.controller;

import com.tcs.ipp.model.PrimarySkillsDTO;
import com.tcs.ipp.model.ProjectCandidateMatch;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.repository.PlatformRepo;
import com.tcs.ipp.repository.ProjectRepo;
import com.tcs.ipp.service.ProjectCandidateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class IPPProjectController {

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private ProjectCandidateService projectCandidateService;

    @Autowired
    private PlatformRepo platformRepo;

    @GetMapping("/getProjectById")
    public ProjectDTO getProjectById(@RequestParam String projectId) {
        System.out.println("Getting Project details with Project Id:" + projectId);
        return projectRepo.findById(projectId).orElse(null);
    }

    @PostMapping("/saveProject")
    public ProjectDTO saveProject(@RequestBody ProjectDTO project) {
        System.out.println("Saving Project details with Project Id:" + project.getProjectId());
        return projectRepo.save(project);
    }

    @PostMapping("/editProject")
    public ProjectDTO editProject(@RequestBody ProjectDTO project) {
        System.out.println("Editing Project details with Project Id:" + project.getProjectId());
        return projectRepo.save(project);
    }

    @GetMapping("/deleteProject")
    public void deleteProject(@RequestParam String projectId) {
        System.out.println("Delete Project details with Project Id:" + projectId);
        projectRepo.deleteById(projectId);
    }

    @GetMapping("/getAllProjects")
    public List<ProjectDTO> getAllProjects() {
        System.out.println("Getting all Project details...");
        return projectRepo.findAll();
    }

    @GetMapping("/getPrimaryPlatforms")
    public List<PrimarySkillsDTO> getPrimaryPlatforms() {
        System.out.println("Getting Potential Candidates...");
        return platformRepo.findAll();
    }

    @GetMapping("/getPotentialCandidates")
    public List<ProjectCandidateMatch> getPotentialCandidates() {
        return projectCandidateService.getPotentialCandidates();
    }

}
