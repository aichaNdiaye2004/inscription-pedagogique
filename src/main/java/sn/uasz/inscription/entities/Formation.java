package sn.uasz.inscription.entities;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "formation")
public class Formation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String intitule;
    private String niveau;

    @Column(name = "nom_responsable")
    private String nomResponsable;

    @Column(name = "email_responsable")
    private String emailResponsable;

    @OneToMany(mappedBy = "formation", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Etudiant> etudiants = new HashSet<>();

    @OneToMany(mappedBy = "formation", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<UE> ues = new HashSet<>();

    // --- Getters et Setters ---

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getNomResponsable() {
        return nomResponsable;
    }

    public void setNomResponsable(String nomResponsable) {
        this.nomResponsable = nomResponsable;
    }

    public String getEmailResponsable() {
        return emailResponsable;
    }

    public void setEmailResponsable(String emailResponsable) {
        this.emailResponsable = emailResponsable;
    }

    public Set<Etudiant> getEtudiants() {
        return etudiants;
    }
    public void setEtudiants(Set<Etudiant> etudiants) {
        this.etudiants = etudiants;
        for (Etudiant e : etudiants) {
            e.setFormation(this);
        }
    }


    public void addEtudiant(Etudiant e) {
        etudiants.add(e);
        e.setFormation(this);
    }

    public void removeEtudiant(Etudiant e) {
        etudiants.remove(e);
        e.setFormation(null);
    }

    public Set<UE> getUes() {
        return ues;
    }

    public void setUes(Set<UE> ues) {
        this.ues = ues;
        for (UE ue : ues) {
            ue.setFormation(this);
        }
    }


    public void addUE(UE ue) {
        ues.add(ue);
        ue.setFormation(this);
    }

    public void removeUE(UE ue) {
        ues.remove(ue);
        ue.setFormation(null);
    }

    @Override
    public String toString() {
        return intitule + " (" + niveau + ")";
    }
}
