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
                
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">Rapport de Chiffre d'Affaires Global par Vol</h1>
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
                                    <th class="px-6 py-3 text-right font-bold text-brand-600">CA Total</th>
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
                                        <td class="px-6 py-3 text-right font-bold text-brand-600">
                                            <fmt:formatNumber value="${totalRevenues[p.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                    </tr>
                                </c:forEach>
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
                                    <td class="px-6 py-4 text-right text-brand-700">
                                        <fmt:formatNumber value="${sumTickets + sumPubs}" type="currency" currencySymbol="Ar" />
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