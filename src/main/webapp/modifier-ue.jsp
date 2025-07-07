<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier une UE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Modifier une UE</h2>

    <div class="card shadow-sm">
        <div class="card-body">
            <form action="ModifierUEServlet" method="post" class="row g-3">
                <input type="hidden" name="code" value="${ue.code}"/>

                <div class="col-md-6">
                    <label for="nom" class="form-label">Nom</label>
                    <input type="text" name="nom" id="nom" class="form-control" value="${ue.nom}" required>
                </div>

                <div class="col-md-6">
                    <label for="volumeHoraire" class="form-label">Volume horaire</label>
                    <input type="number" name="volumeHoraire" id="volumeHoraire" class="form-control" value="${ue.volumeHoraire}" required>
                </div>

                <div class="col-md-4">
                    <label for="coefficient" class="form-label">Coefficient</label>
                    <input type="number" step="0.1" name="coefficient" id="coefficient" class="form-control" value="${ue.coefficient}" required>
                </div>

                <div class="col-md-4">
                    <label for="credits" class="form-label">Crédits</label>
                    <input type="number" name="credits" id="credits" class="form-control" value="${ue.credits}" required>
                </div>

                <div class="col-md-4">
                    <label for="enseignant" class="form-label">Enseignant</label>
                    <input type="text" name="enseignant" id="enseignant" class="form-control" value="${ue.enseignant}" required>
                </div>

                <div class="col-md-6">
                    <label for="obligatoire" class="form-label">Type</label>
                    <select name="obligatoire" id="obligatoire" class="form-select" required>
                        <option value="true" ${ue.obligatoire ? 'selected' : ''}>Obligatoire</option>
                        <option value="false" ${!ue.obligatoire ? 'selected' : ''}>Optionnelle</option>
                    </select>
                </div>

                <div class="col-12 mt-4">
                    <button type="submit" class="btn btn-success">Enregistrer</button>
                    <a href="lister-ues" class="btn btn-secondary ms-2">Retour à la liste</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
