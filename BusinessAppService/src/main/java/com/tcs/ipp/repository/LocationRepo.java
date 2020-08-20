package com.tcs.ipp.repository;

import com.tcs.ipp.model.Location;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LocationRepo extends MongoRepository<Location, String> {
    @Override
    List<Location> findAll();

}
