package sn.uasz.inscription.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;

public class AjouterEtudiantServlet extends HttpServlet {
    private final EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Affiche le formulaire d'ajout, JSP dans webapp donc chemin relatif racine de l'app
        request.getRequestDispatcher("/ajouterEtudiant.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- 1. On peut récupérer et valider hors du try si on veut distinguer InvalidArg separately
        String ine     = request.getParameter("ine");
        String prenom  = request.getParameter("prenom");
        String nom     = request.getParameter("nom");
        String email   = request.getParameter("email");

        try {
            // --- 2. Validation (lance IllegalArgumentException si KO)
            if (ine == null || ine.isBlank())       throw new IllegalArgumentException("L'INE est obligatoire");
            if (ine.length() > 15)                  throw new IllegalArgumentException("INE trop long");
            if (prenom == null || prenom.isBlank()) throw new IllegalArgumentException("Le prénom est obligatoire");
            if (nom == null || nom.isBlank())       throw new IllegalArgumentException("Le nom est obligatoire");
            if (email == null || email.isBlank())   throw new IllegalArgumentException("L'email est obligatoire");
            if (!email.contains("@"))               throw new IllegalArgumentException("Format d'email invalide");

            // --- 3. Création de l'entité
            Etudiant etu = new Etudiant();
            etu.setIne(ine.trim());
            etu.setPrenom(prenom.trim());
            etu.setNom(nom.trim());
            etu.setEmail(email.trim());

            // --- 4. Persistance (peut lancer RuntimeException si pb JPA/SQL)
            etudiantDao.save(etu);

            // --- 5. Tout s'est bien passé, on redirige vers la liste
            request.getSession().setAttribute("success", "Étudiant ajouté avec succès");
            response.sendRedirect(request.getContextPath() + "/liste-etudiants");
            return;

        } catch (IllegalArgumentException e) {
            // Erreur de validation : on renvoie sur le formulaire
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/ajouterEtudiant.jsp").forward(request, response);
            return;

        } catch (Exception e) {
            // Erreur technique (JPA, DB, etc.) : 
            e.printStackTrace();
            // Optionnel : mettre un message générique
            request.setAttribute("error", "Erreur technique lors de l'enregistrement.");
            request.getRequestDispatcher("/ajouterEtudiant.jsp").forward(request, response);
            return;
        }
    }


    private String getAndValidateIne(HttpServletRequest request) {
        String ine = request.getParameter("ine");
        if (ine == null || ine.trim().isEmpty()) {
            throw new IllegalArgumentException("L'INE est obligatoire");
        }
        if (ine.length() > 15) {
            throw new IllegalArgumentException("L'INE ne doit pas dépasser 15 caractères");
        }
        return ine.trim();
    }

    private String getAndValidateField(HttpServletRequest request, String field, String errorMessage) {
        String value = request.getParameter(field);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(errorMessage);
        }
        return value.trim();
    }

    private String getAndValidateEmail(HttpServletRequest request) {
        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("L'email est obligatoire");
        }
        if (!email.contains("@")) {
            throw new IllegalArgumentException("Format d'email invalide");
        }
        return email.trim();
    }
}
