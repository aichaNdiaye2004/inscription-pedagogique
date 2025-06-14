package sn.uasz.inscription.entities;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "etudiant")
public class Etudiant {

    @Id
    @Column(name = "ine", length = 15, nullable = false, unique = true)
    private String ine;

    @Column(nullable = false, length = 50)
    private String prenom;

    @Column(nullable = false, length = 50)
    private String nom;

    @Column(name = "date_naissance")
    private LocalDate dateNaissance;

    @Column(length = 1)
    private String sexe;

    @Column(length = 200)
    private String adresse;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "groupe_td")
    private Integer groupeTD;

    @Column(name = "groupe_tp")
    private Integer groupeTP;

    @ManyToOne
    @JoinColumn(name = "formation_id")
    private Formation formation;

    // Constructeurs
    public Etudiant() {}

    public Etudiant(String ine, String prenom, String nom, String email) {
        this.ine = ine;
        this.prenom = prenom;
        this.nom = nom;
        this.email = email;
    }

    // Getters & Setters
    public String getIne() { return ine; }
    public void setIne(String ine) { this.ine = ine; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public LocalDate getDateNaissance() { return dateNaissance; }
    public void setDateNaissance(LocalDate dateNaissance) { this.dateNaissance = dateNaissance; }

    public String getSexe() { return sexe; }
    public void setSexe(String sexe) { this.sexe = sexe; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Integer getGroupeTD() { return groupeTD; }
    public void setGroupeTD(Integer groupeTD) { this.groupeTD = groupeTD; }

    public Integer getGroupeTP() { return groupeTP; }
    public void setGroupeTP(Integer groupeTP) { this.groupeTP = groupeTP; }

    public Formation getFormation() {
        return formation;
    }

    public void setFormation(Formation formation) {
        this.formation = formation;
    }
    
}
