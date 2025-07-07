```jsp
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Responsable - EduManager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background: #4b2995;
            color: white;
            overflow-y: auto;
            z-index: 1000;
        }
        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .sidebar-brand {
            font-size: 24px;
            font-weight: 600;
            display: flex;
            align-items: center;
        }
        .sidebar-brand i {
            margin-right: 10px;
        }
        .sidebar-menu {
            padding: 20px 0;
        }
        .menu-item {
            display: block;
            padding: 12px 20px;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            background: none;
            width: 100%;
            text-align: left;
        }
        .menu-item:hover, .menu-item.active {
            background: rgba(255,255,255,0.1);
            color: white;
        }
        .menu-item i {
            margin-right: 10px;
            width: 20px;
        }
        .main-content {
            margin-left: 250px;
            min-height: 100vh;
        }
        .top-bar {
            background: white;
            padding: 15px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            background: #4b2995;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        .content-area {
            padding: 30px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-left: 4px solid #4b2995;
        }
        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #4b2995;
            margin-bottom: 5px;
        }
        .stat-label {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }
        .stat-change {
            font-size: 12px;
            color: #28a745;
        }
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .card-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            color: #333;
        }
        .card-body {
            padding: 20px;
        }
        .btn-primary {
            background: #4b2995;
            border-color: #4b2995;
        }
        .btn-primary:hover {
            background: #38216b;
            border-color: #38216b;
        }
        .welcome-message {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .welcome-message h2 {
            margin-bottom: 10px;
            font-weight: 600;
        }
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .quick-action-btn {
            padding: 15px;
            background: rgba(255,255,255,0.2);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            text-align: center;
            transition: all 0.3s ease;
        }
        .quick-action-btn:hover {
            background: rgba(255,255,255,0.3);
            color: white;
            transform: translateY(-2px);
        }
        .logout-btn {
            color: #dc3545;
            border: 1px solid #dc3545;
            background: transparent;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .logout-btn:hover {
            background: #dc3545;
            color: white;
        }
        .table {
            margin-bottom: 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <!-- Vérification d'authentification -->
    <%
        if (!"responsable".equals(session.getAttribute("userType"))) {
            request.setAttribute("error", "Accès refusé. Connexion responsable requise.");
            response.sendRedirect("index.jsp?error=access_denied");
            return;
        }
    %>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-brand">
                <i class="fas fa-graduation-cap"></i>
                EduManager
            </div>
        </div>
        <nav class="sidebar-menu">
            <a href="#" class="menu-item active" onclick="showSection('dashboard')">
                <i class="fas fa-tachometer-alt"></i>
                Dashboard
            </a>
            <a href="#" class="menu-item" onclick="showSection('formations')">
                <i class="fas fa-book"></i>
                Formations
            </a>
            <a href="#" class="menu-item" onclick="showSection('etudiants')">
                <i class="fas fa-users"></i>
                Étudiants
            </a>
            <a href="#" class="menu-item" onclick="showSection('ues')">
                <i class="fas fa-list"></i>
                Unités d'Enseignement
            </a>
            <a href="#" class="menu-item" onclick="showSection('groupes')">
                <i class="fas fa-layer-group"></i>
                Groupes
            </a>
            <a href="#" class="menu-item" onclick="showSection('rapports')">
                <i class="fas fa-chart-bar"></i>
                Rapports
            </a>
            <a href="#" class="menu-item" onclick="showSection('parametres')">
                <i class="fas fa-cog"></i>
                Paramètres
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <h1>Dashboard Responsable</h1>
            <div class="user-info">
                <span>Bienvenue, ${sessionScope.userName}</span>
                <div class="user-avatar">
                    ${sessionScope.userName.substring(0,1).toUpperCase()}
                </div>
                <a href="${pageContext.request.contextPath}/LogoutResponsableServlet" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Déconnexion
                </a>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Section Dashboard -->
            <div id="dashboard-section" class="content-section">
                <div class="welcome-message">
                    <h2>Bienvenue dans votre espace administrateur</h2>
                    <p>Gérez efficacement les inscriptions pédagogiques et suivez les statistiques en temps réel.</p>
                    <div class="quick-actions">
                        <a href="#" class="quick-action-btn" onclick="showSection('formations')">
                            <i class="fas fa-plus"></i><br>
                            Nouvelle Formation
                        </a>
                        <a href="#" class="quick-action-btn" onclick="showSection('etudiants')">
                            <i class="fas fa-user-plus"></i><br>
                            Gérer Étudiants
                        </a>
                        <a href="#" class="quick-action-btn" onclick="showSection('rapports')">
                            <i class="fas fa-download"></i><br>
                            Exporter Données
                        </a>
                        <a href="#" class="quick-action-btn" onclick="showSection('groupes')">
                            <i class="fas fa-random"></i><br>
                            Répartir Groupes
                        </a>
                    </div>
                </div>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-number">${nombreEtudiants}</div>
                        <div class="stat-label">Étudiants inscrits</div>
                        <div class="stat-change">+12% ce mois</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${nombreFormations}</div>
                        <div class="stat-label">Formations actives</div>
                        <div class="stat-change">+2 nouvelles</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${nombreUEs}</div>
                        <div class="stat-label">UEs disponibles</div>
                        <div class="stat-change">+8 ce semestre</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${tauxInscription}%</div>
                        <div class="stat-label">Taux d'inscription</div>
                        <div class="stat-change">Excellent</div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-clock"></i>
                        Activité récente
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <strong>Nouvelle inscription</strong><br>
                                    <small class="text-muted">Jean Dupont s'est inscrit en Master Informatique</small>
                                </div>
                                <small class="text-muted">Il y a 2h</small>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <strong>Formation créée</strong><br>
                                    <small class="text-muted">Licence Pro IA ajoutée au système</small>
                                </div>
                                <small class="text-muted">Il y a 5h</small>
                            </div>
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <strong>Groupe complet</strong><br>
                                    <small class="text-muted">TD Algorithmique - Groupe A est complet</small>
                                </div>
                                <small class="text-muted">Hier</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section Formations -->
            <div id="formations-section" class="content-section" style="display: none;">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-book"></i>
                        Gestion des Formations
 dubb
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger text-center" role="alert">
                                ${error}
                            </div>
                        </c:if>
                        <c:if test="${not empty message}">
                            <div class="alert alert-success text-center" role="alert">
                                ${message}
                            </div>
                        </c:if>
                        <!-- Formulaire pour ajouter/modifier une formation -->
                        <form action="${pageContext.request.contextPath}/formations" method="post" class="mb-4">
                            <input type="hidden" name="id" value="${formation != null ? formation.id : ''}">
                            <div class="form-group">
                                <label for="intitule">Intitulé</label>
                                <input type="text" class="form-control" id="intitule" name="intitule" value="${formation != null ? formation.intitule : ''}" required>
                            </div>
                            <div class="form-group">
                                <label for="niveau">Niveau</label>
                                <input type="text" class="form-control" id="niveau" name="niveau" value="${formation != null ? formation.niveau : ''}" required>
                            </div>
                            <div class="form-group">
                                <label for="nomResponsable">Nom du Responsable</label>
                                <input type="text" class="form-control" id="nomResponsable" name="nomResponsable" value="${formation != null ? formation.nomResponsable : ''}">
                            </div>
                            <div class="form-group">
                                <label for="emailResponsable">Email du Responsable</label>
                                <input type="email" class="form-control" id="emailResponsable" name="emailResponsable" value="${formation != null ? formation.emailResponsable : ''}">
                            </div>
                            <div class="form-group">
                                <label for="ueId">Unités d'Enseignement</label>
                                <select multiple class="form-control" id="ueId" name="ueId">
                                    <c:forEach var="ue" items="${ues}">
                                        <option value="${ue.id}" ${formation != null && formation.ues.contains(ue) ? 'selected' : ''}>${ue.nom}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                ${formation != null ? 'Modifier' : 'Ajouter'} Formation
                            </button>
                        </form>
                        <!-- Liste des formations -->
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Intitulé</th>
                                    <th>Niveau</th>
                                    <th>Responsable</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="formation" items="${formations}">
                                    <tr>
                                        <td>${formation.id}</td>
                                        <td>${formation.intitule}</td>
                                        <td>${formation.niveau}</td>
                                        <td>${formation.nomResponsable} (${formation.emailResponsable})</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/formations?action=edit&id=${formation.id}" class="btn btn-sm btn-primary">Modifier</a>
                                            <a href="${pageContext.request.contextPath}/formations?action=delete&id=${formation.id}" class="btn btn-sm btn-danger" onclick="return confirm('Voulez-vous vraiment supprimer cette formation ?');">Supprimer</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Autres sections -->
            <div id="etudiants-section" class="content-section" style="display: none;">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-users"></i>
                        Gestion des Étudiants
                    </div>
                    <div class="card-body">
                        <p>Interface de gestion des étudiants à implémenter...</p>
                    </div>
                </div>
            </div>
            <!-- Ajoutez d'autres sections selon vos besoins -->
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function showSection(sectionName) {
        document.querySelectorAll('.content-section').forEach(section => {
            section.style.display = 'none';
        });
        document.querySelectorAll('.menu-item').forEach(item => {
            item.classList.remove('active');
        });
        document.getElementById(sectionName + '-section').style.display = 'block';
        event.target.classList.add('active');

        if (sectionName === 'formations') {
            console.log('Chargement des formations via AJAX...');
            fetch('${pageContext.request.contextPath}/formations', {
                headers: { 'Accept': 'application/json' }
            })
                .then(response => {
                    console.log('Statut HTTP:', response.status);
                    if (!response.ok) throw new Error('Erreur HTTP: ' + response.status);
                    return response.json();
                })
                .then(data => {
                    console.log('Données reçues:', data);
                    const tbody = document.querySelector('#formations-section tbody');
                    tbody.innerHTML = '';
                    if (data.formations && data.formations.length > 0) {
                        data.formations.forEach(formation => {
                            // Formater les UEs
                            let uesList = formation.ues ? formation.ues.map(ue => 
                                `${ue.nom} (${ue.id}) - Coeff: ${ue.coefficient || 'N/A'}`
                            ).join('<br>') : 'Aucune UE';
                            tbody.innerHTML += `
                                <tr>
                                    <td>${formation.id}</td>
                                    <td>${formation.intitule}</td>
                                    <td>${formation.niveau}</td>
                                    <td>${formation.nomResponsable || ''} (${formation.emailResponsable || ''})</td>
                                    <td>${uesList}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/formations?action=edit&id=${formation.id}" class="btn btn-sm btn-primary">Modifier</a>
                                        <a href="${pageContext.request.contextPath}/formations?action=delete&id=${formation.id}" class="btn btn-sm btn-danger" onclick="return confirm('Voulez-vous vraiment supprimer cette formation ?');">Supprimer</a>
                                    </td>
                                </tr>
                            `;
                        });
                    } else {
                        tbody.innerHTML = '<tr><td colspan="6">Aucune formation disponible.</td></tr>';
                    }
                })
                .catch(error => {
                    console.error('Erreur AJAX:', error);
                    document.querySelector('#formations-section .card-body').innerHTML += 
                        '<div class="alert alert-danger">Erreur lors du chargement des formations: ' + error.message + '</div>';
                });
        }
    }
</script>
</body>
</html>
```