<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="min-h-screen bg-gradient-to-br from-black via-black-light to-black">
    <!-- Navbar -->
    <jsp:include page="../common/navbar.jsp" />

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Page Header -->
        <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <h1 class="text-3xl font-bold text-gold mb-2">Gestion des Vols</h1>
                <p class="text-gray-400">Liste complète des vols disponibles</p>
            </div>
            <div class="flex gap-3">
                <a href="/vols/create" class="bg-gradient-to-r from-gold to-gold-700 text-black px-6 py-3 rounded-lg hover:from-gold-600 hover:to-gold-800 shadow-lg transition-all text-sm font-bold flex items-center gap-2">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                    </svg>
                    Nouveau Vol
                </a>
            </div>
        </div>

        <!-- Flights Table -->
        <div class="bg-gradient-to-br from-black-light to-black-lighter rounded-xl shadow-lg border border-gold-900 overflow-hidden">
            <div class="px-6 py-4 border-b border-gold-900 flex flex-col sm:flex-row justify-between items-center gap-4">
                <h3 class="text-lg font-bold text-gold">Liste des Vols</h3>
                <div class="flex items-center gap-2">
                    <form action="/vols" method="get" class="flex gap-2 flex-wrap">
                        <input type="text" name="depart" placeholder="Départ..." class="px-4 py-2 bg-black border border-gold-900 rounded-lg text-gray-300 text-sm focus:outline-none focus:border-gold placeholder-gray-500" value="${param.depart}">
                        <input type="text" name="arrivee" placeholder="Arrivée..." class="px-4 py-2 bg-black border border-gold-900 rounded-lg text-gray-300 text-sm focus:outline-none focus:border-gold placeholder-gray-500" value="${param.arrivee}">
                        <button type="submit" class="bg-gold text-black px-4 py-2 rounded-lg hover:bg-gold-600 text-sm font-bold transition-colors">Filtrer</button>
                    </form>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full text-left text-sm">
                    <thead class="bg-black text-gold font-bold border-b border-gold-900">
                        <tr>
                            <th class="px-6 py-4">ID</th>
                            <th class="px-6 py-4">Départ</th>
                            <th class="px-6 py-4">Arrivée</th>
                            <th class="px-6 py-4">Durée</th>
                            <th class="px-6 py-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gold-900">
                        <c:forEach items="${vols}" var="vol">
                            <tr class="hover:bg-black-lighter transition-colors">
                                <td class="px-6 py-4 font-bold text-gold">${vol.id}</td>
                                <td class="px-6 py-4 font-semibold text-white">${vol.aeroportDepart.nom}</td>
                                <td class="px-6 py-4 font-semibold text-white">${vol.aeroportArrivee.nom}</td>
                                <td class="px-6 py-4 text-gray-300">${vol.duree}h</td>
                                <td class="px-6 py-4 flex gap-3">
                                            <a href="/vols/edit/${vol.id}" class="text-gold hover:text-gold-300 font-semibold transition-colors" title="Modifier">
                                                ✏️ Modifier
                                            </a>
                                            <a href="/vols/${vol.id}/delete" class="text-red-400 hover:text-red-300 font-semibold transition-colors" title="Supprimer" onclick="return confirm('Supprimer ce vol ?')">
                                                🗑️ Supprimer
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty vols}">
                                    <tr>
                                        <td colspan="5" class="px-6 py-12 text-center">
                                            <div class="flex flex-col items-center gap-3 text-gray-400">
                                                <svg class="w-16 h-16 text-gold-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                <p class="text-lg font-semibold text-gray-300">Aucun vol trouvé</p>
                                                <p class="text-sm">Créez votre premier vol pour commencer</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

    </main>
</body>
</html>
