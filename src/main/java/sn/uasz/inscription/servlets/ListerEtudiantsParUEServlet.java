package sn.uasz.inscription.servlets;

import jakarta.persistence.EntityManager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.Etudiant;
import sn.uasz.inscription.entities.UE;
import sn.uasz.inscription.util.JpaUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/ListerEtudiantsParUE")
public class ListerEtudiantsParUEServlet extends HttpServlet {

    private EtudiantDao etudiantDao; 
    private UEDao ueDao;
    
    @Override
    public void init() throws ServletException {
        etudiantDao = new EtudiantDao();
        ueDao = new UEDao();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ueCodeStr = request.getParameter("ueId");
        List<Etudiant> etudiants = null;
        Long ueCode = null;
        UE ue = null;

        try {
            ueCode = Long.parseLong(ueCodeStr);
            ue = ueDao.findById(ueCode);               // Récupère l'objet UE complet
            etudiants = etudiantDao.findByUECode(ueCode);
        } catch (NumberFormatException e) {
            etudiants = List.of();
            request.setAttribute("errorMessage", "Code UE invalide : " + ueCodeStr);
        }

        request.setAttribute("etudiants", etudiants);
        request.setAttribute("ue", ue);                 // Passe l'objet UE complet
        request.setAttribute("ueCode", ueCodeStr);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/liste-etudiants-par-ue.jsp");
        dispatcher.forward(request, response);
    }
}
