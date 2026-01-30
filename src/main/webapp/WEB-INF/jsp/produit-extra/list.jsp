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
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Catalogue des Produits Extra</h1>
                        <p class="text-gray-600">Gérez les produits disponibles à la vente aux clients.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/produits-extra/create" 
                       class="inline-flex items-center px-4 py-2 bg-brand-600 text-white rounded-md hover:bg-brand-700 transition-colors font-medium shadow-sm">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                        Ajouter un Produit
                    </a>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3 w-20">ID</th>
                                    <th class="px-6 py-3">Nom du Produit</th>
                                    <th class="px-6 py-3 text-right">Prix Actuel</th>
                                    <th class="px-6 py-3 text-center w-40">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:forEach items="${produits}" var="p">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-500">#${p.id}</td>
                                        <td class="px-6 py-3 text-gray-900 font-medium">${p.nom}</td>
                                        <td class="px-6 py-3 text-right font-bold text-brand-600">
                                            <fmt:formatNumber value="${prices[p.id]}" type="currency" currencySymbol="Ar" />
                                        </td>
                                        <td class="px-6 py-3 text-center">
                                            <div class="flex items-center justify-center gap-3">
                                                <a href="${pageContext.request.contextPath}/produits-extra/edit/${p.id}" 
                                                   class="text-blue-600 hover:text-blue-800 font-medium transition-colors">
                                                    Modifier
                                                </a>
                                                <span class="text-gray-300">|</span>
                                                <a href="${pageContext.request.contextPath}/produits-extra/delete/${p.id}" 
                                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce produit ?')"
                                                   class="text-red-600 hover:text-red-800 font-medium transition-colors">
                                                    Supprimer
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty produits}">
                                    <tr>
                                        <td colspan="3" class="px-6 py-10 text-center text-gray-500 italic">
                                            Aucun produit extra configuré.
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
