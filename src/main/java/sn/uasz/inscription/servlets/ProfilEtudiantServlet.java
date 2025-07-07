package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;

@WebServlet(name = "ProfilEtudiantServlet", urlPatterns = {"/profil-etudiant"})
public class ProfilEtudiantServlet extends HttpServlet {

    private EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Exemple : l'INE est récupéré depuis la session ou paramètre (selon authentification)
        HttpSession session = request.getSession(false);
        String ine = (session != null) ? (String) session.getAttribute("ine") : null;

        if (ine == null) {
            // Pas connecté, redirection vers login
            response.sendRedirect("login.jsp");
            return; 
        }

        Etudiant etudiant = etudiantDao.findByIne(ine);
        if (etudiant == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Étudiant introuvable");
            return;
        }

        request.setAttribute("etudiant", etudiant);

        // Affiche la page profil avec les données
        request.getRequestDispatcher("/profil-etudiant.jsp").forward(request, response);
    }
}
