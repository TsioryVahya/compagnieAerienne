<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-2xl">
                
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">
                        <c:choose>
                            <c:when test="${produit.id != null}">Modifier le Produit</c:when>
                            <c:otherwise>Nouveau Produit Extra</c:otherwise>
                        </c:choose>
                    </h1>
                    <p class="text-gray-600">Configurez les informations du produit et son prix de vente.</p>
                </div>

                <div class="bg-white p-8 rounded-lg shadow-sm border border-gray-200">
                    <form action="${pageContext.request.contextPath}/produits-extra/save" method="POST" class="space-y-6">
                        <input type="hidden" name="id" value="${produit.id}">
                        
                        <div>
                            <label for="nom" class="block text-sm font-semibold text-gray-900 mb-2">Nom du Produit</label>
                            <input type="text" name="nom" id="nom" value="${produit.nom}" required placeholder="Ex: Eau minérale 50cl"
                                   class="w-full rounded-md border-gray-300 shadow-sm focus:border-brand-500 focus:ring-brand-500">
                        </div>

                        <div>
                            <label for="prix" class="block text-sm font-semibold text-gray-900 mb-2">Prix de Vente (Ar)</label>
                            <input type="number" step="0.01" name="prix" id="prix" value="${currentPrice != null ? currentPrice : ''}" required placeholder="0.00"
                                   class="w-full rounded-md border-gray-300 shadow-sm focus:border-brand-500 focus:ring-brand-500">
                            <c:if test="${produit.id != null}">
                                <p class="mt-2 text-xs text-gray-500 italic">La modification du prix créera un nouvel historique de tarif.</p>
                            </c:if>
                        </div>

                        <div class="pt-4 flex items-center justify-end gap-4 border-t border-gray-100">
                            <a href="${pageContext.request.contextPath}/produits-extra" 
                               class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 transition-colors">
                                Annuler
                            </a>
                            <button type="submit" 
                                    class="px-4 py-2 text-sm font-medium text-white bg-brand-600 rounded-md hover:bg-brand-700 shadow-sm transition-colors">
                                <c:choose>
                                    <c:when test="${produit.id != null}">Mettre à jour</c:when>
                                    <c:otherwise>Enregistrer le produit</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </main>
    </div>
</body>
</html>
