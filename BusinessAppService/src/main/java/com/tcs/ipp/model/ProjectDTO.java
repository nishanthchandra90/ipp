package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;


@Document(collection = "project")
public class ProjectDTO {

    @Id
    private final String projectId;

    private final String projectName;
    private final String managerName;
    private final String description;
    private final String projLocation;
    private final String projBuilding;
    private String platform;
    private String platformName;
    private final List<String> requiredSkills;
    private final String tenure;


    public ProjectDTO(String projectId, String projectName,
                      String managerName, String description, List<String> requiredSkills, String tenure,
                      String projLocation, String projBuilding, String platform, String platformName) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.managerName = managerName;
        this.description = description;
        this.requiredSkills = requiredSkills;
        this.tenure = tenure;
        this.projLocation = projLocation;
        this.projBuilding = projBuilding;
        this.platform = platform;
        this.platformName = platformName;
    }

    public String getProjectId() {
        return projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public String getManagerName() {
        return managerName;
    }

    public String getDescription() {
        return description;
    }

    public List<String> getRequiredSkills() {
        return requiredSkills;
    }

    public String getTenure() {
        return tenure;
    }

    public String getProjLocation() {
        return projLocation;
    }

    public String getProjBuilding() {
        return projBuilding;
    }

    public String getPlatform() {
        return platform;
    }

    public String getPlatformName() {
        return platformName;
    }


}
