package com.tcs.ipp.repository;


import com.tcs.ipp.model.EmployeeDto;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeRepo extends MongoRepository<EmployeeDto, String> {

    List<EmployeeDto> findAll();

    EmployeeDto findByEmployeeId(String id);

    EmployeeDto findByEmail(String email);


}