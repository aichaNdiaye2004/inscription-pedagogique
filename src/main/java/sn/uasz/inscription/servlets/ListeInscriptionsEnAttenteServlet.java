package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListeInscriptionsEnAttenteServlet", urlPatterns = {"/listeInscriptionsEnAttente"})

public class ListeInscriptionsEnAttenteServlet extends HttpServlet {

    private EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== Servlet ListeInscriptionsEnAttenteServlet appelée ===");
        

        try {
            List<Etudiant> inscriptionsEnAttente = etudiantDao.findByInscriptionNonValideeOuNull();
            System.out.println("Nombre d'étudiants trouvés : " + inscriptionsEnAttente.size());
       

            request.setAttribute("etudiants", inscriptionsEnAttente);
            request.getRequestDispatcher("/listeInscriptionsEnAttente.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des inscriptions en attente.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    

}
