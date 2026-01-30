package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
@Table(name = "vente_produit")
public class VenteProduit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_client")
    private Client client;

    @Column(name = "date_vente")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime dateVente = LocalDateTime.now();

    @OneToMany(mappedBy = "venteProduit", cascade = CascadeType.ALL)
    private List<VenteProduitDetail> details;
}
