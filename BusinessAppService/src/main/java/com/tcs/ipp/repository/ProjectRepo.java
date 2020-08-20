package com.tcs.ipp.repository;


import com.tcs.ipp.model.Project;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProjectRepo extends MongoRepository<Project, String> {

    List<Project> findAll();

}