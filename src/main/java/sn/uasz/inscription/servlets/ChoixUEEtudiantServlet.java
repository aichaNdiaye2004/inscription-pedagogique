package sn.uasz.inscription.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sn.uasz.inscription.dao.EtudiantDao;
import sn.uasz.inscription.dao.UEDao;
import sn.uasz.inscription.entities.Etudiant;
import sn.uasz.inscription.entities.UE;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/ChoixUEEtudiantServlet")
public class ChoixUEEtudiantServlet extends HttpServlet {

    private static final int MAX_UES = 3;
    private final EtudiantDao etudiantDao = new EtudiantDao();
    private final UEDao ueDao = new UEDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String ine = (String) session.getAttribute("ine");
        if (ine == null) {
            ine = request.getParameter("etudiantIne");
            if (ine == null || ine.isEmpty()) {
                response.sendRedirect("login.jsp");
                return;
            }
        }

        Etudiant etudiant = etudiantDao.findByIne(ine);
        if (etudiant == null) {
            request.setAttribute("message", "Étudiant introuvable.");
            forwardWithAttributes(request, response, null, new ArrayList<>(), null);
            return;
        }

        List<UE> uesOptionnelles = ueDao.findOptionnellesByFormation(etudiant.getFormation().getId());

        if (etudiant.isInscriptionValidee()) {
            request.setAttribute("message", "Modification impossible : inscription déjà validée.");
            String[] selectedCodes = getCodesFromUEs(etudiant.getUesOptionnelles()).toArray(new String[0]);
            forwardWithAttributes(request, response, etudiant, uesOptionnelles, selectedCodes);
            return;
        }

        String[] ueCodes = request.getParameterValues("ueCodes");
        if (ueCodes == null) {
            ueCodes = new String[0];
        }

        if (ueCodes.length > MAX_UES) {
            request.setAttribute("message", "Vous ne pouvez choisir que " + MAX_UES + " UEs optionnelles.");
            String[] selectedCodes = getCodesFromUEs(etudiant.getUesOptionnelles()).toArray(new String[0]);
            forwardWithAttributes(request, response, etudiant, uesOptionnelles, selectedCodes);
            return;
        }

        Set<UE> uesChoisies = new HashSet<>();
        for (String codeStr : ueCodes) {
            try {
                Long code = Long.valueOf(codeStr);
                UE ue = ueDao.findById(code);
                if (ue != null && !ue.isObligatoire()) {
                    uesChoisies.add(ue);
                }
            } catch (NumberFormatException ignored) {
            }
        }

        etudiant.setUesOptionnelles(new ArrayList<>(uesChoisies));
        etudiantDao.update(etudiant);

        request.setAttribute("message", "Vos choix ont été enregistrés avec succès.");
        forwardWithAttributes(request, response, etudiant, uesOptionnelles, ueCodes);
    }

    private void forwardWithAttributes(HttpServletRequest request, HttpServletResponse response, Etudiant etudiant, List<UE> uesOptionnelles, String[] ueSelectedCodes) throws ServletException, IOException {
        request.setAttribute("message", request.getAttribute("message"));  // conserve le message en place
        request.setAttribute("etudiant", etudiant);
        request.setAttribute("uesOptionnelles", uesOptionnelles);
        request.setAttribute("ueSelectedCodes", ueSelectedCodes == null ? null : List.of(ueSelectedCodes));
        request.getRequestDispatcher("choix-ues.jsp").forward(request, response);
    }

    private Set<String> getCodesFromUEs(List<UE> ues) {
        if (ues == null) return Set.of();
        return ues.stream()
                  .map(ue -> String.valueOf(ue.getCode()))
                  .collect(Collectors.toSet());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("ine") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String ine = (String) session.getAttribute("ine");
        Etudiant etudiant = etudiantDao.findByIne(ine);
        if (etudiant == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<UE> uesOptionnelles = ueDao.findOptionnellesByFormation(etudiant.getFormation().getId());
        request.setAttribute("etudiant", etudiant);
        request.setAttribute("uesOptionnelles", uesOptionnelles);
        request.setAttribute("ueSelectedCodes", getCodesFromUEs(etudiant.getUesOptionnelles()));

        request.getRequestDispatcher("choix-ues.jsp").forward(request, response);
    }
}
