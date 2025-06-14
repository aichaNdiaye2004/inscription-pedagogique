package sn.uasz.inscription.entities;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "formations")
public class Formation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String intitule;

    @Column(length = 50)
    private String niveau;

    private String description;

    @Column(name = "responsable_nom")
    private String responsable;

    @Column(name = "responsable_email")
    private String emailResponsable;

    @OneToMany(mappedBy = "formation", cascade = CascadeType.ALL)
    private List<Etudiant> etudiants;

    // 🔹 Constructeurs
    public Formation() {}

    public Formation(String intitule, String niveau) {
        this.intitule = intitule;
        this.niveau = niveau;
    }

    // 🔹 Getters et Setters
    public Long getId() {
        return id;
    }

    public String getIntitule() {
        return intitule;
    }

    public void setIntitule(String intitule) {
        this.intitule = intitule;
    }

    public String getNiveau() {
        return niveau;
    }

    public void setNiveau(String niveau) {
        this.niveau = niveau;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getEmailResponsable() {
        return emailResponsable;
    }

    public void setEmailResponsable(String emailResponsable) {
        this.emailResponsable = emailResponsable;
    }

    public List<Etudiant> getEtudiants() {
        return etudiants;
    }

    public void setEtudiants(List<Etudiant> etudiants) {
        this.etudiants = etudiants;
    }

    // 🔹 Méthodes utilitaires (optionnel)
    public String getNom() {
        return intitule;
    }
}
