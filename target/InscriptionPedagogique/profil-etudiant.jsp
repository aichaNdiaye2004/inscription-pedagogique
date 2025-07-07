<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Profil Étudiant</title></head>
<body>

<h1>Profil de ${etudiant.prenom} ${etudiant.nom}</h1>

<p><strong>INE :</strong> ${etudiant.ine}</p>
<p><strong>Email :</strong> ${etudiant.email}</p>
<p><strong>Date de naissance :</strong> ${etudiant.dateNaissance}</p>
<p><strong>Formation :</strong> ${etudiant.formation.nom}</p>
<p><strong>Groupes :</strong> TD ${etudiant.groupeTD}, TP ${etudiant.groupeTP}</p>

<c:if test="${etudiant.inscriptionValidee}">
    <h2>UEs optionnelles choisies :</h2>
    <ul>
        <c:forEach var="ue" items="${etudiant.uesOptionnelles}">
            <li>${ue.nom} (Volume: ${ue.volumeHoraire}h, Crédits: ${ue.credits})</li>
        </c:forEach>
    </ul>
</c:if>

<c:if test="${!etudiant.inscriptionValidee}">
    <p><em>Votre inscription n'est pas encore validée. Les UEs optionnelles et groupes ne sont pas disponibles.</em></p>
</c:if>

</body>
</html>
