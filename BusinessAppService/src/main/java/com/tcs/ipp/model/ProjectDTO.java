package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;
import java.util.Map;
import java.util.Objects;


@Document(collection = "project")
public class ProjectDTO {

    @Id
    private final String projectId;

    private final String projectName;
    private final String managerName;
    private final String description;
    private final String projLocation;
    private final String projBuilding;
    private final Map<String, String> primarySkills;
    private final List<String> requiredSkills;
    private final String tenure;


    public ProjectDTO(String projectId, String projectName,
                      String managerName, String description, List<String> requiredSkills, String tenure,
                      String projLocation, String projBuilding, Map<String, String> primarySkills) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.managerName = managerName;
        this.description = description;
        this.requiredSkills = requiredSkills;
        this.tenure = tenure;
        this.projLocation = projLocation;
        this.projBuilding = projBuilding;
        this.primarySkills = primarySkills;
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

    public Map<String, String> getPrimarySkills() {
        return primarySkills;
    }

    @Override
    public String toString() {
        return "ProjectDTO{" +
                "projectId='" + projectId + '\'' +
                ", projectName='" + projectName + '\'' +
                ", managerName='" + managerName + '\'' +
                ", description='" + description + '\'' +
                ", projLocation='" + projLocation + '\'' +
                ", projBuilding='" + projBuilding + '\'' +
                ", primarySkills=" + primarySkills +
                ", requiredSkills=" + requiredSkills +
                ", tenure='" + tenure + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ProjectDTO)) return false;
        ProjectDTO that = (ProjectDTO) o;
        return getProjectId().equals(that.getProjectId()) &&
                getProjectName().equals(that.getProjectName()) &&
                getManagerName().equals(that.getManagerName()) &&
                getDescription().equals(that.getDescription()) &&
                getProjLocation().equals(that.getProjLocation()) &&
                getProjBuilding().equals(that.getProjBuilding()) &&
                getPrimarySkills().equals(that.getPrimarySkills()) &&
                getRequiredSkills().equals(that.getRequiredSkills()) &&
                getTenure().equals(that.getTenure());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getProjectId(), getProjectName(), getManagerName(), getDescription(), getProjLocation(),
                getProjBuilding(), getPrimarySkills(), getRequiredSkills(), getTenure());
    }
}
