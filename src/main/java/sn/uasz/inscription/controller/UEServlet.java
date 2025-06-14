package sn.uasz.inscription.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.UE;

import java.io.IOException;
import java.util.List;


public class UEServlet extends HttpServlet {

    private UEDao ueDao = new UEDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<UE> ues = ueDao.findAll();
        request.setAttribute("ues", ues);
        request.getRequestDispatcher("/WEB-INF/views/ues.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String nom = request.getParameter("nom");
        String volumeHoraireStr = request.getParameter("volumeHoraire");
        String coefficientStr = request.getParameter("coefficient");
        String creditsStr = request.getParameter("credits");
        String enseignantResponsable = request.getParameter("enseignantResponsable");

        int volumeHoraire = volumeHoraireStr != null && !volumeHoraireStr.isEmpty() ? Integer.parseInt(volumeHoraireStr) : 0;
        int coefficient = coefficientStr != null && !coefficientStr.isEmpty() ? Integer.parseInt(coefficientStr) : 0;
        int credits = creditsStr != null && !creditsStr.isEmpty() ? Integer.parseInt(creditsStr) : 0;

        UE ue = new UE();
        ue.setCode(code);
        ue.setNom(nom);
        ue.setVolumeHoraire(volumeHoraire);
        ue.setCoefficient(Double.valueOf(3));

        ue.setCredits(credits);
        ue.setEnseignantResponsable(enseignantResponsable);

        ueDao.create(ue);

        response.sendRedirect(request.getContextPath() + "/ues");
    }
}
