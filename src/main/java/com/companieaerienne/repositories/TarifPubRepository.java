package com.companieaerienne.repositories;

import com.companieaerienne.entities.TarifPub;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.Optional;

@Repository
public interface TarifPubRepository extends JpaRepository<TarifPub, Integer> {
    @Query("SELECT t FROM TarifPub t WHERE t.dateApplication <= :date ORDER BY t.dateApplication DESC LIMIT 1")
    Optional<TarifPub> findLatestTarifForDate(@Param("date") LocalDate date);
}
