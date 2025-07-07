package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import sn.uasz.inscription.dao.UEDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/supprimer-ue")
public class SupprimerUEServlet extends HttpServlet {
    private final UEDao ueDao = new UEDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codeStr = request.getParameter("code");

        if (codeStr != null && !codeStr.isEmpty()) {
            try {
                Long code = Long.valueOf(codeStr);
                ueDao.delete(code);
            } catch (NumberFormatException e) {
                // Ici tu peux gérer le cas où le code n'est pas un nombre valide
                request.setAttribute("error", "Code UE invalide");
                request.getRequestDispatcher("liste-ues.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Code UE manquant");
            request.getRequestDispatcher("liste-ues.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("lister-ues");
    }
}
