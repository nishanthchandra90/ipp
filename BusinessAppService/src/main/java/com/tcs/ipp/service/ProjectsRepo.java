package com.tcs.ipp.service;

import com.tcs.ipp.model.ProjectDTO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class ProjectsRepo {


    private static final List<ProjectDTO> projects = new ArrayList<>();

    static {
        projects.add(new ProjectDTO("Project-2328356", "SITA", "Manager1", "Hobby Project",
                List.of("Java", "Spring", "Hibernates", "Docker"), "5 Years"));
        projects.add(new ProjectDTO("Project-2332332", "AMEX", "Manager2", "AMEX Project",
                List.of("#NET", "asp", "Database", "Docker"), "2 Years"));
        projects.add(new ProjectDTO("Project-273698646", "Clinton", "Manager3", "Clinton Project",
                List.of("BigData", "AWS", "ML", "AI"), "5 Years"));
        projects.add(new ProjectDTO("Project-9876372", "DCS", "Manager4", "DCS Project",
                List.of("Java", "Spring", "AWS", "Elastic"), "8 Years"));
        projects.add(new ProjectDTO("Project-03843984", "GSL", "Manager5", "GSL Project",
                List.of("Java", "Spring", "Hibernates", "AWS"), "temporary"));
    }

    public List<ProjectDTO> getAllProjects() {
        return projects;
    }
}
