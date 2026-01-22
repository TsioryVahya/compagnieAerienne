package com.companieaerienne.controllers;

import com.companieaerienne.entities.DiffusionProgrammation;
import com.companieaerienne.entities.VolProgrammation;
import com.companieaerienne.services.DiffusionService;
import com.companieaerienne.services.PaymentPubliciteService;
import com.companieaerienne.services.PubliciteService;
import com.companieaerienne.services.VolProgrammationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Map;

@Controller
@RequestMapping("/publicites")
public class PubliciteController {

    @Autowired
    private PubliciteService publiciteService;

    @Autowired
    private DiffusionService diffusionService;

    @Autowired
    private VolProgrammationService volProgrammationService;

    @Autowired
    private PaymentPubliciteService paymentService;

    @GetMapping
    public String findAll(Model model) {
        model.addAttribute("activePage", "publicites");
        model.addAttribute("programmations", publiciteService.findAll());
        return "diffusion-pub/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("activePage", "publicites");
        model.addAttribute("programmation", new DiffusionProgrammation());
        model.addAttribute("diffusions", diffusionService.findAll());
        model.addAttribute("vols", volProgrammationService.findAll());
        return "diffusion-pub/create";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "publicites");
        model.addAttribute("programmation", publiciteService.findById(id).orElseThrow());
        model.addAttribute("diffusions", diffusionService.findAll());
        model.addAttribute("vols", volProgrammationService.findAll());
        return "diffusion-pub/create";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("programmation") DiffusionProgrammation entity) {
        if (entity.getVolProgrammation() != null && entity.getVolProgrammation().getId() != null) {
            VolProgrammation vol = volProgrammationService.findById(entity.getVolProgrammation().getId())
                    .orElseThrow(() -> new RuntimeException("Vol non trouvé"));
            
            if (vol.getDateHeure() != null) {
                entity.setDateProgrammation(vol.getDateHeure().toLocalDate());
                entity.setVolProgrammation(vol);
            } else {
                // Fallback ou erreur si la date du vol est manquante
                throw new RuntimeException("Le vol sélectionné n'a pas de date/heure définie");
            }
        } else {
            throw new RuntimeException("Un vol doit être sélectionné pour la programmation");
        }
        
        publiciteService.save(entity);
        return "redirect:/publicites";
    }

    @GetMapping("/delete/{id}")
    public String deleteById(@PathVariable Integer id) {
        publiciteService.deleteById(id);
        return "redirect:/publicites";
    }

    @GetMapping("/payer/{id}")
    public String paymentForm(@PathVariable Integer id, Model model) {
        DiffusionProgrammation dp = publiciteService.findById(id).orElseThrow();
        model.addAttribute("activePage", "publicites");
        model.addAttribute("programmation", dp);
        model.addAttribute("totalPaid", paymentService.getTotalPaidForProgrammation(id));
        return "diffusion-pub/payment";
    }

    @PostMapping("/payer/save")
    public String savePayment(
            @RequestParam Integer programmationId,
            @RequestParam BigDecimal montant,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime datePayment) {
        paymentService.savePayment(programmationId, montant, datePayment);
        return "redirect:/publicites";
    }

    @GetMapping("/rapport-ca")
    public String rapportCA(
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month,
            Model model) {
        
        // On ne force plus l'année/mois si on veut permettre "Tous les temps"
        // Mais par défaut, on peut vouloir le mois en cours si rien n'est spécifié lors du premier chargement
        // Sauf si on veut explicitement "Tous les temps" par défaut. 
        // L'utilisateur a demandé "Tous les temps", donc on va permettre null.

        Map<String, Long> counts = publiciteService.getDiffusionCountBySociete(year, month);
        Map<String, BigDecimal> amounts = publiciteService.getCABySociete(year, month);
        Map<String, BigDecimal> paidAmounts = publiciteService.getPaidBySociete(year, month);
        BigDecimal totalCA = publiciteService.calculateTotalCA(year, month);
        BigDecimal totalPaid = paidAmounts.values().stream().reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("activePage", "rapport-ca-pub");
        model.addAttribute("selectedYear", year);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("counts", counts);
        model.addAttribute("amounts", amounts);
        model.addAttribute("paidAmounts", paidAmounts);
        model.addAttribute("totalCA", totalCA);
        model.addAttribute("totalPaid", totalPaid);

        return "publicite/rapport-ca";
    }

    @GetMapping("/etat-comptes")
    public String etatComptes(
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month,
            Model model) {
        
        Map<String, BigDecimal> amounts = publiciteService.getCABySociete(year, month);
        Map<String, BigDecimal> paidAmounts = publiciteService.getPaidBySociete(year, month);
        BigDecimal totalCA = publiciteService.calculateTotalCA(year, month);
        BigDecimal totalPaid = paidAmounts.values().stream().reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("activePage", "etat-comptes-pub");
        model.addAttribute("selectedYear", year);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("amounts", amounts);
        model.addAttribute("paidAmounts", paidAmounts);
        model.addAttribute("totalCA", totalCA);
        model.addAttribute("totalPaid", totalPaid);

        return "publicite/etat-comptes";
    }
}
