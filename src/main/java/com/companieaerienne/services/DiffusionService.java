package com.companieaerienne.services;

import com.companieaerienne.entities.Diffusion;
import com.companieaerienne.repositories.DiffusionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class DiffusionService {
    @Autowired
    private DiffusionRepository repository;

    public List<Diffusion> findAll() { return repository.findAll(); }
    public Optional<Diffusion> findById(Integer id) { return repository.findById(id); }
    public Diffusion save(Diffusion entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
