package com.companieaerienne.controllers;

import com.companieaerienne.entities.Vol;
import com.companieaerienne.entities.VolProgrammation;
import com.companieaerienne.entities.TarifVol;
import com.companieaerienne.entities.ClassePlace;
import com.companieaerienne.services.VolProgrammationService;
import com.companieaerienne.services.VolService;
import com.companieaerienne.services.ClasseService;
import com.companieaerienne.services.TarifVolService;
import com.companieaerienne.services.ClassePlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/vol-programmation")
public class VolProgrammationController {

    @Autowired
    private VolProgrammationService volProgrammationService;

    @Autowired
    private VolService volService;

    @Autowired
    private ClasseService classeService;

    @Autowired
    private TarifVolService tarifVolService;

    @Autowired
    private com.companieaerienne.services.ReservationService reservationService;

    @Autowired
    private ClassePlaceService classePlaceService;

    @Autowired
    private com.companieaerienne.services.VolProgrammationStatutService volProgrammationStatutService;

    @Autowired
    private com.companieaerienne.services.StatutVolService statutVolService;

    @Autowired
    private com.companieaerienne.services.AvionService avionService;

    @GetMapping
    public String list(@RequestParam(required = false) String depart,
                      @RequestParam(required = false) String arrivee,
                      Model model) {
        List<VolProgrammation> programmations = volProgrammationService.findAll();
        
        if (depart != null && !depart.isEmpty()) {
            programmations = programmations.stream()
                .filter(p -> p.getVol().getAeroportDepart().getNom().toLowerCase().contains(depart.toLowerCase()))
                .collect(Collectors.toList());
        }
        
        if (arrivee != null && !arrivee.isEmpty()) {
            programmations = programmations.stream()
                .filter(p -> p.getVol().getAeroportArrivee().getNom().toLowerCase().contains(arrivee.toLowerCase()))
                .collect(Collectors.toList());
        }
        
        // Calculer le chiffre d'affaires et obtenir le statut pour chaque programmation
        Map<Integer, BigDecimal> revenues = new HashMap<>();
        Map<Integer, com.companieaerienne.entities.StatutVol> currentStatuts = new HashMap<>();
        List<com.companieaerienne.entities.VolProgrammationStatut> allStatutHistory = volProgrammationStatutService.findAll();

        for (VolProgrammation p : programmations) {
            revenues.put(p.getId(), volProgrammationService.calculateRevenue(p));
            
            // Trouver le statut le plus récent
            allStatutHistory.stream()
                .filter(s -> s.getVolProgrammation().getId().equals(p.getId()))
                .max(Comparator.comparing(com.companieaerienne.entities.VolProgrammationStatut::getDate))
                .ifPresent(s -> currentStatuts.put(p.getId(), s.getStatut()));
        }
        
        model.addAttribute("programmations", programmations);
        model.addAttribute("revenues", revenues);
        model.addAttribute("currentStatuts", currentStatuts);
        model.addAttribute("activePage", "programmation");
        return "vol-programmation/list";
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable Integer id, Model model) {
        VolProgrammation programmation = volProgrammationService.findById(id).orElseThrow();
        
        // Force loading of lazy collections for the view
        programmation.getReservations().size();
        programmation.getTarifs().size();
        
        // Calculer les places disponibles par classe
        List<ClassePlace> configurations = classePlaceService.findByAvion(programmation.getAvion().getId());
        Set<Integer> occupiedSeats = programmation.getReservations().stream()
                .filter(r -> r.getPlacesSelectionnees() != null)
                .flatMap(r -> r.getPlacesSelectionnees().stream())
                .collect(Collectors.toSet());
        
        Map<Integer, List<Integer>> availableSeatsByClasse = new HashMap<>();
        Map<Integer, Integer> occupiedCountByClasse = new HashMap<>();
        
        for (ClassePlace cp : configurations) {
            List<Integer> available = new ArrayList<>();
            int count = 0;
            for (int i = cp.getPlaceDebut(); i <= cp.getPlaceFin(); i++) {
                if (!occupiedSeats.contains(i)) {
                    available.add(i);
                } else {
                    count++;
                }
            }
            availableSeatsByClasse.put(cp.getClasse().getId(), available);
            occupiedCountByClasse.put(cp.getClasse().getId(), count);
        }

        // Calculer le chiffre d'affaires
        BigDecimal totalRevenue = volProgrammationService.calculateRevenue(programmation);

        // Calculer les revenus potentiels par classe et total
        Map<Integer, BigDecimal> potentialRevenueByClasse = new HashMap<>();
        Map<Integer, BigDecimal> tariffsByClasse = new HashMap<>();
        BigDecimal totalPotentialRevenue = BigDecimal.ZERO;

        for (ClassePlace cp : configurations) {
            BigDecimal tarif = programmation.getTarifs().stream()
                .filter(t -> t.getClasse().getId().equals(cp.getClasse().getId()))
                .map(TarifVol::getTarif)
                .findFirst()
                .orElse(BigDecimal.ZERO);
            
            tariffsByClasse.put(cp.getClasse().getId(), tarif);
            int capacity = cp.getPlaceFin() - cp.getPlaceDebut() + 1;
            BigDecimal potential = tarif.multiply(new BigDecimal(capacity));
            potentialRevenueByClasse.put(cp.getClasse().getId(), potential);
            totalPotentialRevenue = totalPotentialRevenue.add(potential);
        }

        // Trouver le statut actuel
        List<com.companieaerienne.entities.VolProgrammationStatut> allStatutHistory = volProgrammationStatutService.findAll();
        allStatutHistory.stream()
            .filter(s -> s.getVolProgrammation().getId().equals(programmation.getId()))
            .max(Comparator.comparing(com.companieaerienne.entities.VolProgrammationStatut::getDate))
            .ifPresent(s -> model.addAttribute("currentStatut", s.getStatut()));
        
        model.addAttribute("programmation", programmation);
        model.addAttribute("reservations", programmation.getReservations());
        model.addAttribute("tarifs", programmation.getTarifs());
        model.addAttribute("configurations", configurations);
        model.addAttribute("availableSeats", availableSeatsByClasse);
        model.addAttribute("occupiedCountByClasse", occupiedCountByClasse);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("potentialRevenueByClasse", potentialRevenueByClasse);
        model.addAttribute("tariffsByClasse", tariffsByClasse);
        model.addAttribute("totalPotentialRevenue", totalPotentialRevenue);
        model.addAttribute("allStatuts", statutVolService.findAll());
        model.addAttribute("activePage", "programmation");
        return "vol-programmation/details";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("vols", volService.findAll());
        model.addAttribute("avions", avionService.findAll());
        model.addAttribute("classes", classeService.findAll());
        model.addAttribute("programmation", new VolProgrammation());
        model.addAttribute("activePage", "programmation");
        return "vol-programmation/create";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        VolProgrammation programmation = volProgrammationService.findById(id).orElseThrow();
        model.addAttribute("vols", volService.findAll());
        model.addAttribute("avions", avionService.findAll());
        model.addAttribute("classes", classeService.findAll());
        model.addAttribute("programmation", programmation);
        
        // Charger les tarifs existants pour les pré-remplir dans le formulaire
        List<TarifVol> tarifs = tarifVolService.findByVolProgrammationId(programmation.getId());
        tarifs.forEach(t -> {
            model.addAttribute("tarif_" + t.getClasse().getId(), t.getTarif());
        });

        // Charger le statut actuel
        List<com.companieaerienne.entities.VolProgrammationStatut> allStatutHistory = volProgrammationStatutService.findAll();
        allStatutHistory.stream()
            .filter(s -> s.getVolProgrammation().getId().equals(programmation.getId()))
            .max(Comparator.comparing(com.companieaerienne.entities.VolProgrammationStatut::getDate))
            .ifPresent(s -> model.addAttribute("currentStatut", s.getStatut()));
        
        model.addAttribute("allStatuts", statutVolService.findAll());
        model.addAttribute("activePage", "programmation");
        return "vol-programmation/create";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute VolProgrammation programmation, @RequestParam Map<String, String> allParams) {
        boolean isNew = programmation.getId() == null;
        VolProgrammation savedProg = volProgrammationService.save(programmation);
        
        // Enregistrer les tarifs pour chaque classe
        classeService.findAll().forEach(classe -> {
            String tarifKey = "tarif_" + classe.getId();
            if (allParams.containsKey(tarifKey)) {
                try {
                    BigDecimal tarifValue = new BigDecimal(allParams.get(tarifKey));
                    TarifVol tarif = new TarifVol();
                    tarif.setVolProgrammation(savedProg);
                    tarif.setClasse(classe);
                    tarif.setTarif(tarifValue);
                    tarifVolService.save(tarif);
                } catch (NumberFormatException e) {
                    // Log error or ignore
                }
            }
        });

        // Gérer le statut
        if (isNew) {
            // Pour une nouvelle programmation, mettre le statut "En cours" par défaut
            statutVolService.findAll().stream()
                .filter(s -> s.getNom().equalsIgnoreCase("En cours"))
                .findFirst()
                .ifPresent(statut -> {
                    com.companieaerienne.entities.VolProgrammationStatut vps = new com.companieaerienne.entities.VolProgrammationStatut();
                    vps.setVolProgrammation(savedProg);
                    vps.setStatut(statut);
                    volProgrammationStatutService.save(vps);
                });
        } else if (allParams.containsKey("statutId")) {
            // Pour une modification, mettre à jour le statut si fourni
            Integer statutId = Integer.parseInt(allParams.get("statutId"));
            statutVolService.findById(statutId).ifPresent(statut -> {
                // Vérifier si le statut a changé par rapport au dernier
                List<com.companieaerienne.entities.VolProgrammationStatut> history = volProgrammationStatutService.findAll();
                boolean changed = history.stream()
                    .filter(s -> s.getVolProgrammation().getId().equals(savedProg.getId()))
                    .max(Comparator.comparing(com.companieaerienne.entities.VolProgrammationStatut::getDate))
                    .map(s -> !s.getStatut().getId().equals(statut.getId()))
                    .orElse(true);

                if (changed) {
                    com.companieaerienne.entities.VolProgrammationStatut vps = new com.companieaerienne.entities.VolProgrammationStatut();
                    vps.setVolProgrammation(savedProg);
                    vps.setStatut(statut);
                    volProgrammationStatutService.save(vps);
                }
            });
        }

        return "redirect:/vol-programmation";
    }

    @GetMapping("/{id}/delete")
    public String delete(@PathVariable Integer id) {
        volProgrammationService.deleteById(id);
        return "redirect:/vol-programmation";
    }
}
