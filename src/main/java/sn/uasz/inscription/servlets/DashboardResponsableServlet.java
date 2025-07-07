package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "DashboardResponsableServlet", urlPatterns = {"/DashboardResponsableServlet"})
public class DashboardResponsableServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Vérification de l'authentification
        HttpSession session = request.getSession(false);
        
        if (session == null || 
            session.getAttribute("userType") == null || 
            !"responsable".equals(session.getAttribute("userType"))) {
            
            // Utilisateur non authentifié ou pas responsable
            response.sendRedirect("index.jsp?error=access_denied");
            return;
        }
        
        // Récupération des informations utilisateur
        String userEmail = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("userName");
        
        // Ajout d'attributs pour la JSP si nécessaire
        request.setAttribute("userEmail", userEmail);
        request.setAttribute("userName", userName);
        
        // Ici vous pouvez ajouter la logique pour récupérer les données du dashboard
        // Par exemple : statistiques, formations, étudiants, etc.
        loadDashboardData(request);
        
        // Redirection vers la page JSP
        request.getRequestDispatcher("dashboardResponsable.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirection vers doGet pour toutes les requêtes POST
        doGet(request, response);
    }
    
    /**
     * Charge les données nécessaires pour le dashboard
     */
    private void loadDashboardData(HttpServletRequest request) {
        try {
            // Ici vous pouvez ajouter la logique pour récupérer les données depuis la base
            
            // Exemple de statistiques (à remplacer par vos vraies données)
            request.setAttribute("nombreEtudiants", 524);
            request.setAttribute("nombreFormations", 28);
            request.setAttribute("nombreUEs", 156);
            request.setAttribute("tauxInscription", 95);
            
            // Activité récente (exemple)
            // List<Activite> activitesRecentes = activiteDAO.getActivitesRecentes(10);
            // request.setAttribute("activitesRecentes", activitesRecentes);
            
            // Formations actives
            // List<Formation> formations = formationDAO.getFormationsActives();
            // request.setAttribute("formations", formations);
            
        } catch (Exception e) {
            // Log de l'erreur
            System.err.println("Erreur lors du chargement des données du dashboard: " + e.getMessage());
            e.printStackTrace();
            
            // Valeurs par défaut en cas d'erreur
            request.setAttribute("nombreEtudiants", 0);
            request.setAttribute("nombreFormations", 0);
            request.setAttribute("nombreUEs", 0);
            request.setAttribute("tauxInscription", 0);
            request.setAttribute("errorMessage", "Erreur lors du chargement des données");
        }
    }
}