package com.tcs.ipp.model;

import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Objects;

@Document("location")
public class Location {

    private String locationName;

    public Location(String locationName) {
        this.locationName = locationName;
    }

    public String getLocationName() {
        return locationName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Location)) return false;
        Location that = (Location) o;
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
