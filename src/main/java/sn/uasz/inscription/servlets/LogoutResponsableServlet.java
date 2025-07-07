package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LogoutResponsableServlet")
public class LogoutResponsableServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Log de déconnexion
            String userEmail = (String) session.getAttribute("userEmail");
            String userType = (String) session.getAttribute("userType");
            
            if (userEmail != null) {
                logLogout(userEmail, userType);
            }
            
            // Invalidation de la session
            session.invalidate();
        }
        
        // Redirection vers la page d'accueil avec message de confirmation
        response.sendRedirect("index.jsp?message=logout_success");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    /**
     * Log des déconnexions
     */
    private void logLogout(String email, String userType) {
        String timestamp = java.time.LocalDateTime.now().toString();
        String logMessage = String.format("[%s] Déconnexion - Email: %s - Type: %s", 
            timestamp, email, userType != null ? userType.toUpperCase() : "UNKNOWN");
        
        System.out.println(logMessage);
        
        // En production, sauvegarder dans un fichier de log ou base de données
    }
}