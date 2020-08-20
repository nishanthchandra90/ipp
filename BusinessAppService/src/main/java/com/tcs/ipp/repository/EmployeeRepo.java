package com.tcs.ipp.repository;


import com.tcs.ipp.model.Employee;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeRepo extends MongoRepository<Employee, String> {

    List<Employee> findAll();

    Employee findByEmployeeId(String id);

    Employee findByEmail(String email);


}