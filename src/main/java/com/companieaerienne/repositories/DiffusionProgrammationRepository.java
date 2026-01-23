package com.companieaerienne.repositories;

import com.companieaerienne.entities.DiffusionProgrammation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface DiffusionProgrammationRepository extends JpaRepository<DiffusionProgrammation, Integer> {
    
    @Query("SELECT dp FROM DiffusionProgrammation dp WHERE dp.dateProgrammation BETWEEN :start AND :end")
    List<DiffusionProgrammation> findByPeriod(@Param("start") LocalDate start, @Param("end") LocalDate end);

    @Query("SELECT dp FROM DiffusionProgrammation dp WHERE dp.volProgrammation.id = :volProgrammationId")
    List<DiffusionProgrammation> findByVolProgrammationId(@Param("volProgrammationId") Integer volProgrammationId);

    List<DiffusionProgrammation> findByDiffusionSocieteId(Integer societeId);
}
