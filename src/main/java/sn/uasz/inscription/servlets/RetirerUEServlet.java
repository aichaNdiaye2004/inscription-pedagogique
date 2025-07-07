package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.dao.FormationDao;
import sn.uasz.inscription.entities.UE;
import sn.uasz.inscription.entities.Formation;

import java.io.IOException;
import java.util.List;

@WebServlet("/retirer-ue")
public class RetirerUEServlet extends HttpServlet {
    private final UEDao ueDao = new UEDao();
    private final FormationDao formationDao = new FormationDao(); // ✅

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codeStr = request.getParameter("code");
        
        if (codeStr != null && !codeStr.isEmpty()) {
            try {
                Long code = Long.valueOf(codeStr);
                UE ue = ueDao.findById(code);
                
                if (ue != null && !ue.isObligatoire()) {
                    ue.setFormation(null);
                    ueDao.update(ue);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Code UE invalide");
                
                // ✅ Ajouter la liste des formations avant d'afficher la page
                List<Formation> formations = formationDao.findAll();
                request.setAttribute("formations", formations);
                
                request.getRequestDispatcher("lister-ues.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Code UE manquant");

            // ✅ Ajouter la liste des formations avant d'afficher la page
            List<Formation> formations = formationDao.findAll();
            request.setAttribute("formations", formations);
            
            request.getRequestDispatcher("lister-ues.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("ListerUEFormationServlet");
    }
}
