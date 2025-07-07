package sn.uasz.inscription.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "configuration")
public class Configuration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int tailleMaxGroupeTD;
    private int tailleMaxGroupeTP;
    private String cle;
    private String valeur;

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public int getTailleMaxGroupeTD() { return tailleMaxGroupeTD; }
    public void setTailleMaxGroupeTD(int tailleMaxGroupeTD) { this.tailleMaxGroupeTD = tailleMaxGroupeTD; }

    public int getTailleMaxGroupeTP() { return tailleMaxGroupeTP; }
    public void setTailleMaxGroupeTP(int tailleMaxGroupeTP) { this.tailleMaxGroupeTP = tailleMaxGroupeTP; }

    public String getCle() { return cle; }
    public void setCle(String cle) { this.cle = cle; }

    public String getValeur() { return valeur; }
    public void setValeur(String valeur) { this.valeur = valeur; }
}
