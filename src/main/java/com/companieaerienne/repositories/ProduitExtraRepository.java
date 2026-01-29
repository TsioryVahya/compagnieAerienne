package com.companieaerienne.repositories;

import com.companieaerienne.entities.ProduitExtra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProduitExtraRepository extends JpaRepository<ProduitExtra, Integer> {
}
