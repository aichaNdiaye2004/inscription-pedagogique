package sn.uasz.inscription.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "ues")
public class UE {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 20)
    private String code;

    @Column(nullable = false, length = 100)
    private String nom;

    @Column(name = "volume_horaire", nullable = false)
    private int volumeHoraire;

    @Column(nullable = false)
    private double coefficient;

    @Column(nullable = false)
    private int credits;

    @Column(name = "enseignant_responsable", length = 100)
    private String enseignantResponsable;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "formation_id")
    private Formation formation;

    // Constructeurs
    public UE() {}

    public UE(String code, String nom) {
        this.code = code;
        this.nom = nom;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public int getVolumeHoraire() {
        return volumeHoraire;
    }

    public void setVolumeHoraire(int volumeHoraire) {
        this.volumeHoraire = volumeHoraire;
    }

    public double getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(double coefficient) {
        this.coefficient = coefficient;
    }

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        this.credits = credits;
    }

    public String getEnseignantResponsable() {
        return enseignantResponsable;
    }

    public void setEnseignantResponsable(String enseignantResponsable) {
        this.enseignantResponsable = enseignantResponsable;
    }

    public Formation getFormation() {
        return formation;
    }

    public void setFormation(Formation formation) {
        this.formation = formation;
    }
}
