package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/inscription")
public class InscriptionEtudiantServlet extends HttpServlet {
    private final EtudiantDao etudiantDao = new EtudiantDao();
    private final FormationDao formationDao = new FormationDao();
    private final UEDao ueDao = new UEDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Formation> formations = formationDao.findAll();
        List<UE> uesOptionnelles = ueDao.findAllOptionnelles(); // ← ici

        request.setAttribute("formations", formations);
        request.setAttribute("uesOptionnelles", uesOptionnelles); // ← ici

        request.getRequestDispatcher("inscription.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String ine = request.getParameter("ine");
            String prenom = request.getParameter("prenom");
            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String motDePasse = request.getParameter("motDePasse");  // <-- ajouté ici
            String sexe = request.getParameter("sexe");
            String adresse = request.getParameter("adresse");
            String dateNaissanceStr = request.getParameter("dateNaissance");

            int groupeTD = Integer.parseInt(request.getParameter("groupeTD"));
            int groupeTP = Integer.parseInt(request.getParameter("groupeTP"));
            Long formationId = Long.parseLong(request.getParameter("formationId"));
            String[] uesOptionnellesCodes = request.getParameterValues("uesOptionnelles");

            Formation formation = formationDao.findById(formationId);
            if (formation == null) {
                request.setAttribute("error", "Formation inconnue.");
                doGet(request, response);
                return;
            }

            LocalDate dateNaissance = LocalDate.parse(dateNaissanceStr);

            Etudiant e = new Etudiant();
            e.setIne(ine);
            e.setPrenom(prenom);
            e.setNom(nom);
            e.setEmail(email);
            e.setMotDePasse(motDePasse);  // <-- setter ajouté ici
            e.setSexe(sexe);
            e.setAdresse(adresse);
            e.setDateNaissance(dateNaissance);
            e.setGroupeTD(groupeTD);
            e.setGroupeTP(groupeTP);
            e.setInscriptionValidee(false);
            e.setFormation(formation);

            if (uesOptionnellesCodes != null) {
                List<UE> ues = new ArrayList<>();
                for (String codeStr : uesOptionnellesCodes) {
                    try {
                        Long code = Long.valueOf(codeStr);
                        UE ue = ueDao.findById(code);
                        if (ue != null) ues.add(ue);
                    } catch (NumberFormatException e1) {
                        // ignorer le code invalide
                    }
                }
                e.setUesOptionnelles(ues);
            }

            etudiantDao.create(e);

            request.setAttribute("message", "Inscription réussie !");
            request.getRequestDispatcher("inscription.jsp").forward(request, response);

        } catch (Exception ex) {
            request.setAttribute("error", "Erreur lors de l'inscription : " + ex.getMessage());
            doGet(request, response);
        }
    }
}