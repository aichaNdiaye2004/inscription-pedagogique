<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head><title>Ajouter / Modifier une formation</title></head>
<body>
<h2>${formation != null ? 'Modifier' : 'Ajouter'} une formation</h2>

<form action="AjouterFormationServlet" method="post">
    <c:if test="${formation != null}">
        <!-- Si on modifie, on envoie l'id -->
        <input type="hidden" name="id" value="${formation.id}" />
    </c:if>

    <label for="intitule">Intitulé :</label>
    <input type="text" id="intitule" name="intitule" required
           value="${formation != null ? formation.intitule : ''}" /><br><br>

    <label for="niveau">Niveau :</label>
    <input type="text" id="niveau" name="niveau" required
           value="${formation != null ? formation.niveau : ''}" /><br><br>

    <label for="emailResponsable">Email Responsable :</label>
    <input type="email" id="emailResponsable" name="emailResponsable" required
           value="${formation != null ? formation.emailResponsable : ''}" /><br><br>

    <input type="submit" value="${formation != null ? 'Modifier' : 'Ajouter'}" />
</form>

<a href="formations">Retour à la liste des formations</a>


<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>

</body>
</html>
