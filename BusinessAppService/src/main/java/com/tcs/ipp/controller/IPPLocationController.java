package com.tcs.ipp.controller;

import com.tcs.ipp.model.Building;
import com.tcs.ipp.model.Location;
import com.tcs.ipp.repository.BuildingRepo;
import com.tcs.ipp.repository.LocationRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class IPPLocationController {

    @Autowired
    private LocationRepo locationRepo;

    @Autowired
    private BuildingRepo buildingRepo;


    @GetMapping(value = "/getCompanyLocations", produces = "application/json")
    public List<String> getAllLocations() {
        System.out.println("checking email...");
        return locationRepo.findAll().stream().map(Location::getLocationName).collect(Collectors.toList());
    }

    @GetMapping(value = "/getBuildings", produces = "application/json")
    public List<String> getBuildings() {
        System.out.println("checking email...");
        return buildingRepo.findAll().stream().map(Building::getBuildingName).collect(Collectors.toList());
    }

}
