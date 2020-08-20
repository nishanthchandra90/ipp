package com.tcs.ipp.repository;

import com.tcs.ipp.model.CandidateApplication;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface CandidateApplicationRepo extends MongoRepository<CandidateApplication, String> {
    @Override
    List<CandidateApplication> findAll();

}
