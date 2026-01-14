<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <!-- Main Content Wrapper -->
    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <!-- Top Navbar -->
        <jsp:include page="../common/navbar.jsp" />

        <!-- Main Page Content -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-2xl">
                
                <!-- Page Header with Breadcrumb -->
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${programmation.id != null ? 'Modifier la Programmation' : 'Nouvelle Programmation'}</h1>
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
                                    <a href="/vol-programmation" class="ml-1 text-sm font-medium text-gray-500 hover:text-brand-600 md:ml-2">Programmations</a>
                                </div>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">${programmation.id != null ? 'Modifier' : 'Créer'}</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <!-- Form Card -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                    <form action="/vol-programmation/save" method="post" class="space-y-6">
                        <input type="hidden" name="id" value="${programmation.id}">
                        
                        <!-- Vol Selection -->
                        <div>
                            <label for="vol" class="block text-sm font-medium text-gray-700 mb-2">Choisir un Vol</label>
                            <select class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" id="vol" name="vol.id" required>
                                <option value="">Sélectionnez un vol</option>
                                <c:forEach items="${vols}" var="v">
                                    <option value="${v.id}" ${programmation.vol.id == v.id ? 'selected' : ''}>
                                        ${v.aeroportDepart.nom} → ${v.aeroportArrivee.nom} (${v.duree}h)
                                    </option>
                                </c:forEach>
                            </select>
                            <p class="mt-1 text-sm text-gray-500">Le vol définit l'origine, la destination et la durée.</p>
                        </div>

                        <!-- Avion Selection -->
                        <div>
                            <label for="avion" class="block text-sm font-medium text-gray-700 mb-2">Choisir un Avion</label>
                            <select class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" id="avion" name="avion.id" required>
                                <option value="">Sélectionnez un avion</option>
                                <c:forEach items="${avions}" var="a">
                                    <option value="${a.id}" ${programmation.avion.id == a.id ? 'selected' : ''}>
                                        ${a.matricule} - Capacité: ${a.capacite}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Date et Heure -->
                        <div>
                            <label for="dateHeure" class="block text-sm font-medium text-gray-700 mb-2">Date et Heure de départ</label>
                            <input type="datetime-local" 
                                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" 
                                   id="dateHeure" 
                                   name="dateHeure" 
                                   value="${programmation.dateHeure}"
                                   required>
                        </div>

                        <!-- Tarifs par Classe -->
                        <div class="border-t border-gray-100 pt-6">
                            <h3 class="text-sm font-semibold text-gray-900 mb-4">Tarifs par Classe</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <c:forEach items="${classes}" var="classe">
                                    <c:set var="tarifKey" value="tarif_${classe.id}" />
                                    <div>
                                        <label for="tarif_${classe.id}" class="block text-xs font-medium text-gray-500 mb-1">${classe.nom}</label>
                                        <div class="relative">
                                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <span class="text-gray-500 sm:text-sm">Ar</span>
                                            </div>
                                            <input type="number" 
                                                   step="0.01" 
                                                   name="tarif_${classe.id}" 
                                                   id="tarif_${classe.id}" 
                                                   value="${requestScope[tarifKey]}"
                                                   class="w-full pl-8 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent text-sm" 
                                                   placeholder="0.00" 
                                                   required>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Statut de la Programmation (visible uniquement en édition) -->
                        <c:if test="${programmation.id != null}">
                            <div class="border-t border-gray-100 pt-6">
                                <label for="statutId" class="block text-sm font-medium text-gray-700 mb-2">Statut de la Programmation</label>
                                <select class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent" id="statutId" name="statutId">
                                    <c:forEach items="${allStatuts}" var="statut">
                                        <option value="${statut.id}" ${currentStatut.id == statut.id ? 'selected' : ''}>${statut.nom}</option>
                                    </c:forEach>
                                </select>
                                <p class="mt-1 text-sm text-gray-500">Modifier le statut de cette programmation de vol.</p>
                            </div>
                        </c:if>

                        <!-- Actions -->
                        <div class="flex gap-3 pt-4">
                            <button type="submit" class="bg-brand-600 text-white px-6 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium">
                                Enregistrer
                            </button>
                            <a href="/vol-programmation" class="bg-gray-100 text-gray-700 px-6 py-2 rounded-md hover:bg-gray-200 shadow-sm transition-colors text-sm font-medium">
                                Annuler
                            </a>
                        </div>
                    </form>
                </div>

            </div>
        </main>
    </div>
</body>
</html>
