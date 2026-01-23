<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="common/header.jsp" />

<body class="min-h-screen bg-gradient-to-br from-black via-black-light to-black">
    <!-- Navbar -->
    <jsp:include page="common/navbar.jsp" />

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        
        <!-- Page Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gold mb-2">Tableau de Bord</h1>
            <p class="text-gray-400">Vue d'ensemble de votre compagnie aérienne</p>
        </div>

        <!-- Stats Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
                    <!-- Stat Card 1 -->
                    <div class="bg-gradient-to-br from-black-light to-black-lighter rounded-xl p-6 shadow-lg border border-gold-900">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider">Vols Aujourd'hui</h3>
                            <span class="p-3 bg-gold bg-opacity-20 text-gold rounded-lg">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5" />
                                </svg>
                            </span>
                        </div>
                        <div class="text-3xl font-bold text-white mb-2">${volsAujourdhui}</div>
                        <p class="text-sm text-gold">Programmés ce jour</p>
                    </div>

                    <!-- Stat Card 2 -->
                    <div class="bg-gradient-to-br from-black-light to-black-lighter rounded-xl p-6 shadow-lg border border-gold-900">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider">Passagers</h3>
                            <span class="p-3 bg-gold bg-opacity-20 text-gold rounded-lg">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z" />
                                </svg>
                            </span>
                        </div>
                        <div class="text-3xl font-bold text-white mb-2">
                            <fmt:formatNumber value="${passagersMois}" type="number" />
                        </div>
                        <p class="text-sm text-gold">Ce mois-ci</p>
                    </div>

                     <!-- Stat Card 3 -->
                    <div class="bg-gradient-to-br from-black-light to-black-lighter rounded-xl p-6 shadow-lg border border-gold-900">
                         <div class="flex items-center justify-between mb-4">
                            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider">Revenus</h3>
                            <span class="p-3 bg-gold bg-opacity-20 text-gold rounded-lg">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </span>
                        </div>
                        <div class="text-3xl font-bold text-white mb-2">
                            <fmt:formatNumber value="${revenusMois}" type="currency" currencySymbol="$" />
                        </div>
                        <p class="text-sm text-gold">Ce mois-ci</p>
                    </div>

                    <!-- Stat Card 4 -->
                    <div class="bg-gradient-to-br from-black-light to-black-lighter rounded-xl p-6 shadow-lg border border-gold-900">
                         <div class="flex items-center justify-between mb-4">
                            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider">Retards</h3>
                            <span class="p-3 bg-red-600 bg-opacity-20 text-red-400 rounded-lg">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z" />
                                </svg>
                            </span>
                        </div>
                        <div class="text-3xl font-bold text-white mb-2">${retards}</div>
                        <p class="text-sm text-red-400">Attention requise</p>
                    </div>
                </div>

                <!-- Recent Flights Table -->
                 <div class="bg-gradient-to-br from-black-light to-black-lighter rounded-xl shadow-lg border border-gold-900 overflow-hidden">
                    <div class="px-6 py-4 border-b border-gold-900 flex justify-between items-center">
                        <h3 class="text-lg font-bold text-gold">Vols Récents</h3>
                        <a href="${pageContext.request.contextPath}/vol-programmation" class="text-sm font-semibold text-gold hover:text-gold-300 transition-colors">Voir tout →</a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm">
                            <thead class="bg-black text-gold font-bold border-b border-gold-900">
                                <tr>
                                    <th class="px-6 py-4">Vol No.</th>
                                    <th class="px-6 py-4">Destination</th>
                                    <th class="px-6 py-4">Départ</th>
                                    <th class="px-6 py-4">Statut</th>
                                    <th class="px-6 py-4">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gold-900">
                                <c:forEach items="${volsRecents}" var="prog">
                                    <tr class="hover:bg-black-lighter transition-colors">
                                        <td class="px-6 py-4 font-bold text-gold">VOL-${prog.vol.id}</td>
                                        <td class="px-6 py-4 text-gray-300">${prog.vol.aeroportArrivee.nom}</td>
                                        <td class="px-6 py-4 text-gray-300">
                                            <c:out value="${prog.dateHeure.toString().substring(11, 16)}" />
                                        </td>
                                        <td class="px-6 py-4">
                                            <c:set var="statut" value="${statusMap[prog.id]}" />
                                            <span class="inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-bold border
                                                ${statut == 'A l\'heure' || statut == 'En cours' ? 'bg-green-900 bg-opacity-20 text-green-400 border-green-700' : 
                                                  statut == 'Retardé' ? 'bg-orange-900 bg-opacity-20 text-orange-400 border-orange-700' : 
                                                  statut == 'Annulé' ? 'bg-red-900 bg-opacity-20 text-red-400 border-red-700' : 'bg-gray-800 text-gray-400 border-gray-700'}">
                                                <span class="h-2 w-2 rounded-full 
                                                    ${statut == 'A l\'heure' || statut == 'En cours' ? 'bg-green-400' : 
                                                      statut == 'Retardé' ? 'bg-orange-400' : 
                                                      statut == 'Annulé' ? 'bg-red-400' : 'bg-gray-400'}"></span>
                                                ${statut}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <a href="${pageContext.request.contextPath}/vol-programmation/details/${prog.id}" class="text-gold hover:text-gold-300 transition-colors">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-5 h-5">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
                                                </svg>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

        </main>
</body>
</html>
