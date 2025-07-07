package sn.uasz.inscription.servlets;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.uasz.inscription.entities.Etudiant;
import sn.uasz.inscription.entities.Formation;
import sn.uasz.inscription.entities.UE;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.dao.UEDao;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
@WebServlet("/ajouter-etudiant")

public class AjouterEtudiantServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();
    private final FormationDao formationDao = new FormationDao();
    private final UEDao ueDao = new UEDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Formation> formations = formationDao.findAll();
        List<UE> uesOptionnelles = ueDao.findAllOptionnelles();
        System.out.println("Formations chargées : " + formations.size());

        request.setAttribute("formations", formations);
        request.setAttribute("uesOptionnelles", uesOptionnelles);
        request.getRequestDispatcher("ajouter-etudiant.jsp").forward(request, response);
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ine = request.getParameter("ine");
        String motDePasse = ine;
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String dateNaissanceStr = request.getParameter("dateNaissance");
        String sexe = request.getParameter("sexe");
        String adresse = request.getParameter("adresse");
        String email = request.getParameter("email");
        String formationIdStr = request.getParameter("formationId");
        String groupeTDStr = request.getParameter("groupeTD");
        Integer groupeTD = (groupeTDStr != null && !groupeTDStr.isEmpty()) ? Integer.parseInt(groupeTDStr) : null;

        String groupeTPStr = request.getParameter("groupeTP");
        Integer groupeTP = (groupeTPStr != null && !groupeTPStr.isEmpty()) ? Integer.parseInt(groupeTPStr) : null;


        LocalDate dateNaissance = null;
        Long formationId = null;
        try {
            dateNaissance = LocalDate.parse(dateNaissanceStr);
            formationId = Long.parseLong(formationIdStr);
        } catch (Exception e) {
            request.setAttribute("error", "Date ou formation invalide.");
            doGet(request, response);
            return;
        }

        Formation formation = formationDao.findById(formationId);
        if (formation == null) {
            request.setAttribute("error", "Formation inconnue.");
            doGet(request, response);
            return;
        }

        Etudiant etudiant = new Etudiant();
        etudiant.setIne(ine);
        etudiant.setPrenom(prenom);
        etudiant.setNom(nom);
        etudiant.setDateNaissance(dateNaissance);
        etudiant.setSexe(sexe);
        etudiant.setAdresse(adresse);
        etudiant.setEmail(email);
        etudiant.setFormation(formation);
        etudiant.setInscriptionValidee(false);

        etudiant.setGroupeTD(groupeTD);
        etudiant.setGroupeTP(groupeTP);


        try {
            etudiantDao.create(etudiant);
            response.sendRedirect("liste-etudiants");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de l'ajout de l'étudiant : " + e.getMessage());
            doGet(request, response);
            
        }
    }
}
