package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.entities.Etudiant;
import sn.uasz.inscription.entities.Formation;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/modifier-etudiant")
public class ModifierEtudiantServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();
    private final FormationDao formationDao = new FormationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ine = request.getParameter("ine");

        Etudiant etudiant = etudiantDao.findByIne(ine);
        List<Formation> formations = formationDao.findAll();

        if (etudiant == null) {
            request.setAttribute("error", "Étudiant introuvable.");
            response.sendRedirect("liste-etudiants");
            return;
        }

        request.setAttribute("etudiant", etudiant);
        request.setAttribute("formations", formations);
        request.getRequestDispatcher("modifier-etudiant.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ine = request.getParameter("ine");
        Etudiant etudiant = etudiantDao.findByIne(ine);

        if (etudiant == null) {
            request.setAttribute("error", "Étudiant introuvable.");
            response.sendRedirect("liste-etudiants");
            return;
        }

        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String dateNaissanceStr = request.getParameter("dateNaissance");
        String sexe = request.getParameter("sexe");
        String adresse = request.getParameter("adresse");
        String email = request.getParameter("email");
        String formationIdStr = request.getParameter("formationId");

        try {
            LocalDate dateNaissance = LocalDate.parse(dateNaissanceStr);
            Long formationId = Long.parseLong(formationIdStr);
            Formation formation = formationDao.findById(formationId);

            etudiant.setPrenom(prenom);
            etudiant.setNom(nom);
            etudiant.setDateNaissance(dateNaissance);
            etudiant.setSexe(sexe);
            etudiant.setAdresse(adresse);
            etudiant.setEmail(email);
            etudiant.setFormation(formation);

            etudiantDao.save(etudiant);
            response.sendRedirect("liste-etudiants");

        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la modification : " + e.getMessage());
            request.setAttribute("etudiant", etudiant);
            request.setAttribute("formations", formationDao.findAll());
            request.getRequestDispatcher("modifier-etudiant.jsp").forward(request, response);
        }
    }
}
