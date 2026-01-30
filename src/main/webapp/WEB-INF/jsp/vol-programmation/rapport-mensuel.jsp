<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                
                <div class="mb-8 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Chiffre d'Affaires Mensuel</h1>
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center">
                                    <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">
                                        Accueil
                                    </a>
                                </li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Rapport Mensuel CA</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>

                    <!-- Filtre par Mois/Année -->
                    <form action="${pageContext.request.contextPath}/vol-programmation/rapport-mensuel" method="GET" class="flex items-end gap-3 bg-white p-4 rounded-lg shadow-sm border border-gray-200">
                        <div>
                            <label for="month" class="block text-xs font-semibold text-gray-500 uppercase mb-1">Mois</label>
                            <select name="month" id="month" class="rounded-md border-gray-300 text-sm focus:border-brand-500 focus:ring-brand-500">
                                <option value="1" ${selectedMonth == 1 ? 'selected' : ''}>Janvier</option>
                                <option value="2" ${selectedMonth == 2 ? 'selected' : ''}>Février</option>
                                <option value="3" ${selectedMonth == 3 ? 'selected' : ''}>Mars</option>
                                <option value="4" ${selectedMonth == 4 ? 'selected' : ''}>Avril</option>
                                <option value="5" ${selectedMonth == 5 ? 'selected' : ''}>Mai</option>
                                <option value="6" ${selectedMonth == 6 ? 'selected' : ''}>Juin</option>
                                <option value="7" ${selectedMonth == 7 ? 'selected' : ''}>Juillet</option>
                                <option value="8" ${selectedMonth == 8 ? 'selected' : ''}>Août</option>
                                <option value="9" ${selectedMonth == 9 ? 'selected' : ''}>Septembre</option>
                                <option value="10" ${selectedMonth == 10 ? 'selected' : ''}>Octobre</option>
                                <option value="11" ${selectedMonth == 11 ? 'selected' : ''}>Novembre</option>
                                <option value="12" ${selectedMonth == 12 ? 'selected' : ''}>Décembre</option>
                            </select>
                        </div>
                        <div>
                            <label for="year" class="block text-xs font-semibold text-gray-500 uppercase mb-1">Année</label>
                            <input type="number" name="year" id="year" value="${selectedYear}" 
                                   class="w-24 rounded-md border-gray-300 text-sm focus:border-brand-500 focus:ring-brand-500">
                        </div>
                        <button type="submit" class="px-4 py-2 bg-brand-600 text-white rounded-md text-sm font-medium hover:bg-brand-700 transition-colors">
                            Filtrer
                        </button>
                    </form>
                </div>

                <!-- Tableau Récapitulatif Mensuel -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden mb-8">
                    <div class="px-6 py-4 border-b border-gray-200 bg-gray-50/50">
                        <h3 class="text-lg font-medium text-gray-900">Résumé du Chiffre d'Affaires - <c:out value="${selectedMonth}"/>/<c:out value="${selectedYear}"/></h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3 text-right">CA Tickets</th>
                                    <th class="px-6 py-3 text-right">CA Publicités</th>
                                    <th class="px-6 py-3 text-right">Déjà Payé (Pub)</th>
                                    <th class="px-6 py-3 text-right">Reste à Payer (Pub)</th>
                                    <th class="px-6 py-3 text-right">CA Produits Extra</th>
                                    <th class="px-6 py-3 text-right font-bold text-brand-600">CA Total</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:set var="sumTickets" value="0" />
                                <c:forEach items="${ticketRevenues.values()}" var="val">
                                    <c:set var="sumTickets" value="${sumTickets + val}" />
                                </c:forEach>
                                
                                <c:set var="sumPubs" value="0" />
                                <c:forEach items="${pubRevenues.values()}" var="val">
                                    <c:set var="sumPubs" value="${sumPubs + val}" />
                                </c:forEach>
                                
                                <c:set var="sumPaid" value="0" />
                                <c:forEach items="${pubPaid.values()}" var="val">
                                    <c:set var="sumPaid" value="${sumPaid + val}" />
                                </c:forEach>
                                
                                <c:set var="sumRemaining" value="0" />
                                <c:forEach items="${pubRemaining.values()}" var="val">
                                    <c:set var="sumRemaining" value="${sumRemaining + val}" />
                                </c:forEach>

                                <tr class="bg-white">
                                    <td class="px-6 py-4 text-right font-medium text-gray-900">
                                        <fmt:formatNumber value="${sumTickets}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right font-medium text-gray-900">
                                        <fmt:formatNumber value="${sumPubs}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right font-medium text-green-600">
                                        <fmt:formatNumber value="${sumPaid}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right font-medium text-red-600">
                                        <fmt:formatNumber value="${sumRemaining}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right font-medium text-gray-900">
                                        <fmt:formatNumber value="${extraRevenue}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right font-bold text-brand-700 text-lg">
                                        <fmt:formatNumber value="${sumTickets + sumPubs + extraRevenue}" type="currency" currencySymbol="Ar" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Tableau des Ventes de Produits Extra -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden mb-8">
                    <div class="px-6 py-4 border-b border-gray-200 bg-gray-50/50 flex justify-between items-center">
                        <h3 class="text-lg font-medium text-gray-900">Ventes de Produits Extra</h3>
                        <div class="text-sm font-semibold text-brand-600 bg-brand-50 px-3 py-1 rounded-full">
                            Total : <fmt:formatNumber value="${extraRevenue}" type="currency" currencySymbol="Ar" />
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3">Produit</th>
                                    <th class="px-6 py-3">Client</th>
                                    <th class="px-6 py-3">Date</th>
                                    <th class="px-6 py-3 text-center">Quantité</th>
                                    <th class="px-6 py-3 text-right">Prix Unitaire</th>
                                    <th class="px-6 py-3 text-right">Total</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:forEach items="${extraDetails}" var="d">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-900 font-medium">${d.produitExtra.nom}</td>
                                        <td class="px-6 py-3 text-gray-600">${d.venteProduit.client.nom} ${d.venteProduit.client.prenom}</td>
                                        <td class="px-6 py-3 text-gray-600">
                                            <fmt:parseDate value="${d.venteProduit.dateVente}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedSaleDate" type="both" />
                                            <fmt:formatDate value="${parsedSaleDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td class="px-6 py-3 text-center text-gray-900">${d.quantite}</td>
                                        <td class="px-6 py-3 text-right text-gray-600">
                                            <fmt:formatNumber value="${d.prixUnitaire}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-right font-medium text-gray-900">
                                            <fmt:formatNumber value="${d.prixUnitaire * d.quantite}" type="currency" currencySymbol="Ar" />
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty extraDetails}">
                                    <tr>
                                        <td colspan="6" class="px-6 py-10 text-center text-gray-500 italic">
                                            Aucune vente de produit extra ce mois-ci.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Récapitulatif Global -->
                <div class="bg-brand-600 rounded-lg shadow-lg border border-brand-700 p-6 text-white">
                    <div class="flex flex-col md:flex-row justify-between items-center gap-6">
                        <div class="text-center md:text-left">
                            <h2 class="text-xl font-bold opacity-90">CHIFFRE D'AFFAIRES GLOBAL MENSUEL</h2>
                            <p class="text-brand-100 text-sm">Période : <c:out value="${selectedMonth}"/> / <c:out value="${selectedYear}"/></p>
                        </div>
                        <div class="flex gap-8">
                            <div class="text-center">
                                <p class="text-xs uppercase tracking-wider opacity-75 mb-1">Revenus Vols</p>
                                <p class="text-2xl font-bold">
                                    <fmt:formatNumber value="${sumTickets + sumPubs}" type="currency" currencySymbol="Ar" />
                                </p>
                            </div>
                            <div class="text-center">
                                <p class="text-xs uppercase tracking-wider opacity-75 mb-1">Revenus Extra</p>
                                <p class="text-2xl font-bold">
                                    <fmt:formatNumber value="${extraRevenue}" type="currency" currencySymbol="Ar" />
                                </p>
                            </div>
                            <div class="text-center bg-white/10 px-6 py-3 rounded-lg backdrop-blur-sm border border-white/10">
                                <p class="text-xs uppercase tracking-wider opacity-90 mb-1 font-bold">TOTAL GÉNÉRAL</p>
                                <p class="text-3xl font-black">
                                    <fmt:formatNumber value="${sumTickets + sumPubs + extraRevenue}" type="currency" currencySymbol="Ar" />
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>
</body>
</html>
