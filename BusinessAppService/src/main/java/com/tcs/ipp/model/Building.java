package com.tcs.ipp.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Objects;

@Document("building")
public class Building {

    @Id
    private String buildingName;

    public Building(String buildingName) {
        this.buildingName = buildingName;
    }

    public String getBuildingName() {
        return buildingName;
    }

    @Override
    public String toString() {
        return "BuildingDTO{" +
                "buildingName='" + buildingName + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Building)) return false;
        Building that = (Building) o;
        return getBuildingName().equals(that.getBuildingName());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getBuildingName());
    }
}
//APOL - Hyderabad
//        CEDG - Mumbai
//        TCS - Ahmedabad
//        TCS - Bangalore
//        TCS - Bhopal
//        TCS - Bhubaneswar
//        TCS - Chennai
//        TCS - Coimbatore
//        TCS - Goa
//        TCS - Hyderabad
//        TCS - Indore
//        TCS - Jamshedpur
//        TCS - Kochi
//        TCS - Kolkata
//        TCS - Lucknow
//        TCS - Mumbai
//        TCS - Nagpur
//        TCS - New Delhi
//        TCS - Pune
//        TCS - Trivandrum
//        TCS - Vadodara
//        TCS - Varanasi
//        TCS e-Serve IL - Ahmedabad
//        TCS e-Serve IL - Chennai
//        TCS e-Serve IL - Kolkata
//        TCS e-Serve IL - Mumbai
//        TCS e-Serve IL - New Delhi
//        TCS e-Serve IL - Pune