<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des UEs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 40px;
        }

        h2 {
            color: #333;
        }

        form {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        label {
            margin-right: 10px;
        }

        select, input[type="submit"] {
            padding: 8px;
            margin-right: 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px #ccc;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #2980b9;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        a {
            text-decoration: none;
            margin: 0 5px;
        }

        a:hover {
            text-decoration: underline;
        }

        .btn {
            padding: 5px 10px;
            border-radius: 5px;
            color: white;
            font-size: 0.9em;
        }

        .edit-btn {
            background-color: #f39c12;
        }

        .delete-btn {
            background-color: #c0392b;
        }

        .list-btn {
            background-color: #27ae60;
        }
    </style>
</head>
<body>

<h2>Liste des UEs par formation et type</h2>

<form method="get" action="${pageContext.request.contextPath}/ListerUEsServlet">
    <label for="formationId">Formation :</label>
    <select name="formationId" id="formationId" required>
        <c:forEach var="f" items="${formations}">
            <option value="${f.id}" <c:if test="${f.id == selectedFormationId}">selected</c:if>>
                ${f.intitule}
            </option>
        </c:forEach>
    </select>

    <label for="type">Type :</label>
    <select name="type" id="type">
        <option value="obligatoire" <c:if test="${selectedType == 'obligatoire'}">selected</c:if>>Obligatoire</option>
        <option value="optionnelle" <c:if test="${selectedType == 'optionnelle'}">selected</c:if>>Optionnelle</option>
    </select>

    <input type="submit" value="Filtrer">
</form>

<c:if test="${not empty ues}">
    <table>
        <tr>
            <th>Code</th>
            <th>Nom</th>
            <th>Volume Horaire</th>
            <th>Coefficient</th>
            <th>Crédits</th>
            <th>Enseignant</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="ue" items="${ues}">
            <tr>
                <td>${ue.code}</td>
                <td>${ue.nom}</td>
                <td>${ue.volumeHoraire}</td>
                <td>${ue.coefficient}</td>
                <td>${ue.credits}</td>
                <td>${ue.enseignant}</td>
                <td>
                    <a href="modifier-ue.jsp?code=${ue.code}" class="btn edit-btn">✏️ Modifier</a>
                    <a href="SupprimerUEServlet?code=${ue.code}" class="btn delete-btn"
                       onclick="return confirm('Confirmer la suppression ?');">🗑️ Supprimer</a>
                    <a href="ListerEtudiantsParUE?ueId=${ue.code}" class="btn list-btn">📋 Étudiants</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<c:if test="${empty ues}">
    <p>Aucune UE trouvée pour ces critères.</p>
</c:if>

</body>
</html>
