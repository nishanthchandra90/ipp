package com.tcs.ipp.controller;

import com.tcs.ipp.model.AppliedMatchedCandidates;
import com.tcs.ipp.model.ProjectDTO;
import com.tcs.ipp.repository.ProjectRepo;
import com.tcs.ipp.service.AppliedProjectsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class IPPProjectController {

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private AppliedProjectsRepo appliedProjectsRepo;

    @GetMapping("/getProjectById")
    public ProjectDTO getProjectById(@RequestParam String projectId) {
        System.out.println("Getting Project details with Project Id:" + projectId);
        return projectRepo.findById(projectId).orElse(null);
    }

    @GetMapping("/getAllProjects")
    public List<ProjectDTO> getAllProjects() {
        System.out.println("Getting all Project details...");
        return projectRepo.findAll();
    }

    @GetMapping("/getApplicationsAndMatches")
    public List<AppliedMatchedCandidates> getPotentialCandidates() {
        System.out.println("Getting Potential Candidates...");
        return appliedProjectsRepo.getPotentialCandidates(projectRepo);
    }

}
