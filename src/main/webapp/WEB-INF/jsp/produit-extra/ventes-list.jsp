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
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Historique des Ventes Extra</h1>
                        <p class="text-gray-600">Suivi des achats de produits supplémentaires par les clients.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/produits-extra/vendre" 
                       class="inline-flex items-center px-4 py-2 bg-brand-600 text-white rounded-md hover:bg-brand-700 transition-colors font-medium">
                        Nouvelle Vente
                    </a>
                </div>

                <div class="space-y-6">
                    <c:forEach items="${ventes}" var="v">
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                            <div class="px-6 py-4 bg-gray-50 border-b border-gray-200 flex justify-between items-center">
                                <div class="flex items-center gap-4">
                                    <span class="text-sm font-semibold text-gray-900">Vente #${v.id}</span>
                                    <span class="text-gray-300">|</span>
                                    <span class="text-sm text-gray-600">Client: ${v.client.nom} ${v.client.prenom}</span>
                                    <span class="text-gray-300">|</span>
                                    <div class="flex items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/produits-extra/ventes/edit/${v.id}" 
                                           class="text-xs font-medium text-blue-600 hover:text-blue-800 transition-colors">
                                            Modifier
                                        </a>
                                        <span class="text-gray-300 text-xs">/</span>
                                        <a href="${pageContext.request.contextPath}/produits-extra/ventes/delete/${v.id}" 
                                           onclick="return confirm('Supprimer cette vente ?')"
                                           class="text-xs font-medium text-red-600 hover:text-red-800 transition-colors">
                                            Supprimer
                                        </a>
                                    </div>
                                </div>
                                <span class="text-sm text-gray-500">
                                    <fmt:parseDate value="${v.dateVente}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                </span>
                            </div>
                            <div class="overflow-x-auto">
                                <table class="min-w-full text-left text-sm whitespace-nowrap">
                                    <thead class="bg-white text-gray-500 font-medium uppercase tracking-wider">
                                        <tr>
                                            <th class="px-6 py-3">Produit</th>
                                            <th class="px-6 py-3 text-center">Quantité</th>
                                            <th class="px-6 py-3 text-right">Prix Unitaire</th>
                                            <th class="px-6 py-3 text-right">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100">
                                        <c:set var="totalVente" value="0" />
                                        <c:forEach items="${v.details}" var="d">
                                            <c:set var="totalLigne" value="${d.quantite * d.prixUnitaire}" />
                                            <c:set var="totalVente" value="${totalVente + totalLigne}" />
                                            <tr>
                                                <td class="px-6 py-3 text-gray-900">${d.produitExtra.nom}</td>
                                                <td class="px-6 py-3 text-center text-gray-600">${d.quantite}</td>
                                                <td class="px-6 py-3 text-right text-gray-600">
                                                    <fmt:formatNumber value="${d.prixUnitaire}" type="currency" currencySymbol="Ar" />
                                                </td>
                                                <td class="px-6 py-3 text-right font-medium text-gray-900">
                                                    <fmt:formatNumber value="${totalLigne}" type="currency" currencySymbol="Ar" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot class="bg-gray-50 font-bold">
                                        <tr>
                                            <td colspan="3" class="px-6 py-3 text-right text-gray-900 uppercase">Total Vente :</td>
                                            <td class="px-6 py-3 text-right text-brand-600">
                                                <fmt:formatNumber value="${totalVente}" type="currency" currencySymbol="Ar" />
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty ventes}">
                        <div class="bg-white p-10 text-center rounded-lg border-2 border-dashed border-gray-200">
                            <p class="text-gray-500 italic">Aucune vente enregistrée pour le moment.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
