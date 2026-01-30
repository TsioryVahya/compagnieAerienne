package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;

@Entity
@Data
@Table(name = "vente_produit_detail")
public class VenteProduitDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_vente_produit")
    private VenteProduit venteProduit;

    @ManyToOne
    @JoinColumn(name = "id_produit_extra")
    private ProduitExtra produitExtra;

    @Column(nullable = false)
    private Integer quantite;

    @Column(name = "prix_unitaire", nullable = false, precision = 10, scale = 2)
    private BigDecimal prixUnitaire;
}
