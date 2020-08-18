package com.tcs.ipp.model;

import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Objects;

@Document("location")
public class LocationDTO {

    private String locationName;

    public LocationDTO(String locationName) {
        this.locationName = locationName;
    }

    public String getLocationName() {
        return locationName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof LocationDTO)) return false;
        LocationDTO that = (LocationDTO) o;
        return getLocationName().equals(that.getLocationName());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getLocationName());
    }

    @Override
    public String toString() {
        return "LocationDTO{" +
                "locationName='" + locationName + '\'' +
                '}';
    }
}
