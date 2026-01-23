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
    private com.companieaerienne.services.TypePassagerService typePassagerService;

    @Autowired
    private com.companieaerienne.services.AvionService avionService;

    @Autowired
    private com.companieaerienne.services.RemiseTarifService remiseTarifService;

    @Autowired
    private com.companieaerienne.services.PubliciteService publiciteService;

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

    @GetMapping("/rapport-ca-global")
    public String rapportCAGlobal(Model model) {
        List<VolProgrammation> programmations = volProgrammationService.findAll();
        
        Map<Integer, BigDecimal> ticketRevenues = new HashMap<>();
        Map<Integer, BigDecimal> pubRevenues = new HashMap<>();
        Map<Integer, BigDecimal> pubPaid = new HashMap<>();
        Map<Integer, BigDecimal> pubRemaining = new HashMap<>();
        Map<Integer, BigDecimal> totalRevenues = new HashMap<>();

        for (VolProgrammation p : programmations) {
            BigDecimal ticketRev = volProgrammationService.calculateRevenue(p);
            BigDecimal pubRev = volProgrammationService.calculatePubliciteRevenue(p);
            BigDecimal paid = volProgrammationService.calculatePublicitePaid(p);
            BigDecimal remaining = volProgrammationService.calculatePubliciteRemaining(p);
            
            ticketRevenues.put(p.getId(), ticketRev);
            pubRevenues.put(p.getId(), pubRev);
            pubPaid.put(p.getId(), paid);
            pubRemaining.put(p.getId(), remaining);
            totalRevenues.put(p.getId(), ticketRev.add(pubRev));
        }
        
        model.addAttribute("programmations", programmations);
        model.addAttribute("ticketRevenues", ticketRevenues);
        model.addAttribute("pubRevenues", pubRevenues);
        model.addAttribute("pubPaid", pubPaid);
        model.addAttribute("pubRemaining", pubRemaining);
        model.addAttribute("totalRevenues", totalRevenues);
        model.addAttribute("activePage", "rapport-ca-global");
        
        return "vol-programmation/rapport-ca-global";
    }

    @GetMapping("/revenus-details/{id}")
    public String revenusDetails(@PathVariable Integer id, Model model) {
        VolProgrammation p = volProgrammationService.findById(id).orElseThrow();
        List<com.companieaerienne.entities.DiffusionProgrammation> pubs = publiciteService.findByVolProgrammationId(id);
        
        Map<Integer, BigDecimal> pubTotals = new HashMap<>();
        Map<Integer, BigDecimal> pubPaids = new HashMap<>();
        Map<Integer, BigDecimal> pubRemainings = new HashMap<>();
        
        for (com.companieaerienne.entities.DiffusionProgrammation pub : pubs) {
            pubTotals.put(pub.getId(), publiciteService.getMontantForProgrammationPublic(pub));
            pubPaids.put(pub.getId(), publiciteService.getDejaPaye(pub));
            pubRemainings.put(pub.getId(), publiciteService.getResteAPayer(pub));
        }
        
        model.addAttribute("programmation", p);
        model.addAttribute("pubs", pubs);
        model.addAttribute("pubTotals", pubTotals);
        model.addAttribute("pubPaids", pubPaids);
        model.addAttribute("pubRemainings", pubRemainings);
        model.addAttribute("ticketRevenue", volProgrammationService.calculateRevenue(p));
        model.addAttribute("activePage", "rapport-ca-global");
        
        return "vol-programmation/revenus-details";
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
        BigDecimal potentialRevenue = volProgrammationService.calculatePotentialRevenue(programmation);

        // Calculer les revenus par classe et par type de passager
        Map<Integer, Map<Integer, Integer>> countByClasseAndType = new HashMap<>();
        Map<Integer, Map<Integer, BigDecimal>> revenueByClasseAndType = new HashMap<>();
        
        for (com.companieaerienne.entities.Reservation res : programmation.getReservations()) {
            if (res.getDetailsPlaces() != null) {
                for (com.companieaerienne.entities.ReservationPlace rp : res.getDetailsPlaces()) {
                    // Trouver la classe du siège
                    final int place = rp.getPlace();
                    ClassePlace cp = configurations.stream()
                        .filter(conf -> place >= conf.getPlaceDebut() && place <= conf.getPlaceFin())
                        .findFirst()
                        .orElse(null);
                    
                    if (cp != null && rp.getTypePassager() != null) {
                        int classeId = cp.getClasse().getId();
                        int typeId = rp.getTypePassager().getId();
                        
                        // Compter les passagers
                        countByClasseAndType.computeIfAbsent(classeId, k -> new HashMap<>())
                            .merge(typeId, 1, Integer::sum);
                        
                        // Calculer le revenu (tarif pour cette classe et ce type)
                        BigDecimal tarif = programmation.getTarifs().stream()
                            .filter(t -> t.getClasse().getId().equals(classeId))
                            .filter(t -> t.getTypePassager() != null && t.getTypePassager().getId().equals(typeId))
                            .map(TarifVol::getTarif)
                            .findFirst()
                            .orElse(BigDecimal.ZERO);
                        
                        revenueByClasseAndType.computeIfAbsent(classeId, k -> new HashMap<>())
                            .merge(typeId, tarif, BigDecimal::add);
                    }
                }
            }
        }

        // Calculer les revenus potentiels par classe (en utilisant le tarif adulte ou le tarif moyen?)
        // Pour simplifier, on va juste passer tous les tarifs à la vue
        Map<Integer, Map<Integer, BigDecimal>> allTariffs = new HashMap<>();
        for (TarifVol t : programmation.getTarifs()) {
            if (t.getTypePassager() != null) {
                allTariffs.computeIfAbsent(t.getClasse().getId(), k -> new HashMap<>())
                    .put(t.getTypePassager().getId(), t.getTarif());
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
        model.addAttribute("typePassagers", typePassagerService.findAll());
        model.addAttribute("configurations", configurations);
        model.addAttribute("availableSeats", availableSeatsByClasse);
        model.addAttribute("occupiedCountByClasse", occupiedCountByClasse);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("potentialRevenue", potentialRevenue);
        model.addAttribute("countByClasseAndType", countByClasseAndType);
        model.addAttribute("revenueByClasseAndType", revenueByClasseAndType);
        model.addAttribute("allTariffs", allTariffs);
        model.addAttribute("allStatuts", statutVolService.findAll());
        model.addAttribute("activePage", "programmation");
        return "vol-programmation/details";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("vols", volService.findAll());
        model.addAttribute("avions", avionService.findAll());
        model.addAttribute("classes", classeService.findAll());
        model.addAttribute("typePassagers", typePassagerService.findAll());
        model.addAttribute("remises", remiseTarifService.findGlobalOrByVolProgrammationId(null));
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
        model.addAttribute("typePassagers", typePassagerService.findAll());
        model.addAttribute("remises", remiseTarifService.findGlobalOrByVolProgrammationId(id));
        model.addAttribute("programmation", programmation);
        
        // Charger les tarifs existants pour les pré-remplir dans le formulaire
        List<TarifVol> tarifs = tarifVolService.findByVolProgrammationId(programmation.getId());
        tarifs.forEach(t -> {
            String key = "tarif_" + t.getClasse().getId();
            if (t.getTypePassager() != null) {
                key += "_" + t.getTypePassager().getId();
            }
            model.addAttribute(key, t.getTarif());
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
        
        // Enregistrer les tarifs pour chaque classe et type de passager
        List<TarifVol> existingTarifs = tarifVolService.findByVolProgrammationId(savedProg.getId());
        List<com.companieaerienne.entities.Classe> classes = classeService.findAll();
        List<com.companieaerienne.entities.TypePassager> typePassagers = typePassagerService.findAll();
        
        classes.forEach(classe -> {
            typePassagers.forEach(type -> {
                String tarifKey = "tarif_" + classe.getId() + "_" + type.getId();
                if (allParams.containsKey(tarifKey)) {
                    try {
                        BigDecimal tarifValue = new BigDecimal(allParams.get(tarifKey));
                        
                        // Chercher si un tarif existe déjà pour cette classe et ce type
                        TarifVol tarif = existingTarifs.stream()
                            .filter(t -> t.getClasse().getId().equals(classe.getId()))
                            .filter(t -> t.getTypePassager() != null && t.getTypePassager().getId().equals(type.getId()))
                            .findFirst()
                            .orElse(new TarifVol());
                        
                        tarif.setVolProgrammation(savedProg);
                        tarif.setClasse(classe);
                        tarif.setTypePassager(type);
                        tarif.setTarif(tarifValue);
                        tarifVolService.save(tarif);
                    } catch (NumberFormatException e) {
                        // Log error or ignore
                    }
                }
            });
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
