package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.entities.Formation;
import sn.uasz.inscription.entities.UE;

import java.io.IOException;
import java.util.List;

@WebServlet("/ListerUEsServlet")
public class ListerUEsServlet extends HttpServlet {
    private final UEDao ueDao = new UEDao();
    private final FormationDao formationDao = new FormationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String formationIdStr = request.getParameter("formationId");
        String type = request.getParameter("type"); // "obligatoire" ou "optionnelle"

        List<Formation> formations = formationDao.findAll();
        request.setAttribute("formations", formations);

        if (formationIdStr != null && !formationIdStr.isEmpty()) {
            Long formationId = Long.parseLong(formationIdStr);
            boolean obligatoire = "obligatoire".equals(type);

            List<UE> ues = ueDao.findByFormationAndType(formationId, obligatoire);
            request.setAttribute("ues", ues);
            request.setAttribute("selectedFormationId", formationId);
            request.setAttribute("selectedType", type);
        }

        request.getRequestDispatcher("lister-ues.jsp").forward(request, response);
    }
}
