package com.tcs.ipp.controller;

import com.tcs.ipp.model.AppliedMatchedCandidates;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.service.AppliedProjectsRepo;
import com.tcs.ipp.service.ProjectsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class IPPProjectController {
    @Autowired
    private ProjectsRepo projectsRepo;

    @Autowired
    private AppliedProjectsRepo appliedProjectsRepo;

    @GetMapping("/getProjectById")
    public ProjectDTO getProjectById(@RequestParam String projectId) {
        System.out.println("Getting Project details with Project Id:" + projectId);
        return projectsRepo.getProjectById(projectId);
    }

    @GetMapping("/getAllProjects")
    public List<ProjectDTO> getAllProjects() {
        System.out.println("Getting all Project details...");
        return projectsRepo.getAllProjects();
    }

    @GetMapping("/getApplicationsAndMatches")
    public List<AppliedMatchedCandidates> getPotentialCandidates() {
        System.out.println("Getting Potential Candidates...");
        return appliedProjectsRepo.getPotentialCandidates(projectsRepo);
    }

}
