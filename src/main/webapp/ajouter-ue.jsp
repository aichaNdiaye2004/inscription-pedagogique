<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une UE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Ajouter une UE</h2>

    <c:if test="${empty formations}">
        <c:redirect url="AjouterUEServlet"/>
    </c:if>

    <div class="card shadow-sm">
        <div class="card-body">
            <form action="AjouterUEServlet" method="post" class="row g-3">

                <div class="col-md-6">
                    <label for="code" class="form-label">Code</label>
                    <input type="text" name="code" id="code" class="form-control" required>
                </div>

                <div class="col-md-6">
                    <label for="nom" class="form-label">Nom</label>
                    <input type="text" name="nom" id="nom" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label for="volumeHoraire" class="form-label">Volume horaire</label>
                    <input type="number" name="volumeHoraire" id="volumeHoraire" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label for="coefficient" class="form-label">Coefficient</label>
                    <input type="number" step="0.1" name="coefficient" id="coefficient" class="form-control" required>
                </div>

                <div class="col-md-4">
                    <label for="credits" class="form-label">Crédits</label>
                    <input type="number" name="credits" id="credits" class="form-control" required>
                </div>

                <div class="col-md-6">
                    <label for="enseignant" class="form-label">Enseignant</label>
                    <input type="text" name="enseignant" id="enseignant" class="form-control" required>
                </div>

                <div class="col-md-6">
                    <label for="obligatoire" class="form-label">Type</label>
                    <select name="obligatoire" id="obligatoire" class="form-select" required>
                        <option value="true">Obligatoire</option>
                        <option value="false">Optionnelle</option>
                    </select>
                </div>

                <div class="col-md-12">
                    <label for="formationId" class="form-label">Formation</label>
                    <select name="formationId" id="formationId" class="form-select" required>
                        <c:forEach var="f" items="${formations}">
                            <option value="${f.id}">${f.intitule}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12 mt-4">
                    <button type="submit" class="btn btn-primary">Créer</button>
                </div>

                <c:if test="${not empty message}">
                    <div class="col-12 mt-3">
                        <div class="alert alert-success">${message}</div>
                    </div>
                </c:if>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
