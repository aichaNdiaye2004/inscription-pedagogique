package sn.uasz.inscription.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;

@WebServlet("/modifier-etudiant")
public class ModifierEtudiantServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ine = request.getParameter("ine");
        if (ine != null) {
            Etudiant etu = etudiantDao.findById(ine);
            request.setAttribute("etudiant", etu);
            request.getRequestDispatcher("/modifierEtudiant.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/liste-etudiants");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ine = request.getParameter("ine");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");

        try {
            Etudiant etu = etudiantDao.findById(ine);
            etu.setPrenom(prenom);
            etu.setNom(nom);
            etu.setEmail(email);

            etudiantDao.save(etu);

            response.sendRedirect(request.getContextPath() + "/liste-etudiants");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la mise à jour.");
            request.getRequestDispatcher("/modifierEtudiant.jsp").forward(request, response);
        }
    }
}
