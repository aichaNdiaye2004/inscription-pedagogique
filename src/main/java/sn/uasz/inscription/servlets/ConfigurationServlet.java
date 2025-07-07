package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.ConfigurationDao;
import sn.uasz.inscription.entities.Configuration;

import java.io.IOException;

@WebServlet(name = "ConfigurationServlet", urlPatterns = {"/configurations"})

public class ConfigurationServlet extends HttpServlet {

    private ConfigurationDao configDao = new ConfigurationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Configuration config = configDao.find();
        if (config == null) {
            config = new Configuration();
        }
        request.setAttribute("configuration", config);
        request.getRequestDispatcher("/configuration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int tailleTD = Integer.parseInt(request.getParameter("tailleMaxGroupeTD"));
        int tailleTP = Integer.parseInt(request.getParameter("tailleMaxGroupeTP"));

        Configuration config = configDao.find();
        if (config == null) {
            config = new Configuration();
            config.setCle("default");  // <-- Ici on fixe la clé primaire obligatoire
        }
        config.setTailleMaxGroupeTD(tailleTD);
        config.setTailleMaxGroupeTP(tailleTP);

        configDao.save(config);

        request.getSession().setAttribute("message", "Configuration mise à jour avec succès.");
        response.sendRedirect("configurations");
    }

}
