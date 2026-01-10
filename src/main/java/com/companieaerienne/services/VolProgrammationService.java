package com.companieaerienne.services;

import com.companieaerienne.entities.VolProgrammation;
import com.companieaerienne.repositories.VolProgrammationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class VolProgrammationService {
    @Autowired
    private VolProgrammationRepository repository;

    public List<VolProgrammation> findAll() {
        return repository.findAll();
    }

    public Optional<VolProgrammation> findById(Integer id) {
        return repository.findById(id);
    }

    public VolProgrammation save(VolProgrammation entity) {
        return repository.save(entity);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }

    public List<VolProgrammation> findByVol(com.companieaerienne.entities.Vol vol) {
        return repository.findByVol(vol);
    }
}
