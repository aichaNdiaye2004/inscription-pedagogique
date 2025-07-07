package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.Formation;
import sn.uasz.inscription.entities.UE;

@WebServlet("/AjouterFormationServlet")
public class AjouterFormationServlet extends HttpServlet {

    private final FormationDao formationDao = new FormationDao();
    private final UEDao ueDao = new UEDao(); // Tu dois créer ce DAO s’il n’existe pas

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String intitule = request.getParameter("intitule");
        String niveau = request.getParameter("niveau");
        String emailResponsable = request.getParameter("emailResponsable");

        Formation formation;

        if (idStr != null && !idStr.isEmpty()) {
            Long id = Long.parseLong(idStr);
            formation = formationDao.findById(id);
            if (formation == null) {
                formation = new Formation();
            }
        } else {
            formation = new Formation();
        }

        formation.setIntitule(intitule);
        formation.setNiveau(niveau);
        formation.setEmailResponsable(emailResponsable);

        // Gestion des UEs cochées
        String[] ueIds = request.getParameterValues("ueIds");
        List<UE> ues = new ArrayList<>();
        if (ueIds != null) {
            for (String ueIdStr : ueIds) {
                try {
                    Long ueId = Long.parseLong(ueIdStr);
                    UE ue = ueDao.findById(ueId);
                    if (ue != null) {
                        ue.setFormation(formation); // Association côté UE (si bidirectionnelle)
                        ues.add(ue);
                    }
                } catch (NumberFormatException ignored) {
                }
            }
        }
        formation.setUes(new HashSet<>(ues));



        // Enregistrement
        if (formation.getId() == null) {
            formationDao.create(formation);
            request.setAttribute("message", "Formation ajoutée avec succès !");
        } else {
            formationDao.update(formation);
            request.setAttribute("message", "Formation modifiée avec succès !");
        }

        request.setAttribute("formation", formation);
        request.setAttribute("ues", ueDao.findAll());
        request.getRequestDispatcher("/ajouter-formation.jsp").forward(request, response);
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Charger toutes les UEs pour afficher la liste des checkbox
        List<UE> toutesLesUes = ueDao.findAll();
        request.setAttribute("ues", toutesLesUes);

        // Si on modifie une formation, on charge la formation existante
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            Long id = Long.parseLong(idStr);
            Formation formation = formationDao.findById(id);
            request.setAttribute("formation", formation);

            // Préparer la liste des codes des UEs associées pour cocher les cases dans JSP
            if (formation != null && formation.getUes() != null) {
                List<Long> ueIdsAssociees = formation.getUes().stream()
                    .map(UE::getCode) // ou getId() selon ta classe UE
                    .toList();
                request.setAttribute("ueIdsAssociees", ueIdsAssociees);
            }
        }

        request.getRequestDispatcher("/ajouter-formation.jsp").forward(request, response);
    }

}
