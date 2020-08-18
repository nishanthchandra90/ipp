package com.tcs.ipp.repository;

import com.tcs.ipp.model.BuildingDTO;
import com.tcs.ipp.model.LocationDTO;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BuildingRepo extends MongoRepository<BuildingDTO, String> {
    @Override
    List<BuildingDTO> findAll();
}
