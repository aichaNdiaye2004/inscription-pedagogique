<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Modifier un étudiant</title>
</head>
<body>
    <h1>Modifier un étudiant</h1>

    <form method="post" action="modifier-etudiant">
        <input type="hidden" name="ine" value="${etudiant.ine}" />

        Prénom : <input type="text" name="prenom" value="${etudiant.prenom}" required /><br/>
        Nom : <input type="text" name="nom" value="${etudiant.nom}" required /><br/>
        Date de naissance : <input type="date" name="dateNaissance" value="${etudiant.dateNaissance}" required /><br/>
        Sexe :
        <select name="sexe">
            <option value="M" ${etudiant.sexe == 'M' ? 'selected' : ''}>Masculin</option>
            <option value="F" ${etudiant.sexe == 'F' ? 'selected' : ''}>Féminin</option>
        </select><br/>
        Adresse : <input type="text" name="adresse" value="${etudiant.adresse}" /><br/>
        Email : <input type="email" name="email" value="${etudiant.email}" required /><br/>

        Formation :
        <select name="formationId" required>
            <c:forEach var="f" items="${formations}">
                <option value="${f.id}" ${f.id == etudiant.formation.id ? 'selected' : ''}>
                    ${f.intitule}
                </option>
            </c:forEach>
        </select><br/>

        <input type="submit" value="Enregistrer les modifications" />
    </form>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>
