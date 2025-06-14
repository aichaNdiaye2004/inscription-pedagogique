package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;
import java.util.List;

@WebServlet("/liste-etudiants")
public class ListeEtudiantsServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupération de la liste des étudiants
        List<Etudiant> etudiants = etudiantDao.findAll();

        // Mise dans l'objet request
        request.setAttribute("etudiants", etudiants);

       
        request.getRequestDispatcher("/etudiants.jsp").forward(request, response);
        
        
    }
}
