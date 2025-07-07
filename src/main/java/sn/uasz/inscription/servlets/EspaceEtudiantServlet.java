package sn.uasz.inscription.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import sn.uasz.inscription.entities.Etudiant;
import sn.uasz.inscription.entities.UE;

import java.io.IOException;
import java.util.List;


public class EspaceEtudiantServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Etudiant etudiant = (Etudiant) session.getAttribute("etudiantConnecte");
        if (etudiant == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Récupérer la liste des UE de l'étudiant
        List<UE> listeUEs = etudiant.getUesOptionnelles();

        // Mettre la liste en attribut de requête
        request.setAttribute("listeUEs", listeUEs);

        // Forward vers la JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/espace_etudiant.jsp");
        dispatcher.forward(request, response);
    }
}
