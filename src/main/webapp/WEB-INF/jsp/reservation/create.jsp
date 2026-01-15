<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-brand-50">
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <!-- Main Content Wrapper -->
    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <!-- Top Navbar -->
        <jsp:include page="../common/navbar.jsp" />

        <!-- Main Page Content -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-brand-50 p-6">
            <div class="container mx-auto max-w-4xl">
                
                <!-- Page Header with Breadcrumb -->
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">Nouvelle Réservation</h1>
                    <!-- Breadcrumb -->
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">
                                    <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path></svg>
                                    Accueil
                                </a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <a href="/reservations" class="ml-1 text-sm font-medium text-gray-500 hover:text-brand-600 md:ml-2">Réservations</a>
                                </div>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Créer</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <!-- Form Card -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                    <form action="/reservations" method="post" class="space-y-6">
                        
                        <!-- Vol Selection -->
                        <div>
                            <label for="vol" class="block text-sm font-medium text-gray-700 mb-2">Vol</label>
                            <select class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" id="vol" required>
                                <option value="">Sélectionnez un vol</option>
                                <c:forEach items="${vols}" var="v">
                                    <option value="${v.id}" ${selectedVolId == v.id ? 'selected' : ''}>
                                        ${v.aeroportDepart.nom} → ${v.aeroportArrivee.nom} - ${v.duree}h
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Date et Heure du Vol (Programmation) -->
                        <div>
                            <label for="volProgrammation" class="block text-sm font-medium text-gray-700 mb-2">Date et Heure du Vol</label>
                            <select class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" 
                                    id="volProgrammation" 
                                    name="volProgrammation.id" 
                                    required disabled>
                                <option value="">Choisir une date</option>
                            </select>
                            <p class="mt-1 text-sm text-gray-500">Sélectionnez d'abord un vol pour voir les créneaux disponibles</p>
                            <p id="volProgrammationDisplay" class="mt-1 text-sm text-gray-700 font-medium hidden"></p>
                        </div>

                        <!-- Client Selection -->
                        <div>
                            <label for="client" class="block text-sm font-medium text-gray-700 mb-2">Client</label>
                            <!-- DEBUG: Nombre de clients = ${clients.size()} -->
                            <select class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" id="client" name="client.id" required>
                                <option value="">Sélectionnez un client</option>
                                <c:forEach items="${clients}" var="cl">
                                    <option value="${cl.id}">${cl.nom} ${cl.prenom} - ${cl.email}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Nombre de Places -->
                        <div>
                            <label for="nombrePlaces" class="block text-sm font-medium text-gray-700 mb-2">Nombre de Places</label>
                            <input type="number" min="1" max="10" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" id="nombrePlaces" name="nombrePlaces" value="1" required>
                        </div>

                        <!-- Sélection des Places -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-3">Sélection des Places</label>
                            <div class="bg-gray-50 p-6 rounded-lg border border-gray-200">
                                <!-- Légende -->
                                <div class="flex gap-4 mb-6 text-sm">
                                    <div class="flex items-center gap-2">
                                        <div class="w-8 h-8 bg-green-100 border border-green-300 rounded"></div>
                                        <span>Disponible</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <div class="w-8 h-8 bg-brand-600 text-white border border-brand-700 rounded flex items-center justify-center font-bold">✓</div>
                                        <span>Sélectionné</span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <div class="w-8 h-8 bg-red-200 border-2 border-red-400 rounded"></div>
                                        <span>Déjà réservé</span>
                                    </div>
                                </div>

                                <!-- Grille de Sièges Dynamique -->
                                <div id="seatsContainer" class="space-y-2">
                                    <!-- Les sièges seront générés dynamiquement par JavaScript -->
                                </div>

                                <!-- Pagination -->
                                <div id="paginationContainer" class="mt-4 flex items-center justify-center gap-2">
                                    <!-- La pagination sera générée dynamiquement -->
                                </div>

                                <!-- Input caché pour stocker les places sélectionnées -->
                                <input type="hidden" id="selectedSeats" name="placesSelectionnees" value="">
                                <div class="mt-4 text-sm text-gray-600">
                                    Places sélectionnées: <span id="selectedSeatsDisplay" class="font-bold text-brand-600">Aucune</span>
                                </div>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="flex gap-3 pt-4">
                            <button type="submit" class="bg-brand-600 text-white px-6 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium">
                                Enregistrer la réservation
                            </button>
                            <a href="/reservations" class="bg-gray-100 text-gray-700 px-6 py-2 rounded-md hover:bg-gray-200 shadow-sm transition-colors text-sm font-medium">
                                Annuler
                            </a>
                        </div>
                    </form>
                </div>

            </div>
        </main>
    </div>

    <script>
        // Gestion de la sélection des sièges
        const nombrePlacesInput = document.getElementById('nombrePlaces');
        const selectedSeatsInput = document.getElementById('selectedSeats');
        const selectedSeatsDisplay = document.getElementById('selectedSeatsDisplay');
        const seatsContainer = document.getElementById('seatsContainer');
        const paginationContainer = document.getElementById('paginationContainer');
        const volSelect = document.getElementById('vol');
        const classeSelect = document.getElementById('classe');
        const volProgrammationSelect = document.getElementById('volProgrammation');
        const volProgrammationDisplay = document.getElementById('volProgrammationDisplay');
        const initialVolProgrammationId = '${selectedVolProgrammationId}';
        let initialVolProgrammationApplied = false;
        
        let selectedSeats = [];
        let plageDebut = 1;
        let plageFin = 36;
        let currentPage = 1;
        let occupiedSeats = []; // Places déjà réservées
        const seatsPerPage = 36; // 6 rangées × 6 sièges
        const seatsPerRow = 6;
        let avionClasses = []; // Stocke les plages de sièges par classe pour l'avion actuel

        // Écouter le changement de vol pour charger les programmations disponibles
        volSelect.addEventListener('change', async function() {
            const volId = this.value;
            volProgrammationSelect.innerHTML = '<option value="">Choisir une date</option>';
            volProgrammationDisplay.textContent = '';
            volProgrammationDisplay.classList.add('hidden');
            volProgrammationSelect.disabled = true;
            
            if (!volId) return;
            
            try {
                // Récupérer les programmations disponibles (retourne liste d'objets {id, dateHeure, avionId, avionCapacite})
                const response = await fetch('/api/vol/' + volId + '/programmations');
                const programmations = await response.json();
                
                if (programmations.length > 0) {
                    programmations.forEach(prog => {
                        const option = document.createElement('option');
                        option.value = prog.id;
                        const date = new Date(prog.dateHeure);
                        option.textContent = date.toLocaleString('fr-FR');
                        option.dataset.display = option.textContent;
                        option.dataset.avionId = prog.avionId;
                        option.dataset.avionCapacite = prog.avionCapacite;
                        volProgrammationSelect.appendChild(option);
                    });
                    volProgrammationSelect.disabled = false;

                    if (initialVolProgrammationId && !initialVolProgrammationApplied) {
                        const optionToSelect = Array.from(volProgrammationSelect.options)
                            .find(o => o.value === initialVolProgrammationId);
                        if (optionToSelect) {
                            volProgrammationSelect.value = initialVolProgrammationId;
                            volProgrammationSelect.dispatchEvent(new Event('change'));
                            initialVolProgrammationApplied = true;
                        }
                    }
                } else {
                     const option = document.createElement('option');
                     option.textContent = "Aucune date disponible";
                     volProgrammationSelect.appendChild(option);
                }
            } catch (error) {
                console.error('Erreur lors du chargement des programmations:', error);
            }
        });

        // Écouter le changement de programmation pour mettre à jour les places occupées
        volProgrammationSelect.addEventListener('change', async function() {
            const selectedOption = volProgrammationSelect.options[volProgrammationSelect.selectedIndex];
            if (selectedOption && selectedOption.value) {
                const displayText = selectedOption.dataset.display || selectedOption.textContent;
                volProgrammationDisplay.textContent = 'Date choisie : ' + displayText;
                volProgrammationDisplay.classList.remove('hidden');
                
                const avionId = selectedOption.dataset.avionId;
                const avionCapacite = selectedOption.dataset.avionCapacite;
                
                if (avionId) {
                    // Charger les configurations de classe pour cet avion
                    try {
                        const response = await fetch('/api/avion/' + avionId + '/classes-places');
                        avionClasses = await response.json();
                        
                        // Définir la plage totale de l'avion pour la grille
                        plageDebut = 1;
                        plageFin = parseInt(avionCapacite) || 36;
                        currentPage = 1;
                        selectedSeats = [];
                        
                        await updateAvailableSeats();
                    } catch (error) {
                        console.error('Erreur lors du chargement des classes de l\'avion:', error);
                    }
                }
            } else {
                volProgrammationDisplay.textContent = '';
                volProgrammationDisplay.classList.add('hidden');
                avionClasses = [];
                seatsContainer.innerHTML = '<p class="text-gray-500 text-center py-8">Veuillez sélectionner un vol et une date</p>';
                paginationContainer.innerHTML = '';
            }
        });

        // Fonction pour générer la grille de sièges
        function generateSeats() {
            const totalSeats = plageFin - plageDebut + 1;
            const totalPages = Math.ceil(totalSeats / seatsPerPage);
            
            // Calculer les sièges pour la page actuelle
            const startSeat = plageDebut + (currentPage - 1) * seatsPerPage;
            const endSeat = Math.min(startSeat + seatsPerPage - 1, plageFin);
            
            seatsContainer.innerHTML = '';
            
            let seatNum = startSeat;
            while (seatNum <= endSeat) {
                const row = document.createElement('div');
                row.className = 'flex gap-2 justify-center mb-2';
                
                // Première moitié de la rangée (3 sièges)
                for (let i = 0; i < 3 && seatNum <= endSeat; i++, seatNum++) {
                    const btn = createSeatButton(seatNum);
                    row.appendChild(btn);
                }
                
                // Allée centrale
                const aisle = document.createElement('div');
                aisle.className = 'w-8';
                row.appendChild(aisle);
                
                // Deuxième moitié de la rangée (3 sièges)
                for (let i = 0; i < 3 && seatNum <= endSeat; i++, seatNum++) {
                    const btn = createSeatButton(seatNum);
                    row.appendChild(btn);
                }
                
                seatsContainer.appendChild(row);
            }
            
            generatePagination(totalPages);
        }

        // Fonction pour créer un bouton de siège
        function createSeatButton(seatNum) {
            const btn = document.createElement('button');
            btn.type = 'button';
            btn.dataset.seat = seatNum;
            btn.textContent = seatNum;
            
            // Trouver la classe pour ce siège
            const classeInfo = avionClasses.find(c => seatNum >= c.placeDebut && seatNum <= c.placeFin);
            if (classeInfo) {
                btn.title = classeInfo.classe.nom;
                // Colorer légèrement selon la classe pour aider l'utilisateur
                if (classeInfo.classe.nom.includes('Première')) btn.classList.add('ring-2', 'ring-yellow-400');
                else if (classeInfo.classe.nom.includes('Affaires')) btn.classList.add('ring-2', 'ring-blue-400');
            }
            
            // Vérifier si la place est occupée
            const isOccupied = occupiedSeats.includes(seatNum);
            
            if (isOccupied) {
                btn.className = 'seat-btn w-10 h-10 bg-red-200 border-2 border-red-400 rounded transition-colors text-sm font-medium cursor-not-allowed';
                btn.disabled = true;
            } else {
                btn.className = 'seat-btn w-10 h-10 bg-green-100 border border-green-300 rounded transition-colors text-sm font-medium hover:border-brand-500';
                btn.disabled = false;
            }
            
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                if (this.disabled) return;
                
                const maxSeats = parseInt(nombrePlacesInput.value);
                const seat = this.dataset.seat;

                if (selectedSeats.includes(seat)) {
                    selectedSeats = selectedSeats.filter(s => s !== seat);
                } else if (selectedSeats.length < maxSeats) {
                    selectedSeats.push(seat);
                } else {
                    alert('Vous avez atteint le nombre maximum de places (' + maxSeats + ')');
                }

                updateSeatStates();
                updateDisplay();
            });
            
            return btn;
        }

        // Fonction pour générer la pagination
        function generatePagination(totalPages) {
            paginationContainer.innerHTML = '';
            
            if (totalPages <= 1) return;
            
            // Bouton Précédent
            const prevBtn = document.createElement('button');
            prevBtn.type = 'button';
            prevBtn.className = 'px-3 py-1 border rounded ' + (currentPage === 1 ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : 'bg-white text-gray-700 hover:bg-gray-50');
            prevBtn.textContent = '‹ Précédent';
            prevBtn.disabled = currentPage === 1;
            prevBtn.addEventListener('click', () => {
                if (currentPage > 1) {
                    currentPage--;
                    generateSeats();
                    updateSeatStates();
                }
            });
            paginationContainer.appendChild(prevBtn);
            
            // Numéros de page
            for (let i = 1; i <= totalPages; i++) {
                const pageBtn = document.createElement('button');
                pageBtn.type = 'button';
                pageBtn.className = 'px-3 py-1 border rounded ' + (i === currentPage ? 'bg-brand-600 text-white' : 'bg-white text-gray-700 hover:bg-gray-50');
                pageBtn.textContent = i;
                pageBtn.addEventListener('click', () => {
                    currentPage = i;
                    generateSeats();
                    updateSeatStates();
                });
                paginationContainer.appendChild(pageBtn);
            }
            
            // Bouton Suivant
            const nextBtn = document.createElement('button');
            nextBtn.type = 'button';
            nextBtn.className = 'px-3 py-1 border rounded ' + (currentPage === totalPages ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : 'bg-white text-gray-700 hover:bg-gray-50');
            nextBtn.textContent = 'Suivant ›';
            nextBtn.disabled = currentPage === totalPages;
            nextBtn.addEventListener('click', () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    generateSeats();
                    updateSeatStates();
                }
            });
            paginationContainer.appendChild(nextBtn);
        }

        // Fonction pour mettre à jour l'état des sièges
        function updateSeatStates() {
            const seatButtons = document.querySelectorAll('.seat-btn');
            seatButtons.forEach(btn => {
                const seatNum = btn.dataset.seat;
                if (selectedSeats.includes(seatNum)) {
                    btn.classList.remove('bg-green-100', 'border-green-300');
                    btn.classList.add('bg-brand-600', 'text-white', 'border-brand-700');
                } else if (!occupiedSeats.includes(parseInt(seatNum))) {
                    btn.classList.remove('bg-brand-600', 'text-white', 'border-brand-700');
                    btn.classList.add('bg-green-100', 'border-green-300');
                }
            });
        }

        // Fonction pour charger les places occupées et rafraîchir la grille
        async function updateAvailableSeats() {
            const volProgrammationId = volProgrammationSelect.value;

            if (!volProgrammationId) {
                occupiedSeats = [];
                generateSeats();
                return;
            }

            try {
                const response = await fetch('/api/places-occupees/' + volProgrammationId);
                if (response.ok) {
                    occupiedSeats = await response.json();
                } else {
                    occupiedSeats = [];
                }
                generateSeats();
                updateSeatStates();
                updateDisplay();
            } catch (error) {
                console.error('Erreur lors de la récupération des places occupées:', error);
                occupiedSeats = [];
                generateSeats();
            }
        }

        // Écouter les changements de nombre de places
        nombrePlacesInput.addEventListener('change', function() {
            const maxSeats = parseInt(this.value);
            if (selectedSeats.length > maxSeats) {
                selectedSeats = selectedSeats.slice(0, maxSeats);
                updateSeatStates();
                updateDisplay();
            }
        });

        function updateDisplay() {
            selectedSeatsInput.value = selectedSeats.join(',');
            let displayText = 'Aucune';
            if (selectedSeats.length > 0) {
                const sorted = selectedSeats.map(s => parseInt(s)).sort((a, b) => a - b);
                
                // Grouper par classe
                const classGroups = {};
                sorted.forEach(seatNum => {
                    const classeInfo = avionClasses.find(c => seatNum >= c.placeDebut && seatNum <= c.placeFin);
                    const className = classeInfo ? classeInfo.classe.nom : 'Inconnue';
                    if (!classGroups[className]) classGroups[className] = [];
                    classGroups[className].push(seatNum);
                });
                
                displayText = Object.entries(classGroups)
                    .map(([className, seats]) => className + ': ' + seats.join(', '))
                    .join(' | ');
            }
            selectedSeatsDisplay.textContent = displayText;
        }

        // Initialiser
        if (volSelect.value) {
            volSelect.dispatchEvent(new Event('change'));
        }
    </script>
</body>
</html>
