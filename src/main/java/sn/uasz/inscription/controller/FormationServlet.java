package sn.uasz.inscription.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.entities.Formation;

import java.io.IOException;
import java.util.List;


public class FormationServlet extends HttpServlet {

    private FormationDao formationDao = new FormationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Formation> formations = formationDao.findAll();
        request.setAttribute("formations", formations);
        request.getRequestDispatcher("/WEB-INF/views/formations.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String intitule = request.getParameter("intitule");
        String niveau = request.getParameter("niveau");
        String responsableNom = request.getParameter("responsableNom");
        String responsableEmail = request.getParameter("responsableEmail");

        Formation formation = new Formation();
        formation.setIntitule(intitule);
        formation.setNiveau(niveau);
        formation.setResponsable(responsableNom);
        formation.setEmailResponsable(responsableEmail);

        formationDao.create(formation);

        response.sendRedirect(request.getContextPath() + "/formations");
    }
}
