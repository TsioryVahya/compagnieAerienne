package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "diffusion_programmation")
public class DiffusionProgrammation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_diffusion")
    private Diffusion diffusion;

    @ManyToOne
    @JoinColumn(name = "id_vol_programmation")
    private VolProgrammation volProgrammation;

    @Column(name = "nombre_diffusions")
    private Integer nombreDiffusions = 1;

    @Column(name = "date_programmation")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateProgrammation;
}
