package sn.uasz.inscription.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(name = "EtudiantServlet", urlPatterns = {"/etudiants"})
public class EtudiantServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Etudiant> etudiants = etudiantDao.findAll();
            request.setAttribute("etudiants", etudiants);
            request.getRequestDispatcher("/WEB-INF/views/etudiants.jsp").forward(request, response);
        } catch (Exception e) {
            handleError(request, response, "Erreur lors de la récupération des étudiants", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Validation des champs obligatoires
            String ine = validateRequiredField(request, "ine", "L'INE est obligatoire");
            String prenom = validateRequiredField(request, "prenom", "Le prénom est obligatoire");
            String nom = validateRequiredField(request, "nom", "Le nom est obligatoire");
            String email = validateRequiredField(request, "email", "L'email est obligatoire");

            // Création de l'étudiant
            Etudiant etudiant = createEtudiantFromRequest(request);

            // Persistance
            etudiantDao.create(etudiant);
            
            // Redirection avec message de succès
            request.getSession().setAttribute("successMessage", "Étudiant ajouté avec succès");
            response.sendRedirect(request.getContextPath() + "/etudiants");
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response); // Réaffiche le formulaire avec l'erreur
        } catch (Exception e) {
            handleError(request, response, "Erreur lors de l'ajout de l'étudiant", e);
        }
    }

    private Etudiant createEtudiantFromRequest(HttpServletRequest request) {
        Etudiant etudiant = new Etudiant();
        
        // Champs obligatoires
        etudiant.setIne(request.getParameter("ine"));
        etudiant.setPrenom(request.getParameter("prenom"));
        etudiant.setNom(request.getParameter("nom"));
        etudiant.setEmail(request.getParameter("email"));
        
        // Champs optionnels
        String dateNaissanceStr = request.getParameter("dateNaissance");
        if (dateNaissanceStr != null && !dateNaissanceStr.isEmpty()) {
            try {
                etudiant.setDateNaissance(LocalDate.parse(dateNaissanceStr, DATE_FORMATTER));
            } catch (DateTimeParseException e) {
                throw new IllegalArgumentException("Format de date invalide. Utilisez AAAA-MM-JJ");
            }
        }
        
        etudiant.setSexe(request.getParameter("sexe"));
        etudiant.setAdresse(request.getParameter("adresse"));
        
        return etudiant;
    }

    private String validateRequiredField(HttpServletRequest request, String fieldName, String errorMessage) {
        String value = request.getParameter(fieldName);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(errorMessage);
        }
        return value.trim();
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                            String message, Exception e) throws ServletException, IOException {
        e.printStackTrace(); // Log l'erreur dans les logs du serveur
        request.setAttribute("errorMessage", message + ": " + e.getMessage());
        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }
}