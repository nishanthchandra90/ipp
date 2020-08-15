package com.tcs.ipp.repository;

import com.tcs.ipp.model.OTPDTO;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OTPRepo extends MongoRepository<OTPDTO, String> {


}