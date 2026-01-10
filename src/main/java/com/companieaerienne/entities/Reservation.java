package com.companieaerienne.entities;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Entity
@Data
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_vol_programmation")
    private VolProgrammation volProgrammation;

    @ManyToOne
    @JoinColumn(name = "id_client")
    private Client client;

    @Column(name = "nombre_places")
    private Integer nombrePlaces;

    @ElementCollection
    @CollectionTable(name = "reservation_place", joinColumns = @JoinColumn(name = "id_reservation"))
    @Column(name = "place")
    private List<Integer> placesSelectionnees; // Liste des numéros de places sélectionnées
}
