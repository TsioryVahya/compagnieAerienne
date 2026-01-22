package com.companieaerienne.repositories;

import com.companieaerienne.entities.PaymentDiffusion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface PaymentDiffusionRepository extends JpaRepository<PaymentDiffusion, Integer> {
    Optional<PaymentDiffusion> findByDiffusionProgrammationId(Integer diffusionProgrammationId);
}
