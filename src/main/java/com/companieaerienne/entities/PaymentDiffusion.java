package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "payment_diffusion")
public class PaymentDiffusion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_societe")
    private Societe societe;

    @ManyToOne
    @JoinColumn(name = "id_diffusion_programmation")
    private DiffusionProgrammation diffusionProgrammation;
}
