package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "payment_details_diffusion")
public class PaymentDetailsDiffusion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_payment")
    private PaymentDiffusion payment;

    @Column(name = "date_payment")
    private LocalDateTime datePayment = LocalDateTime.now();

    @Column(precision = 15, scale = 2)
    private BigDecimal montant;
}
