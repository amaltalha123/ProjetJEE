// Script pour le dashboard admin
document.addEventListener('DOMContentLoaded', function() {
    // Gestion du formulaire d'ajout de catégorie
    const categoryForm = document.getElementById('categoryForm');
    if (categoryForm) {
        categoryForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const categoryName = document.getElementById('categoryName').value;
            
            if (categoryName.trim()) {
                // Simuler l'ajout d'une catégorie
                alert(`Catégorie "${categoryName}" ajoutée avec succès!`);
                categoryForm.reset();
                
                // En production, vous enverriez une requête AJAX ici
                // fetch('/api/categories', { method: 'POST', body: JSON.stringify({ name: categoryName }) })
            }
        });
    }
    
    // Gestion des boutons d'action
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('click', function() {
            const action = this.textContent.trim();
            const row = this.closest('tr');
            const id = row.querySelector('td:first-child').textContent;
            
            switch(action) {
                case 'Voir':
                    alert(`Voir les détails de l'élément ${id}`);
                    break;
                case 'Modifier':
                    alert(`Modifier l'élément ${id}`);
                    break;
                case 'Supprimer':
                    if (confirm('Êtes-vous sûr de vouloir supprimer cet élément ?')) {
                        alert(`Élément ${id} supprimé`);
                    }
                    break;
                case 'Traiter':
                case 'Résoudre':
                case 'Terminer':
                    alert(`Élément ${id} marqué comme traité`);
                    break;
            }
        });
    });
    
    // Animation des cartes de statistiques
    const statCards = document.querySelectorAll('.stat-card');
    statCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
    
    // Confirmation de déconnexion
    const logoutLinks = document.querySelectorAll('.logout-link');
    logoutLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (!confirm('Êtes-vous sûr de vouloir vous déconnecter ?')) {
                e.preventDefault();
            }
        });
    });
});