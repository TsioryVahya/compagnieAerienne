package com.companieaerienne.repositories;

import com.companieaerienne.entities.VenteProduit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface VenteProduitRepository extends JpaRepository<VenteProduit, Integer> {
    List<VenteProduit> findByClientId(Integer clientId);
}
