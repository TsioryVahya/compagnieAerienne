package com.companieaerienne.services;

import com.companieaerienne.entities.TarifPub;
import com.companieaerienne.repositories.TarifPubRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class TarifPubService {
    @Autowired
    private TarifPubRepository repository;

    public List<TarifPub> findAll() { return repository.findAll(); }
    public Optional<TarifPub> findById(Integer id) { return repository.findById(id); }
    public TarifPub save(TarifPub entity) { return repository.save(entity); }
    public void deleteById(Integer id) { repository.deleteById(id); }
}
