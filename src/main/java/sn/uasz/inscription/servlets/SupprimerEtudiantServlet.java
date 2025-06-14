package sn.uasz.inscription.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sn.uasz.inscription.dao.EtudiantDao;

import java.io.IOException;

@WebServlet("/supprimer-etudiant")
public class SupprimerEtudiantServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String ine = request.getParameter("ine");
        if (ine != null && !ine.trim().isEmpty()) {
            try {
                etudiantDao.delete(ine);
                request.getSession().setAttribute("success", "Étudiant supprimé avec succès.");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "Erreur technique lors de la suppression.");
            }
        } else {
            request.getSession().setAttribute("error", "INE invalide pour la suppression.");
        }
        response.sendRedirect(request.getContextPath() + "/liste-etudiants");
    }
}
