package com.companieaerienne.repositories;

import com.companieaerienne.entities.VenteProduitDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VenteProduitDetailRepository extends JpaRepository<VenteProduitDetail, Integer> {
}
