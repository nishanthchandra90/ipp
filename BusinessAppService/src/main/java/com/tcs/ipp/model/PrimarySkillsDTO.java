package com.tcs.ipp.model;

import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;
import java.util.Objects;

@Document("platform")
public class PrimarySkillsDTO {

    private String platform;

    private List<String> platformTypes;

    public PrimarySkillsDTO(String platform, List<String> platformTypes) {
        this.platform = platform;
        this.platformTypes = platformTypes;
    }

    public String getPlatform() {
        return platform;
    }

    public List<String> getPlatformTypes() {
        return platformTypes;
    }

    @Override
    public String toString() {
        return "PrimarySkillsDTO{" +
                "platform='" + platform + '\'' +
                ", platformTypes=" + platformTypes +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PrimarySkillsDTO)) return false;
        PrimarySkillsDTO that = (PrimarySkillsDTO) o;
        return getPlatform().equals(that.getPlatform()) &&
                getPlatformTypes().equals(that.getPlatformTypes());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getPlatform(), getPlatformTypes());
    }
}
