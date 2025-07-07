package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.ConfigurationDao;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Configuration;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "RepartitionGroupesServlet", urlPatterns = {"/repartir-groupes"})
public class RepartitionGroupesServlet extends HttpServlet {

    private EtudiantDao etudiantDao = new EtudiantDao();
    private ConfigurationDao configurationDao = new ConfigurationDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Configuration config = configurationDao.find();

        if (config == null) {
            request.getSession().setAttribute("message", "La configuration n'est pas définie.");
            response.sendRedirect("configurations");
            return;
        }

        int tailleMaxTD = config.getTailleMaxGroupeTD();
        int tailleMaxTP = config.getTailleMaxGroupeTP();

        // Récupérer les étudiants avec inscription validée
        List<Etudiant> etudiants = etudiantDao.findByInscriptionValidee(true);

        int groupeTD = 1;
        int groupeTP = 1;
        int countTD = 0;
        int countTP = 0;

        for (Etudiant etudiant : etudiants) {
            // Répartition groupe TD
            if (countTD >= tailleMaxTD) {
                groupeTD++;
                countTD = 0;
            }
            etudiant.setGroupeTD(groupeTD);
            countTD++;

            // Répartition groupe TP
            if (countTP >= tailleMaxTP) {
                groupeTP++;
                countTP = 0;
            }
            etudiant.setGroupeTP(groupeTP);
            countTP++;

            // Sauvegarder l'étudiant mis à jour
            etudiantDao.update(etudiant);
        }

        request.getSession().setAttribute("message", "Répartition des groupes TD et TP effectuée avec succès.");
        response.sendRedirect("liste-etudiants");
    }
}
