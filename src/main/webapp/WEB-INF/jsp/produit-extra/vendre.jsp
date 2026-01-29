<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-4xl">
                
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">
                        <c:choose>
                            <c:when test="${vente != null}">Modifier la Vente #${vente.id}</c:when>
                            <c:otherwise>Nouvelle Vente de Produits Extra</c:otherwise>
                        </c:choose>
                    </h1>
                    <p class="text-gray-600">Sélectionnez le client et les produits à acheter.</p>
                </div>

                <form action="${pageContext.request.contextPath}/produits-extra/ventes/${vente != null ? 'update' : 'vendre'}" method="POST" class="space-y-6">
                    <c:if test="${vente != null}">
                        <input type="hidden" name="id" value="${vente.id}">
                    </c:if>
                    
                    <!-- Sélection du Client et Date -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                            <label for="clientId" class="block text-sm font-semibold text-gray-900 mb-2">Client</label>
                            <select name="clientId" id="clientId" required 
                                    class="w-full rounded-md border-gray-300 shadow-sm focus:border-brand-500 focus:ring-brand-500">
                                <option value="">-- Sélectionner un client --</option>
                                <c:forEach items="${clients}" var="c">
                                    <option value="${c.id}" ${vente.client.id == c.id ? 'selected' : ''}>${c.nom} ${c.prenom} (${c.email})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                            <label for="dateVente" class="block text-sm font-semibold text-gray-900 mb-2">Date de la Vente</label>
                            <c:set var="formattedDate" value="${vente != null ? vente.dateVente.toString().substring(0, 16) : currentDateTime.toString().substring(0, 16)}" />
                            <input type="datetime-local" name="dateVente" id="dateVente" required
                                   value="${formattedDate}"
                                   class="w-full rounded-md border-gray-300 shadow-sm focus:border-brand-500 focus:ring-brand-500">
                        </div>
                    </div>

                    <!-- Liste des Produits -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                        <div class="px-6 py-4 border-b border-gray-200">
                            <h3 class="text-lg font-medium text-gray-900">Choix des Produits</h3>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="min-w-full text-left text-sm whitespace-nowrap">
                                <thead class="bg-gray-50 text-gray-900 font-semibold">
                                    <tr>
                                        <th class="px-6 py-3">Produit</th>
                                        <th class="px-6 py-3 text-right">Prix</th>
                                        <th class="px-6 py-3 text-center w-32">Quantité</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                    <c:forEach items="${produits}" var="p">
                                        <tr class="hover:bg-gray-50 transition-colors">
                                            <td class="px-6 py-3 text-gray-900 font-medium">${p.nom}</td>
                                            <td class="px-6 py-3 text-right text-gray-600">
                                                <fmt:formatNumber value="${prices[p.id]}" type="currency" currencySymbol="Ar" />
                                            </td>
                                            <td class="px-6 py-3 text-center">
                                                <input type="number" name="quantite_${p.id}" value="${currentQuantities[p.id] != null ? currentQuantities[p.id] : 0}" min="0" 
                                                       class="w-20 rounded-md border-gray-300 shadow-sm focus:border-brand-500 focus:ring-brand-500 text-center">
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty produits}">
                                        <tr>
                                            <td colspan="3" class="px-6 py-10 text-center text-gray-500 italic">
                                                Aucun produit disponible.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="flex justify-end gap-4">
                        <a href="${pageContext.request.contextPath}/produits-extra/ventes" 
                           class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                            Annuler
                        </a>
                        <button type="submit" 
                                class="px-4 py-2 text-sm font-medium text-white bg-brand-600 rounded-md hover:bg-brand-700 shadow-sm">
                            Valider la Vente
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
