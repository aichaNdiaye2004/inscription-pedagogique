// Gestion de la navigation
document.addEventListener('DOMContentLoaded', function() {
    // Smooth scrolling pour les liens de navigation
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Effet de transparence de la navbar au scroll
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.style.background = 'rgba(255, 255, 255, 0.98)';
            navbar.style.boxShadow = '0 2px 20px rgba(0, 0, 0, 0.1)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
            navbar.style.boxShadow = 'none';
        }
    });

    // Animation des compteurs dans la section stats
    const observerOptions = {
        threshold: 0.7,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                animateCounters();
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    const statsSection = document.querySelector('.stats');
    if (statsSection) {
        observer.observe(statsSection);
    }

    // Gestion du modal de connexion
    initializeModal();
});

// Fonction pour ouvrir le modal de connexion
function openLoginModal(userType) {
    const modal = document.getElementById('loginModal');
    const modalTitle = document.getElementById('modalTitle');
    const userTypeInput = document.getElementById('userType');

    if (modal && modalTitle && userTypeInput) {
        // Définir le type d'utilisateur
        userTypeInput.value = userType;

        // Changer le titre selon le type d'utilisateur
        if (userType === 'etudiant') {
            modalTitle.textContent = 'Connexion Étudiant';
        } else if (userType === 'responsable') {
            modalTitle.textContent = 'Connexion Responsable';
        }

        // Afficher le modal
        modal.style.display = 'block';

        // Ajouter la classe pour l'animation
        setTimeout(() => {
            modal.classList.add('show');
        }, 10);
    }
}

// Fonction pour fermer le modal
function closeModal() {
    const modal = document.getElementById('loginModal');
    if (modal) {
        modal.classList.remove('show');
        setTimeout(() => {
            modal.style.display = 'none';
        }, 300);
    }
}

// Initialiser la gestion du modal
function initializeModal() {
    const modal = document.getElementById('loginModal');
    const closeBtn = document.querySelector('.close');

    if (modal && closeBtn) {
        // Fermer le modal en cliquant sur la croix
        closeBtn.addEventListener('click', closeModal);

        // Fermer le modal en cliquant à l'extérieur
        window.addEventListener('click', function(event) {
            if (event.target === modal) {
                closeModal();
            }
        });

        // Fermer le modal avec la touche Échap
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape' && modal.style.display === 'block') {
                closeModal();
            }
        });
    }
}

// Animation des compteurs
function animateCounters() {
    const counters = document.querySelectorAll('.stat-number');

    counters.forEach(counter => {
        const target = parseInt(counter.textContent);
        const increment = target / 100;
        let current = 0;

        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                counter.textContent = target + (counter.textContent.includes('%') ? '%' : '+');
                clearInterval(timer);
            } else {
                counter.textContent = Math.floor(current) + (counter.textContent.includes('%') ? '%' : '+');
            }
        }, 20);
    });
}