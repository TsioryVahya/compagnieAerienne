package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "diffusion")
public class Diffusion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nom;

    @ManyToOne
    @JoinColumn(name = "id_societe")
    private Societe societe;
}
