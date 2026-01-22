package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "tarif_pub")
public class TarifPub {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, precision = 15, scale = 2)
    private BigDecimal montant;

    @Column(name = "date_application")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateApplication = LocalDate.now();
}
