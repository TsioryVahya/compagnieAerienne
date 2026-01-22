package com.companieaerienne.repositories;

import com.companieaerienne.entities.Diffusion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiffusionRepository extends JpaRepository<Diffusion, Integer> {
}
