package com.companieaerienne.repositories;

import com.companieaerienne.entities.TarifProduitExtra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public interface TarifProduitExtraRepository extends JpaRepository<TarifProduitExtra, Integer> {
    @Query("SELECT t FROM TarifProduitExtra t WHERE t.produitExtra.id = :produitId AND t.dateApplication <= :date ORDER BY t.dateApplication DESC LIMIT 1")
    Optional<TarifProduitExtra> findLatestTarifForDate(@Param("produitId") Integer produitId, @Param("date") LocalDateTime date);
}
