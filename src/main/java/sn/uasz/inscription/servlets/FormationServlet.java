package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.Formation;
import sn.uasz.inscription.entities.UE;

import java.io.IOException;
import java.util.List;

@WebServlet("/formations")
public class FormationServlet extends HttpServlet {

    private FormationDao formationDao = new FormationDao();
    private UEDao ueDao = new UEDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Cas d'ajout : préparer le formulaire vide + liste des UEs
            List<UE> ues = ueDao.findAll();
            request.setAttribute("ues", ues);
            request.getRequestDispatcher("ajouter-formation.jsp").forward(request, response);
            return;
        }

        if ("edit".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Formation formation = formationDao.findById(id);
            request.setAttribute("formation", formation);

            List<UE> ues = ueDao.findAll();
            request.setAttribute("ues", ues);

            request.getRequestDispatcher("ajouter-formation.jsp").forward(request, response);
            return;
        } else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            formationDao.delete(id);
            response.sendRedirect("formations");
            return;
        }

        // Affichage liste des formations (par défaut)
        List<Formation> formations = formationDao.findAll();
        request.setAttribute("formations", formations);
        request.getRequestDispatcher("formations.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String intitule = request.getParameter("intitule");
        String niveau = request.getParameter("niveau");
        String nomResponsable = request.getParameter("nomResponsable");
        String emailResponsable = request.getParameter("emailResponsable");
        String[] ueCodes = request.getParameterValues("ueId"); // Plusieurs UEs possibles

        Formation formation;
        if (idParam == null || idParam.isEmpty()) {
            formation = new Formation();
        } else {
            Long id = Long.parseLong(idParam);
            formation = formationDao.findById(id);
            formation.getUes().clear(); // Vider les anciennes UEs
        }

        formation.setIntitule(intitule);
        formation.setNiveau(niveau);
        formation.setNomResponsable(nomResponsable);
        formation.setEmailResponsable(emailResponsable);

        if (ueCodes != null) {
            for (String code : ueCodes) {
                Long ueId = Long.parseLong(code);
                UE ue = ueDao.findById(ueId);
                if (ue != null) {
                    formation.getUes().add(ue);
                }
            }
        }

        if (idParam == null || idParam.isEmpty()) {
            formationDao.create(formation);
            request.setAttribute("message", "Formation ajoutée avec succès !");
        } else {
            formationDao.update(formation);
            request.setAttribute("message", "Formation modifiée avec succès !");
        }

        List<Formation> formations = formationDao.findAll();
        List<UE> ues = ueDao.findAll();
        request.setAttribute("formations", formations);
        request.setAttribute("ues", ues);
        request.getRequestDispatcher("formations.jsp").forward(request, response);
    }
}
