<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Modifier Étudiant</title></head>
<body>
    <h2>Modifier un Étudiant</h2>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form action="modifier-etudiant" method="post">
        INE: <input type="text" name="ine" value="${etudiant.ine}" readonly/><br/>
        Prénom: <input type="text" name="prenom" value="${etudiant.prenom}"/><br/>
        Nom: <input type="text" name="nom" value="${etudiant.nom}"/><br/>
        Email: <input type="email" name="email" value="${etudiant.email}"/><br/>
        <input type="submit" value="Enregistrer"/>
    </form>
</body>
</html>
