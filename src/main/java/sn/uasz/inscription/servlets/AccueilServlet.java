package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;

@WebServlet(name = "AccueilServlet", urlPatterns = {"/accueil"})
public class AccueilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Etudiant etudiant = (Etudiant) session.getAttribute("etudiant");
        if (etudiant == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // L’étudiant est dans la session, forward vers la JSP
        request.getRequestDispatcher("/accueilEtudiant.jsp").forward(request, response);
    }
}
