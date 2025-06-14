<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Étudiant</title>
    <style>.error { color: red; }</style>
</head>
<body>
    <h1>Ajouter un Étudiant</h1>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form method="post" action="ajouter-etudiant">
        <div>
            <label>INE* (15 caractères max):</label>
            <input type="text" name="ine" required maxlength="15" 
                   value="${param.ine}">
        </div>
        
        <div>
            <label>Prénom*:</label>
            <input type="text" name="prenom" required
                   value="${param.prenom}">
        </div>
        
        <div>
            <label>Nom*:</label>
            <input type="text" name="nom" required
                   value="${param.nom}">
        </div>
        
        <div>
            <label>Email*:</label>
            <input type="email" name="email" required
                   value="${param.email}">
        </div>
        <button type="submit">Enregistrer</button>
    </form>
</body>
</html>