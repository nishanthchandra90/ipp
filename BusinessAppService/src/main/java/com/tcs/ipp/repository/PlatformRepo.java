package com.tcs.ipp.repository;

import com.tcs.ipp.model.PrimarySkillsDTO;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlatformRepo extends MongoRepository<PrimarySkillsDTO, String> {
    @Override
    List<PrimarySkillsDTO> findAll();

}
