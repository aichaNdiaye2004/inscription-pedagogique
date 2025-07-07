package sn.uasz.inscription.entities;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "ue")
public class UE {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long code;  // type numérique, pas String


    private String nom;
    private int volumeHoraire;
    private float coefficient;
    private Integer credits;
    private String enseignant;
    private boolean obligatoire;

    @ManyToOne
    @JoinColumn(name = "formation_id") // clé étrangère explicite
    private Formation formation;

    // --- Getters et Setters ---

    public Long getCode() {
        return code; 
    }
    public void setCode(Long code) {
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

    public float getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(float coefficient) {
        this.coefficient = coefficient;
    }

    public Integer getCredits() {
        return credits;
    }

    public void setCredits(Integer credits) {
        this.credits = credits;
    }

    public String getEnseignant() {
        return enseignant;
    }

    public void setEnseignant(String enseignant) {
        this.enseignant = enseignant;
    }

    public boolean isObligatoire() {
        return obligatoire;
    }

    public void setObligatoire(boolean obligatoire) {
        this.obligatoire = obligatoire;
    }

    public Formation getFormation() {
        return formation;
    }

    public void setFormation(Formation formation) {
        this.formation = formation;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UE ue = (UE) o;
        return code != null && code.equals(ue.code);
    }


    @Override
    public int hashCode() {
        return code != null ? code.hashCode() : 0;
    }
    @ManyToMany(mappedBy = "ues")
    private List<Etudiant> etudiantsInscrits = new ArrayList<>();

    @ManyToMany(mappedBy = "uesOptionnelles")
    private List<Etudiant> etudiantsOptionnels = new ArrayList<>();

    public List<Etudiant> getEtudiantsInscrits() {
        return etudiantsInscrits;
    }

    public void setEtudiantsInscrits(List<Etudiant> etudiantsInscrits) {
        this.etudiantsInscrits = etudiantsInscrits;
    }

    public List<Etudiant> getEtudiantsOptionnels() {
        return etudiantsOptionnels;
    }

    public void setEtudiantsOptionnels(List<Etudiant> etudiantsOptionnels) {
        this.etudiantsOptionnels = etudiantsOptionnels;
    }

    public List<Etudiant> getAllEtudiants() {
        List<Etudiant> all = new ArrayList<>(etudiantsInscrits);
        for (Etudiant e : etudiantsOptionnels) {
            if (!all.contains(e)) {
                all.add(e);
            }
        }
        return all;
    }

    

}