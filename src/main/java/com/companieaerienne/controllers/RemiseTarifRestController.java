package com.companieaerienne.controllers;

import com.companieaerienne.entities.RemiseTarif;
import com.companieaerienne.repositories.ClasseRepository;
import com.companieaerienne.repositories.RemiseTarifRepository;
import com.companieaerienne.repositories.TypePassagerRepository;
import com.companieaerienne.repositories.VolProgrammationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;

@Controller
@RequestMapping("/remise-tarif")
public class RemiseTarifRestController {

    @Autowired
    private RemiseTarifRepository remiseTarifRepository;

    @Autowired
    private VolProgrammationRepository volProgrammationRepository;

    @Autowired
    private ClasseRepository classeRepository;

    @Autowired
    private TypePassagerRepository typePassagerRepository;

    @PostMapping("/save-quick")
    public ResponseEntity<?> saveQuick(
            @RequestParam("id_vol_programmation") Integer volProgId,
            @RequestParam("id_classe") Integer classeId,
            @RequestParam("id_type_passager_appliquer") Integer appliquerId,
            @RequestParam("id_type_passager_reference") Integer referenceId,
            @RequestParam("remise") BigDecimal remise,
            @RequestParam("formule") String formule) {

        try {
            // Chercher si une remise spécifique existe déjà pour ce vol/classe/type
            RemiseTarif entity = remiseTarifRepository
                    .findByVolProgrammationIdAndClasseIdAndTypePassagerAppliquerId(volProgId, classeId, appliquerId)
                    .orElse(new RemiseTarif());

            entity.setVolProgrammation(volProgrammationRepository.findById(volProgId).orElseThrow());
            entity.setClasse(classeRepository.findById(classeId).orElseThrow());
            entity.setTypePassagerAppliquer(typePassagerRepository.findById(appliquerId).orElseThrow());
            entity.setTypePassagerReference(typePassagerRepository.findById(referenceId).orElseThrow());
            entity.setRemise(remise);
            entity.setFormule(formule);

            remiseTarifRepository.save(entity);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
