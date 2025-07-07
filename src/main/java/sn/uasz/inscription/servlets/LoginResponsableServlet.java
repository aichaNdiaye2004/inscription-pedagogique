package sn.uasz.inscription.servlets;


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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/LoginResponsableServlet")
public class LoginResponsableServlet extends HttpServlet {
    
    // Comptes responsables prédéfinis (en production, utiliser une base de données sécurisée)
    private static final Map<String, String> RESPONSABLES_ADMIN = new HashMap<>();
    
    static {
        // Initialisation des deux comptes administrateur
        RESPONSABLES_ADMIN.put("m.n172@zig.univ.sn", "Admin123");
        RESPONSABLES_ADMIN.put("a.n182@zig.univ.sn", "Admin000");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        // Validation des paramètres
        if (email == null || password == null || userType == null || 
            email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        HttpSession session = request.getSession();
        
        try {
            if ("responsable".equals(userType)) {
                // Authentification responsable/admin
                if (authenticateResponsable(email, password)) {
                    // Connexion réussie
                    session.setAttribute("userEmail", email);
                    session.setAttribute("userType", "responsable");
                    session.setAttribute("userName", getResponsableName(email));
                    
                    // Log de connexion (optionnel)
                    logConnection(email, "RESPONSABLE", "SUCCESS");
                    
                    response.sendRedirect("DashboardResponsableServlet");
                } else {
                    // Échec de l'authentification
                    logConnection(email, "RESPONSABLE", "FAILED");
                    request.setAttribute("error", "Email ou mot de passe incorrect pour le compte responsable.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } 
            else if ("etudiant".equals(userType)) {
                // Authentification étudiant (à implémenter avec la base de données)
                if (authenticateEtudiant(email, password)) {
                    session.setAttribute("userEmail", email);
                    session.setAttribute("userType", "etudiant");
                    
                    logConnection(email, "ETUDIANT", "SUCCESS");
                    response.sendRedirect("etudiant-dashboard.jsp");
                } else {
                    logConnection(email, "ETUDIANT", "FAILED");
                    request.setAttribute("error", "Email ou mot de passe incorrect.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } 
            else {
                request.setAttribute("error", "Type d'utilisateur invalide.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Log de l'erreur
            System.err.println("Erreur lors de l'authentification: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "Une erreur technique est survenue. Veuillez réessayer.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
    
    /**
     * Authentifie un responsable avec les comptes prédéfinis
     */
    private boolean authenticateResponsable(String email, String password) {
        String storedPassword = RESPONSABLES_ADMIN.get(email.toLowerCase().trim());
        return storedPassword != null && storedPassword.equals(password);
    }
    
    /**
     * Retourne le nom du responsable basé sur l'email
     */
    private String getResponsableName(String email) {
        if ("admin1@edumanager.fr".equals(email.toLowerCase())) {
            return "Administrateur Principal";
        } else if ("admin2@edumanager.fr".equals(email.toLowerCase())) {
            return "Administrateur Adjoint";
        }
        return "Administrateur";
    }
    
    /**
     * Authentifie un étudiant (à connecter avec votre base de données)
     */
    private boolean authenticateEtudiant(String email, String password) {
        // TODO: Implémenter l'authentification étudiant avec la base de données
        // Exemple basique (à remplacer par votre logique)
        
        try {
            // Connexion à la base de données
            // Connection conn = DatabaseConnection.getConnection();
            // PreparedStatement stmt = conn.prepareStatement(
            //     "SELECT mot_de_passe FROM etudiants WHERE email = ? AND actif = true"
            // );
            // stmt.setString(1, email);
            // ResultSet rs = stmt.executeQuery();
            
            // if (rs.next()) {
            //     String hashedPassword = rs.getString("mot_de_passe");
            //     return BCrypt.checkpw(password, hashedPassword);
            // }
            
            // Pour le moment, retourner false
            return false;
            
        } catch (Exception e) {
            System.err.println("Erreur lors de l'authentification étudiant: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Log des tentatives de connexion
     */
    private void logConnection(String email, String userType, String status) {
        String timestamp = java.time.LocalDateTime.now().toString();
        String logMessage = String.format("[%s] Tentative de connexion %s - Email: %s - Type: %s - IP: %s", 
            timestamp, status, email, userType, "");
        
        // En production, utiliser un vrai système de logging (Log4j, SLF4J, etc.)
        System.out.println(logMessage);
        
        // Optionnel: Sauvegarder dans un fichier ou base de données
        // logToDatabase(email, userType, status, timestamp);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirection vers la page de connexion
        response.sendRedirect("index.jsp");
    }
}