package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ListeEtudiantsServlet", urlPatterns = {"/liste-etudiants"})


public class ListeEtudiantsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ListeEtudiantsServlet.class.getName());
    private static final String JSP_LISTE = "/listeEtudiants.jsp";

    private final EtudiantDao etudiantDao;

    public ListeEtudiantsServlet() {
        this.etudiantDao = new EtudiantDao();
    }

    // Constructeur pour injection de DAO (utile pour tests unitaires)
    public ListeEtudiantsServlet(EtudiantDao etudiantDao) {
        this.etudiantDao = etudiantDao;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Utiliser une méthode DAO qui fait un fetch join pour éviter lazy loading
        	List<Etudiant> etudiants = etudiantDao.findAllWithFormation();


            request.setAttribute("etudiants", etudiants);
            request.getRequestDispatcher(JSP_LISTE).forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Erreur lors du chargement de la liste des étudiants", e);
            // En cas d’erreur, afficher message simple (à personnaliser)
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Impossible de charger la liste des étudiants.");
        }
    }
}
