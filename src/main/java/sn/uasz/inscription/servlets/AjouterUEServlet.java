package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.Formation;
import sn.uasz.inscription.entities.UE;
import sn.uasz.inscription.dao.FormationDao;

@WebServlet("/AjouterUEServlet")
public class AjouterUEServlet extends HttpServlet {
    private final UEDao ueDao = new UEDao();
    private final FormationDao formationDao = new FormationDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String nom = request.getParameter("nom");
        int volumeHoraire = Integer.parseInt(request.getParameter("volumeHoraire"));
        float coefficient = Float.parseFloat(request.getParameter("coefficient"));
        int credits = Integer.parseInt(request.getParameter("credits"));
        String enseignant = request.getParameter("enseignant");
        boolean obligatoire = Boolean.parseBoolean(request.getParameter("obligatoire"));
        Long formationId = Long.parseLong(request.getParameter("formationId"));

        Formation formation = formationDao.findById(formationId);

        UE ue = new UE();
       
        ue.setNom(nom);
        ue.setVolumeHoraire(volumeHoraire);
        ue.setCoefficient(coefficient);
        ue.setCredits(credits);
        ue.setEnseignant(enseignant);
        ue.setObligatoire(obligatoire);
        ue.setFormation(formation);

        ueDao.create(ue);

        response.sendRedirect("ListerUEsServlet");

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Formation> formations = formationDao.findAll();
        System.out.println("Formations chargées : " + formations.size()); // debug console
        request.setAttribute("formations", formations);
        request.getRequestDispatcher("ajouter-ue.jsp").forward(request, response);
    }


}
