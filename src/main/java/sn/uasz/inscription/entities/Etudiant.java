package sn.uasz.inscription.entities;

import jakarta.persistence.*;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Etudiant {

    @Id
    private String ine;
    private String nom;
    private String prenom;
    private String sexe;
    private String adresse;
    private String email;
    
    @Column(name = "motDePasse")
    private String motDePasse;


    private Integer groupeTD;
    private Integer groupeTP;


    @Column(name = "date_naissance", nullable = false)
    private LocalDate dateNaissance;

    @ManyToMany(cascade = CascadeType.MERGE)
    @JoinTable(
        name = "etudiant_ue_optionnelles",
        joinColumns = @JoinColumn(name = "etudiant_ine"),
        inverseJoinColumns = @JoinColumn(name = "ue_code")
    )
    private List<UE> uesOptionnelles = new ArrayList<>();


    
    public List<UE> getUesOptionnelles() {
        return uesOptionnelles;
    }
    
    

    public void setUesOptionnelles(List<UE> uesOptionnelles) {
        this.uesOptionnelles = uesOptionnelles;
    }
    public void addUeOptionnelle(UE ue) {
        if (!uesOptionnelles.contains(ue)) {
            uesOptionnelles.add(ue);
        }
    }

    public void removeUeOptionnelle(UE ue) {
        uesOptionnelles.remove(ue);
    }

    @ManyToMany
    @JoinTable(
        name = "etudiant_ue", // une table pivot globale
        joinColumns = @JoinColumn(name = "etudiant_ine"),
        inverseJoinColumns = @JoinColumn(name = "ue_code")
    )
    private List<UE> ues = new ArrayList<>();

    public List<UE> getUes() {
        return ues;
    }

    public void setUes(List<UE> ues) {
        this.ues = ues;
    }


    @ManyToOne(fetch = FetchType.EAGER) 
    @JoinColumn(name = "formation_id", nullable = false)
    private Formation formation;


    // Getters & setters

    public String getIne() {
        return ine;
    }

    public void setIne(String ine) {
        this.ine = ine;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getGroupeTD() {
        return groupeTD;
    }

    public void setGroupeTD(int groupeTD) {
        this.groupeTD = groupeTD;
    }

    public int getGroupeTP() {
        return groupeTP;
    }

    public void setGroupeTP(int groupeTP) {
        this.groupeTP = groupeTP;
    }

    public boolean isInscriptionValidee() {
        return inscriptionValidee;
    }

    public void setInscriptionValidee(boolean inscriptionValidee) {
        this.inscriptionValidee = inscriptionValidee;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public Formation getFormation() {
        return formation;
    }

    public void setFormation(Formation formation) {
        this.formation = formation;
    }
    
    public String getDateNaissanceStr() {
        if (this.dateNaissance != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return this.dateNaissance.format(formatter);
        }
        return "";
    }
    
    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    
    @Override
    public String toString() {
        return ine + " - " + nom + " " + prenom;
    }

    private Boolean inscriptionValidee;

    public Boolean getInscriptionValidee() {
        return inscriptionValidee;
    }

    public void setInscriptionValidee(Boolean inscriptionValidee) {
        this.inscriptionValidee = inscriptionValidee;
    }

}
