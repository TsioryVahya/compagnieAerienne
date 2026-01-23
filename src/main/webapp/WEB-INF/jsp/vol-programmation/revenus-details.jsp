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
                
                <div class="mb-8 flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Détails des Revenus : Vol #${programmation.id}</h1>
                        <p class="text-gray-600">
                            ${programmation.vol.aeroportDepart.nom} → ${programmation.vol.aeroportArrivee.nom} | 
                            <fmt:parseDate value="${programmation.dateHeure}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                            <fmt:formatDate value="${parsedDateTime}" pattern="dd/MM/yyyy HH:mm" />
                        </p>
                    </div>
                    <a href="${pageContext.request.contextPath}/vol-programmation/rapport-ca-global" class="text-brand-600 hover:text-brand-700 font-medium flex items-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                        Retour au rapport
                    </a>
                </div>

                <!-- Résumé des Revenus -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                    <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                        <h3 class="text-sm font-medium text-gray-500 mb-2">CA Tickets</h3>
                        <p class="text-2xl font-bold text-gray-900">
                            <fmt:formatNumber value="${ticketRevenue}" type="currency" currencySymbol="Ar" />
                        </p>
                    </div>
                    <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                        <h3 class="text-sm font-medium text-gray-500 mb-2">CA Publicités (Total)</h3>
                        <p class="text-2xl font-bold text-gray-900">
                            <c:set var="totalPub" value="0" />
                            <c:forEach items="${pubTotals.values()}" var="val"><c:set var="totalPub" value="${totalPub + val}" /></c:forEach>
                            <fmt:formatNumber value="${totalPub}" type="currency" currencySymbol="Ar" />
                        </p>
                    </div>
                    <div class="bg-white p-6 rounded-lg shadow-sm border border-brand-200 bg-brand-50">
                        <h3 class="text-sm font-medium text-brand-700 mb-2">Chiffre d'Affaires Total</h3>
                        <p class="text-2xl font-bold text-brand-600">
                            <fmt:formatNumber value="${ticketRevenue + totalPub}" type="currency" currencySymbol="Ar" />
                        </p>
                    </div>
                </div>

                <!-- Détails Publicités -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-gray-200">
                        <h3 class="text-lg font-medium text-gray-900">Détails des Paiements Publicitaires</h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3">Société</th>
                                    <th class="px-6 py-3">Diffusion</th>
                                    <th class="px-6 py-3 text-center">Nombre</th>
                                    <th class="px-6 py-3 text-right">Montant Total</th>
                                    <th class="px-6 py-3 text-right">Déjà Payé</th>
                                    <th class="px-6 py-3 text-right">Reste à Payer</th>
                                    <th class="px-6 py-3 text-center">Statut</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:forEach items="${pubs}" var="pub">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-900 font-medium">${pub.diffusion.societe.nom}</td>
                                        <td class="px-6 py-3 text-gray-600">${pub.diffusion.nom}</td>
                                        <td class="px-6 py-3 text-center text-gray-600">${pub.nombreDiffusions}</td>
                                        <td class="px-6 py-3 text-right font-medium text-gray-900">
                                            <fmt:formatNumber value="${pubTotals[pub.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-right text-green-600 font-medium">
                                            <fmt:formatNumber value="${pubPaids[pub.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-right text-red-600 font-medium">
                                            <fmt:formatNumber value="${pubRemainings[pub.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-center">
                                            <c:choose>
                                                <c:when test="${pubRemainings[pub.id] <= 0}">
                                                    <span class="px-2 py-1 text-xs font-semibold text-green-700 bg-green-100 rounded-full">Payé</span>
                                                </c:when>
                                                <c:when test="${pubPaids[pub.id] > 0}">
                                                    <span class="px-2 py-1 text-xs font-semibold text-yellow-700 bg-yellow-100 rounded-full">Partiel</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 py-1 text-xs font-semibold text-red-700 bg-red-100 rounded-full">En attente</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty pubs}">
                                    <tr>
                                        <td colspan="7" class="px-6 py-10 text-center text-gray-500 italic">
                                            Aucune publicité programmée pour ce vol.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </main>
    </div>
</body>
</html>
