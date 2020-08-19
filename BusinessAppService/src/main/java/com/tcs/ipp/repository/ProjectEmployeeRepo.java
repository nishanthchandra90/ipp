package com.tcs.ipp.repository;

import com.tcs.ipp.model.ProjectEmployee;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ProjectEmployeeRepo extends MongoRepository<ProjectEmployee, String> {
    @Override
    List<ProjectEmployee> findAll();

}
