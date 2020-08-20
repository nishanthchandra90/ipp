package com.tcs.ipp.controller;

import com.tcs.ipp.model.PrimarySkill;
import com.tcs.ipp.model.Project;
import com.tcs.ipp.model.ProjectApplicationDTO;
import com.tcs.ipp.repository.PlatformRepo;
import com.tcs.ipp.repository.ProjectRepo;
import com.tcs.ipp.service.ProjectApplicationsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class IPPProjectController {

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    ProjectApplicationsService projectApplicationsService;

    @Autowired
    private PlatformRepo platformRepo;

    @GetMapping("/getProjectById")
    public Project getProjectById(@RequestParam String projectId) {
        System.out.println("Getting Project details with Project Id:" + projectId);
        return projectRepo.findById(projectId).orElse(null);
    }

    @PostMapping("/saveProject")
    public Project saveProject(@RequestBody Project project) {
        System.out.println("Saving Project details with Project Id:" + project.getProjectId());
        return projectRepo.save(project);
    }

    @PostMapping("/editProject")
    public Project editProject(@RequestBody Project project) {
        System.out.println("Editing Project details with Project Id:" + project.getProjectId());
        return projectRepo.save(project);
    }

    @GetMapping("/deleteProject")
    public void deleteProject(@RequestParam String projectId) {
        System.out.println("Delete Project details with Project Id:" + projectId);
        projectRepo.deleteById(projectId);
    }

    @GetMapping("/getAllProjects")
    public List<Project> getAllProjects() {
        System.out.println("Getting all Project details...");
        return projectRepo.findAll();
    }

    @GetMapping("/getPrimaryPlatforms")
    public List<PrimarySkill> getPrimaryPlatforms() {
        System.out.println("Getting Potential Candidates...");
        return platformRepo.findAll();
    }

    @GetMapping("/confirmCandidate")
    public void confirmCandidate(@RequestParam String projectId, @RequestParam String empId) {
        System.out.println("Emp:" + empId);
        System.out.println("Proj:" + projectId);
        projectApplicationsService.confirmCandidate(projectId, empId);
    }

    @GetMapping("/getProjectApplications")
    public List<ProjectApplicationDTO> getProjectApplications() {
        return projectApplicationsService.getProjectApplications();
    }


}
