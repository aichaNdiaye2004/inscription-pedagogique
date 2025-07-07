package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.UE;

import java.io.IOException;

@WebServlet("/modifier-ue")
public class ModifierUEServlet extends HttpServlet {
    private final UEDao ueDao = new UEDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codeStr = request.getParameter("code");

        if (codeStr != null && !codeStr.isEmpty()) {
            try {
                Long code = Long.valueOf(codeStr);
                UE ue = ueDao.findById(code);

                if (ue != null) {
                    ue.setNom(request.getParameter("nom"));
                    ue.setVolumeHoraire(Integer.parseInt(request.getParameter("volumeHoraire")));
                    ue.setCoefficient(Float.parseFloat(request.getParameter("coefficient")));
                    ue.setCredits(Integer.parseInt(request.getParameter("credits")));
                    ue.setEnseignant(request.getParameter("enseignant"));
                    ue.setObligatoire(Boolean.parseBoolean(request.getParameter("obligatoire")));

                    ueDao.update(ue);
                } else {
                    request.setAttribute("error", "UE introuvable.");
                    request.getRequestDispatcher("modifier-ue.jsp").forward(request, response);
                    return;
                }

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Code UE invalide.");
                request.getRequestDispatcher("modifier-ue.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Code UE manquant.");
            request.getRequestDispatcher("modifier-ue.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("lister-ues");
    }
}
