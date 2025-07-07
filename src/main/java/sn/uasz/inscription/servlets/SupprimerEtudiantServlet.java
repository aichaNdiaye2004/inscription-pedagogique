package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;

@WebServlet("/supprimer-etudiant")
public class SupprimerEtudiantServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ine = request.getParameter("ine");

        if (ine != null && !ine.isEmpty()) {
            etudiantDao.deleteByIne(ine);
        }

        response.sendRedirect("liste-etudiants");
    }
}