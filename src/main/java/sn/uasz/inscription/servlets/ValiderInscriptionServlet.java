package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.entities.Etudiant;
import sn.uasz.inscription.util.MailUtil;

import jakarta.mail.MessagingException;
import java.io.IOException;

@WebServlet("/valider-inscription")
public class ValiderInscriptionServlet extends HttpServlet {

    private EtudiantDao etudiantDao = new EtudiantDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ine = request.getParameter("ine");

        if (ine != null && !ine.trim().isEmpty()) {
            Etudiant etudiant = etudiantDao.findByIne(ine);
            if (etudiant != null) {
                etudiant.setInscriptionValidee(true);
                etudiantDao.update(etudiant);

                try {
                    String sujet = "Validation de votre inscription pédagogique";
                    String messageTexte = "Bonjour " + etudiant.getPrenom() + ",\n\n"
                            + "Votre inscription pédagogique a été validée avec succès.\n\n"
                            + "Cordialement,\nL'équipe pédagogique";

                    MailUtil.envoyerMail(etudiant.getEmail(), sujet, messageTexte);

                    request.getSession().setAttribute("message", "Inscription validée et mail envoyé à l’étudiant " + etudiant.getNom());
                } catch (MessagingException e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("message", "Inscription validée, mais échec de l'envoi du mail : " + e.getMessage());
                }
            } else {
                request.getSession().setAttribute("message", "Étudiant introuvable.");
            }
        } else {
            request.getSession().setAttribute("message", "INE non fourni.");
        }

        response.sendRedirect("liste-etudiants");
    }
}