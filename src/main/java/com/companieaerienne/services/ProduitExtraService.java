package com.companieaerienne.services;

import com.companieaerienne.entities.*;
import com.companieaerienne.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ProduitExtraService {

    @Autowired
    private ProduitExtraRepository produitExtraRepository;

    @Autowired
    private TarifProduitExtraRepository tarifRepository;

    @Autowired
    private VenteProduitRepository venteRepository;

    @Autowired
    private VenteProduitDetailRepository venteDetailRepository;

    public List<ProduitExtra> findAllProducts() {
        return produitExtraRepository.findAll();
    }

    public Optional<ProduitExtra> findProductById(Integer id) {
        return produitExtraRepository.findById(id);
    }

    public BigDecimal getLatestPrice(Integer produitId) {
        return tarifRepository.findLatestTarifForDate(produitId, LocalDateTime.now())
                .map(TarifProduitExtra::getPrix)
                .orElse(BigDecimal.ZERO);
    }

    public List<VenteProduit> findSalesByClient(Integer clientId) {
        return venteRepository.findByClientId(clientId);
    }

    @Transactional
    public VenteProduit saveSale(VenteProduit vente) {
        // First save the vente to get an ID
        VenteProduit savedVente = venteRepository.save(vente);
        
        // Ensure each detail has the correct price and link to the vente
        if (vente.getDetails() != null) {
            for (VenteProduitDetail detail : vente.getDetails()) {
                detail.setVenteProduit(savedVente);
                if (detail.getPrixUnitaire() == null) {
                    detail.setPrixUnitaire(getLatestPrice(detail.getProduitExtra().getId()));
                }
            }
            venteDetailRepository.saveAll(vente.getDetails());
        }
        
        return savedVente;
    }

    public List<VenteProduit> findAllSales() {
        return venteRepository.findAll();
    }

    public Optional<VenteProduit> findSaleById(Integer id) {
        return venteRepository.findById(id);
    }

    @Transactional
    public void deleteSale(Integer id) {
        venteRepository.deleteById(id);
    }

    public BigDecimal calculateMonthlyExtraRevenue(int year, int month) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1).minusSeconds(1);
        
        return venteRepository.findAll().stream()
                .filter(v -> !v.getDateVente().isBefore(start) && !v.getDateVente().isAfter(end))
                .flatMap(v -> v.getDetails().stream())
                .map(d -> d.getPrixUnitaire().multiply(BigDecimal.valueOf(d.getQuantite())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public List<VenteProduitDetail> findMonthlySaleDetails(int year, int month) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1).minusSeconds(1);
        
        return venteRepository.findAll().stream()
                .filter(v -> !v.getDateVente().isBefore(start) && !v.getDateVente().isAfter(end))
                .flatMap(v -> v.getDetails().stream())
                .collect(java.util.stream.Collectors.toList());
    }

    @Transactional
    public ProduitExtra saveProduct(ProduitExtra produit, BigDecimal prix) {
        ProduitExtra savedProduct = produitExtraRepository.save(produit);
        
        if (prix != null) {
            TarifProduitExtra tarif = new TarifProduitExtra();
            tarif.setProduitExtra(savedProduct);
            tarif.setPrix(prix);
            tarif.setDateApplication(LocalDateTime.now());
            tarifRepository.save(tarif);
        }
        
        return savedProduct;
    }

    public void deleteProduct(Integer id) {
        produitExtraRepository.deleteById(id);
    }
}
