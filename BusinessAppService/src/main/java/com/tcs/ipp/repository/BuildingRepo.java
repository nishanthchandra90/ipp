package com.tcs.ipp.repository;

import com.tcs.ipp.model.Building;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BuildingRepo extends MongoRepository<Building, String> {
    @Override
    List<Building> findAll();
}
