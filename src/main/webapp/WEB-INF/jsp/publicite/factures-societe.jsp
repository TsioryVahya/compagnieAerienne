<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto">
                
                <div class="mb-8 flex justify-between items-center">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Factures - ${societe.nom}</h1>
                        <p class="text-gray-600">Détail des programmations et état des paiements.</p>
                    </div>
                    <a href="/publicites/factures" class="text-brand-600 hover:text-brand-800 font-medium flex items-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                        </svg>
                        Retour au choix
                    </a>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead class="bg-gray-50 text-gray-900 font-semibold border-b border-gray-100">
                                <tr>
                                    <th class="px-6 py-4">ID</th>
                                    <th class="px-6 py-4">Date & Vol</th>
                                    <th class="px-6 py-4">Diffusion</th>
                                    <th class="px-6 py-4 text-right">Montant Total</th>
                                    <th class="px-6 py-4 text-right">Déjà Payé</th>
                                    <th class="px-6 py-4 text-right">Reste à Payer</th>
                                    <th class="px-6 py-4 text-center">Statut</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach items="${programmations}" var="p">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4 font-medium text-brand-600">#${p.id}</td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm font-medium text-gray-900">
                                                <fmt:parseDate value="${p.dateProgrammation}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                                                <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                ${p.volProgrammation.vol.aeroportDepart.nom} → ${p.volProgrammation.vol.aeroportArrivee.nom}
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm font-medium text-gray-900">${p.diffusion.nom}</div>
                                            <div class="text-xs text-gray-500">${p.nombreDiffusions} diffusions</div>
                                        </td>
                                        <td class="px-6 py-4 text-right font-medium text-gray-900">
                                            <fmt:formatNumber value="${montantsTotaux[p.id]}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                        </td>
                                        <td class="px-6 py-4 text-right font-medium text-blue-600">
                                            <fmt:formatNumber value="${dejasPayes[p.id]}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                        </td>
                                        <td class="px-6 py-4 text-right font-medium ${restesAPayer[p.id] > 0 ? 'text-red-600' : 'text-green-600'}">
                                            <fmt:formatNumber value="${restesAPayer[p.id]}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <c:choose>
                                                <c:when test="${restesAPayer[p.id] <= 0}">
                                                    <span class="px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">Payé</span>
                                                </c:when>
                                                <c:when test="${dejasPayes[p.id] > 0}">
                                                    <span class="px-2 py-1 text-xs font-semibold rounded-full bg-yellow-100 text-yellow-800">Partiel</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">En attente</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="bg-gray-50 font-bold border-t-2 border-gray-100">
                                <c:set var="totalDu" value="0" />
                                <c:set var="totalPaye" value="0" />
                                <c:set var="totalReste" value="0" />
                                <c:forEach items="${programmations}" var="p">
                                    <c:set var="totalDu" value="${totalDu + montantsTotaux[p.id]}" />
                                    <c:set var="totalPaye" value="${totalPaye + dejasPayes[p.id]}" />
                                    <c:set var="totalReste" value="${totalReste + restesAPayer[p.id]}" />
                                </c:forEach>
                                <tr>
                                    <td colspan="3" class="px-6 py-4 text-right text-gray-900">TOTAUX GÉNÉRAUX</td>
                                    <td class="px-6 py-4 text-right text-gray-900">
                                        <fmt:formatNumber value="${totalDu}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                    </td>
                                    <td class="px-6 py-4 text-right text-blue-600">
                                        <fmt:formatNumber value="${totalPaye}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                    </td>
                                    <td class="px-6 py-4 text-right text-red-600">
                                        <fmt:formatNumber value="${totalReste}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                    </td>
                                    <td></td>
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
