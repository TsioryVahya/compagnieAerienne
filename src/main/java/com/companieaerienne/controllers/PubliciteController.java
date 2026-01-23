package com.companieaerienne.controllers;

import com.companieaerienne.entities.DiffusionProgrammation;
import com.companieaerienne.entities.Societe;
import com.companieaerienne.entities.VolProgrammation;
import com.companieaerienne.services.DiffusionService;
import com.companieaerienne.services.PaymentPubliciteService;
import com.companieaerienne.services.PubliciteService;
import com.companieaerienne.services.SocieteService;
import com.companieaerienne.services.VolProgrammationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    private SocieteService societeService;

    @Autowired
    private PaymentPubliciteService paymentService;

    @GetMapping
    public String findAll(Model model) {
        model.addAttribute("activePage", "publicites");
        List<DiffusionProgrammation> programmations = publiciteService.findAll();
        model.addAttribute("programmations", programmations);
        
        Map<Integer, BigDecimal> dejasPayes = programmations.stream()
                .collect(Collectors.toMap(
                        DiffusionProgrammation::getId,
                        p -> publiciteService.getDejaPaye(p)
                ));
        Map<Integer, BigDecimal> restesAPayer = programmations.stream()
                .collect(Collectors.toMap(
                        DiffusionProgrammation::getId,
                        p -> publiciteService.getResteAPayer(p)
                ));
        model.addAttribute("dejasPayes", dejasPayes);
        model.addAttribute("restesAPayer", restesAPayer);
        
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

    @GetMapping("/factures")
    public String selectSocieteForInvoices(Model model) {
        model.addAttribute("activePage", "factures-societe");
        model.addAttribute("societes", societeService.findAll());
        return "publicite/select-societe-invoices";
    }

    @GetMapping("/factures/{societeId}")
    public String viewInvoicesBySociete(@PathVariable Integer societeId, Model model) {
        model.addAttribute("activePage", "factures-societe");
        
        com.companieaerienne.entities.Societe societe = societeService.findById(societeId)
                .orElseThrow(() -> new IllegalArgumentException("Société non trouvée"));
        model.addAttribute("societe", societe);
        
        List<DiffusionProgrammation> programmations = publiciteService.findBySocieteId(societeId);
        model.addAttribute("programmations", programmations);
        
        Map<Integer, BigDecimal> dejasPayes = programmations.stream()
                .collect(Collectors.toMap(
                        DiffusionProgrammation::getId,
                        p -> publiciteService.getDejaPaye(p)
                ));
        Map<Integer, BigDecimal> restesAPayer = programmations.stream()
                .collect(Collectors.toMap(
                        DiffusionProgrammation::getId,
                        p -> publiciteService.getResteAPayer(p)
                ));
        Map<Integer, BigDecimal> montantsTotaux = programmations.stream()
                .collect(Collectors.toMap(
                        DiffusionProgrammation::getId,
                        p -> publiciteService.getMontantForProgrammationPublic(p)
                ));
                
        model.addAttribute("dejasPayes", dejasPayes);
        model.addAttribute("restesAPayer", restesAPayer);
        model.addAttribute("montantsTotaux", montantsTotaux);
        
        return "publicite/factures-societe";
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

    @GetMapping("/payer-societe")
    public String selectSocieteForPayment(Model model) {
        model.addAttribute("activePage", "payer-societe");
        model.addAttribute("societes", societeService.findAll());
        return "publicite/select-societe-payment";
    }

    @GetMapping("/payer-societe/{societeId}")
    public String paymentSocieteForm(@PathVariable Integer societeId, Model model) {
        Societe societe = societeService.findById(societeId).orElseThrow();
        
        Map<String, BigDecimal> caBySociete = publiciteService.getCABySociete(null, null);
        Map<String, BigDecimal> paidBySociete = publiciteService.getPaidBySociete(null, null);
        
        BigDecimal totalDu = caBySociete.getOrDefault(societe.getNom(), BigDecimal.ZERO);
        BigDecimal totalPaye = paidBySociete.getOrDefault(societe.getNom(), BigDecimal.ZERO);
        
        model.addAttribute("activePage", "payer-societe");
        model.addAttribute("societe", societe);
        model.addAttribute("totalDu", totalDu);
        model.addAttribute("totalPaye", totalPaye);
        model.addAttribute("resteAPayer", totalDu.subtract(totalPaye));
        
        return "publicite/payment-societe";
    }

    @PostMapping("/payer-societe/save")
    public String savePaymentSociete(
            @RequestParam Integer societeId,
            @RequestParam BigDecimal montant,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime datePayment) {
        paymentService.savePaymentForSociete(societeId, montant, datePayment);
        return "redirect:/publicites/factures/" + societeId;
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
