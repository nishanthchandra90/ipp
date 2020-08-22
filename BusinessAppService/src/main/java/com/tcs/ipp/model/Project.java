package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;


@Document(collection = "project")
public class Project {

    @Id
    private final String projectId;

    private final String projectName;
    private final String managerName;
    private final String description;
    private final String projLocation;
    private final String projBuilding;
    private final String platform;
    private final String platformName;
    private final String expertise;
    private final String tenure;


    public Project(String projectId, String projectName,
                   String managerName, String description, String expertise, String tenure,
                   String projLocation, String projBuilding, String platform, String platformName) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.managerName = managerName;
        this.description = description;
        this.expertise = expertise;
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

    public String getExpertise() {
        return expertise;
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
