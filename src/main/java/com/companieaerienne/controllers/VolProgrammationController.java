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
            revenues.put(p.getId(), calculateRevenue(p));
            
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

    private BigDecimal calculateRevenue(VolProgrammation programmation) {
        if (programmation.getReservations() == null || programmation.getTarifs() == null) return BigDecimal.ZERO;
        
        List<ClassePlace> configurations = classePlaceService.findByAvion(programmation.getAvion().getId());
        BigDecimal total = BigDecimal.ZERO;
        
        for (com.companieaerienne.entities.Reservation res : programmation.getReservations()) {
            if (res.getPlacesSelectionnees() == null || res.getPlacesSelectionnees().isEmpty()) continue;
            
            for (Integer seatNum : res.getPlacesSelectionnees()) {
                // Déterminer la classe de ce siège
                Integer classeId = configurations.stream()
                    .filter(cp -> seatNum >= cp.getPlaceDebut() && seatNum <= cp.getPlaceFin())
                    .map(cp -> cp.getClasse().getId())
                    .findFirst()
                    .orElse(null);
                
                if (classeId != null) {
                    BigDecimal tarif = programmation.getTarifs().stream()
                        .filter(t -> t.getClasse().getId().equals(classeId))
                        .map(TarifVol::getTarif)
                        .findFirst()
                        .orElse(BigDecimal.ZERO);
                    
                    total = total.add(tarif);
                }
            }
        }
        return total;
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
        BigDecimal totalRevenue = BigDecimal.ZERO;
        
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
            
            // Calculer le chiffre d'affaires pour cette classe
            Optional<TarifVol> tarifOpt = programmation.getTarifs().stream()
                    .filter(t -> t.getClasse().getId().equals(cp.getClasse().getId()))
                    .findFirst();
            if (tarifOpt.isPresent()) {
                BigDecimal classRevenue = tarifOpt.get().getTarif().multiply(new BigDecimal(count));
                totalRevenue = totalRevenue.add(classRevenue);
            }
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
        model.addAttribute("allStatuts", statutVolService.findAll());
        model.addAttribute("activePage", "programmation");
        return "vol-programmation/details";
    }

    @Autowired
    private com.companieaerienne.services.AvionService avionService;

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
        
        model.addAttribute("activePage", "programmation");
        return "vol-programmation/create";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute VolProgrammation programmation, @RequestParam Map<String, String> allParams) {
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

        return "redirect:/vol-programmation";
    }

    @GetMapping("/{id}/delete")
    public String delete(@PathVariable Integer id) {
        volProgrammationService.deleteById(id);
        return "redirect:/vol-programmation";
    }
}
