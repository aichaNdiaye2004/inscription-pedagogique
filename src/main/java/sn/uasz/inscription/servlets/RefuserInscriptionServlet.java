package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;

import java.io.IOException;

@WebServlet(name = "RefuserInscriptionServlet", urlPatterns = {"/RefuserInscriptionServlet"})
public class RefuserInscriptionServlet extends HttpServlet {

    private EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ine = request.getParameter("ine");

        if (ine != null && !ine.isEmpty()) {
            etudiantDao.deleteByIne(ine);
        }

        response.sendRedirect("ListeInscriptionsEnAttenteServlet");
    }
    
   
  

}
