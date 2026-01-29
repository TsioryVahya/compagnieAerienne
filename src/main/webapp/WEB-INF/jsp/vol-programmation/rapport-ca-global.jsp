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
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Rapport de Chiffre d'Affaires Global</h1>
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
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Rapport Global CA</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>

                    <!-- Filtre par Mois/Année -->
                    <form action="${pageContext.request.contextPath}/vol-programmation/rapport-ca-global" method="GET" class="flex items-end gap-3 bg-white p-4 rounded-lg shadow-sm border border-gray-200">
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

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-gray-200">
                        <h3 class="text-lg font-medium text-gray-900">Détails des Revenus par Vol</h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3">Aéroport Départ</th>
                                    <th class="px-6 py-3">Aéroport Arrivée</th>
                                    <th class="px-6 py-3">Avion</th>
                                    <th class="px-6 py-3">Date Départ</th>
                                    <th class="px-6 py-3">Heure Départ</th>
                                    <th class="px-6 py-3 text-right">CA Tickets</th>
                                    <th class="px-6 py-3 text-right">CA Publicités</th>
                                    <th class="px-6 py-3 text-right">Déjà Payé (Pub)</th>
                                    <th class="px-6 py-3 text-right">Reste à Payer (Pub)</th>
                                    <th class="px-6 py-3 text-right">CA Produits Extra</th>
                                    <th class="px-6 py-3 text-right font-bold text-brand-600">CA Total</th>
                                    <th class="px-6 py-3 text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:forEach items="${programmations}" var="p">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-600">${p.vol.aeroportDepart.nom}</td>
                                        <td class="px-6 py-3 text-gray-600">${p.vol.aeroportArrivee.nom}</td>
                                        <td class="px-6 py-3 text-gray-600">${p.avion != null ? p.avion.matricule : 'N/A'}</td>
                                        <td class="px-6 py-3 text-gray-900">
                                            <fmt:parseDate value="${p.dateHeure}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                            <fmt:formatDate value="${parsedDateTime}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td class="px-6 py-3 text-gray-900">
                                            <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                                        </td>
                                        <td class="px-6 py-3 text-right font-medium text-gray-900">
                                            <fmt:formatNumber value="${ticketRevenues[p.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-right font-medium text-gray-900">
                                            <fmt:formatNumber value="${pubRevenues[p.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-right font-medium text-green-600">
                                            <fmt:formatNumber value="${pubPaid[p.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-right font-medium text-red-600">
                                            <fmt:formatNumber value="${pubRemaining[p.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-right text-gray-400 italic text-xs">
                                            -
                                        </td>
                                        <td class="px-6 py-3 text-right font-bold text-brand-600">
                                            <fmt:formatNumber value="${totalRevenues[p.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-center">
                                            <a href="${pageContext.request.contextPath}/vol-programmation/revenus-details/${p.id}" 
                                               class="inline-flex items-center px-3 py-1 bg-brand-50 text-brand-600 hover:bg-brand-100 rounded-md transition-colors text-xs font-semibold">
                                                Détails
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <!-- Ligne Spéciale pour les Produits Extra du Mois -->
                                <tr class="bg-brand-50/30">
                                    <td colspan="5" class="px-6 py-4 text-gray-900 font-semibold italic">
                                        Ventes de Produits Extra du Mois (${selectedMonth}/${selectedYear})
                                    </td>
                                    <td class="px-6 py-4 text-right text-gray-400 italic text-xs">-</td>
                                    <td class="px-6 py-4 text-right text-gray-400 italic text-xs">-</td>
                                    <td class="px-6 py-4 text-right text-gray-400 italic text-xs">-</td>
                                    <td class="px-6 py-4 text-right text-gray-400 italic text-xs">-</td>
                                    <td class="px-6 py-4 text-right font-semibold text-brand-600">
                                        <fmt:formatNumber value="${extraRevenue}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right font-semibold text-brand-600">
                                        <fmt:formatNumber value="${extraRevenue}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td></td>
                                </tr>
                            </tbody>
                            <tfoot class="bg-gray-50 font-bold">
                                <tr>
                                    <td colspan="5" class="px-6 py-4 text-right text-gray-900">TOTAUX :</td>
                                    <td class="px-6 py-4 text-right text-gray-900">
                                        <c:set var="sumTickets" value="0" />
                                        <c:forEach items="${ticketRevenues.values()}" var="val">
                                            <c:set var="sumTickets" value="${sumTickets + val}" />
                                        </c:forEach>
                                        <fmt:formatNumber value="${sumTickets}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right text-gray-900">
                                        <c:set var="sumPubs" value="0" />
                                        <c:forEach items="${pubRevenues.values()}" var="val">
                                            <c:set var="sumPubs" value="${sumPubs + val}" />
                                        </c:forEach>
                                        <fmt:formatNumber value="${sumPubs}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right text-green-600">
                                        <c:set var="sumPaid" value="0" />
                                        <c:forEach items="${pubPaid.values()}" var="val">
                                            <c:set var="sumPaid" value="${sumPaid + val}" />
                                        </c:forEach>
                                        <fmt:formatNumber value="${sumPaid}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right text-red-600">
                                        <c:set var="sumRemaining" value="0" />
                                        <c:forEach items="${pubRemaining.values()}" var="val">
                                            <c:set var="sumRemaining" value="${sumRemaining + val}" />
                                        </c:forEach>
                                        <fmt:formatNumber value="${sumRemaining}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right text-brand-600 font-medium">
                                        <fmt:formatNumber value="${extraRevenue}" type="currency" currencySymbol="Ar" />
                                    </td>
                                    <td class="px-6 py-4 text-right text-brand-700">
                                        <fmt:formatNumber value="${sumTickets + sumPubs + extraRevenue}" type="currency" currencySymbol="Ar" />
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </main>
    </div>
</body>
</html>