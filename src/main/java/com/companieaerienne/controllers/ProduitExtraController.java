package com.companieaerienne.controllers;

import com.companieaerienne.entities.*;
import com.companieaerienne.services.ClientService;
import com.companieaerienne.services.ProduitExtraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/produits-extra")
public class ProduitExtraController {

    @Autowired
    private ProduitExtraService produitExtraService;

    @Autowired
    private ClientService clientService;

    @GetMapping
    public String listProducts(Model model) {
        List<ProduitExtra> produits = produitExtraService.findAllProducts();
        Map<Integer, BigDecimal> prices = produits.stream()
                .collect(Collectors.toMap(ProduitExtra::getId, p -> produitExtraService.getLatestPrice(p.getId())));
        
        model.addAttribute("produits", produits);
        model.addAttribute("prices", prices);
        model.addAttribute("activePage", "produits-extra");
        return "produit-extra/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("produit", new ProduitExtra());
        model.addAttribute("activePage", "produits-extra");
        return "produit-extra/create";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        ProduitExtra produit = produitExtraService.findProductById(id).orElseThrow();
        model.addAttribute("produit", produit);
        model.addAttribute("currentPrice", produitExtraService.getLatestPrice(id));
        model.addAttribute("activePage", "produits-extra");
        return "produit-extra/create";
    }

    @PostMapping("/save")
    public String saveProduct(@ModelAttribute ProduitExtra produit, @RequestParam BigDecimal prix) {
        produitExtraService.saveProduct(produit, prix);
        return "redirect:/produits-extra";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Integer id) {
        produitExtraService.deleteProduct(id);
        return "redirect:/produits-extra";
    }

    @GetMapping("/ventes")
    public String listSales(Model model) {
        model.addAttribute("ventes", produitExtraService.findAllSales());
        model.addAttribute("activePage", "ventes-extra");
        return "produit-extra/ventes-list";
    }

    @GetMapping("/vendre")
    public String sellForm(Model model) {
        List<ProduitExtra> produits = produitExtraService.findAllProducts();
        Map<Integer, BigDecimal> prices = produits.stream()
                .collect(Collectors.toMap(ProduitExtra::getId, p -> produitExtraService.getLatestPrice(p.getId())));
        
        model.addAttribute("clients", clientService.findAll());
        model.addAttribute("produits", produits);
        model.addAttribute("prices", prices);
        model.addAttribute("currentDateTime", LocalDateTime.now());
        model.addAttribute("activePage", "ventes-extra");
        return "produit-extra/vendre";
    }

    @PostMapping("/vendre")
    public String processSale(@RequestParam Integer clientId,
                             @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateVente,
                             @RequestParam Map<String, String> params) {
        Client client = clientService.findById(clientId).orElseThrow();
        VenteProduit vente = new VenteProduit();
        vente.setClient(client);
        vente.setDateVente(dateVente);
        
        List<VenteProduitDetail> details = new ArrayList<>();
        
        // Parse product quantities from params (pattern: quantite_{produitId})
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (entry.getKey().startsWith("quantite_")) {
                int quantite = Integer.parseInt(entry.getValue());
                if (quantite > 0) {
                    int produitId = Integer.parseInt(entry.getKey().substring(9));
                    ProduitExtra produit = produitExtraService.findProductById(produitId).orElseThrow();
                    
                    VenteProduitDetail detail = new VenteProduitDetail();
                    detail.setProduitExtra(produit);
                    detail.setQuantite(quantite);
                    detail.setPrixUnitaire(produitExtraService.getLatestPrice(produitId));
                    details.add(detail);
                }
            }
        }
        
        if (!details.isEmpty()) {
            vente.setDetails(details);
            produitExtraService.saveSale(vente);
        }
        
        return "redirect:/produits-extra/ventes";
    }

    @GetMapping("/ventes/edit/{id}")
    public String editSaleForm(@PathVariable Integer id, Model model) {
        VenteProduit vente = produitExtraService.findSaleById(id).orElseThrow();
        List<ProduitExtra> produits = produitExtraService.findAllProducts();
        Map<Integer, BigDecimal> prices = produits.stream()
                .collect(Collectors.toMap(ProduitExtra::getId, p -> produitExtraService.getLatestPrice(p.getId())));
        
        // Map current quantities for the form
        Map<Integer, Integer> currentQuantities = vente.getDetails().stream()
                .collect(Collectors.toMap(d -> d.getProduitExtra().getId(), VenteProduitDetail::getQuantite));
        
        model.addAttribute("vente", vente);
        model.addAttribute("clients", clientService.findAll());
        model.addAttribute("produits", produits);
        model.addAttribute("prices", prices);
        model.addAttribute("currentQuantities", currentQuantities);
        model.addAttribute("activePage", "ventes-extra");
        return "produit-extra/vendre";
    }

    @PostMapping("/ventes/update")
    public String updateSale(@RequestParam Integer id,
                            @RequestParam Integer clientId,
                            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dateVente,
                            @RequestParam Map<String, String> params) {
        // Simple update strategy: delete and recreate to manage details easily
        produitExtraService.deleteSale(id);
        return processSale(clientId, dateVente, params);
    }

    @GetMapping("/ventes/delete/{id}")
    public String deleteSale(@PathVariable Integer id) {
        produitExtraService.deleteSale(id);
        return "redirect:/produits-extra/ventes";
    }
}
