<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ajouter une UE</title>
</head>
<body>
<h2>Ajouter une UE</h2>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty formations}">
    <c:redirect url="AjouterUEServlet"/>
</c:if>


<form action="AjouterUEServlet" method="post">
    <label for="code">Code :</label>
    <input type="text" name="code" id="code" required><br><br>

    <label for="nom">Nom :</label>
    <input type="text" name="nom" id="nom" required><br><br>

    <label for="volumeHoraire">Volume horaire :</label>
    <input type="number" name="volumeHoraire" id="volumeHoraire" required><br><br>

    <label for="coefficient">Coefficient :</label>
    <input type="number" step="0.1" name="coefficient" id="coefficient" required><br><br>

    <label for="credits">Crédits :</label>
    <input type="number" name="credits" id="credits" required><br><br>

    <label for="enseignant">Enseignant :</label>
    <input type="text" name="enseignant" id="enseignant" required><br><br>

    <label for="obligatoire">Type :</label>
    <select name="obligatoire" id="obligatoire">
        <option value="true">Obligatoire</option>
        <option value="false">Optionnelle</option>
    </select><br><br>

    <label for="formationId">Formation :</label>
    <select name="formationId" id="formationId" required>
        <c:forEach var="f" items="${formations}">
            <option value="${f.id}">${f.intitule}</option>
        </c:forEach>
    </select><br><br>

    <input type="submit" value="Créer">
</form>

<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>


</body>
</html>
