package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) email = email.trim().toLowerCase();
        if (password != null) password = password.trim();

        System.out.println("Tentative connexion avec email='" + email + "' et mot de passe='" + password + "'");

        // Recherche l'étudiant par email en ignorant la casse
        Etudiant etudiant = etudiantDao.findByEmail(email);

        if (etudiant == null) {
            System.out.println("Aucun étudiant trouvé avec l'email : " + email);
        } else {
            System.out.println("Étudiant trouvé : " + etudiant.getNom() + ", mot de passe en base : '" + etudiant.getMotDePasse() + "'");
            if (password.equals(etudiant.getMotDePasse() != null ? etudiant.getMotDePasse().trim() : "")) {
                System.out.println("Mot de passe correct");
                // Connexion OK : créer session et rediriger vers page protégée
                HttpSession session = request.getSession();
                session.setAttribute("etudiant", etudiant); // au lieu de "user"

                
                response.sendRedirect("accueilEtudiant.jsp");
                return;
            } else {
                System.out.println("Mot de passe incorrect");
            }
        }
        // Sinon, on revient à la page de connexion avec message d'erreur
        request.setAttribute("error", "Identifiant ou mot de passe incorrect.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
