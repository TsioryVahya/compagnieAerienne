<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-2xl">
                
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">Paiement Société : ${societe.nom}</h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">Accueil</a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <a href="/publicites/payer-societe" class="ml-1 text-sm font-medium text-gray-500 hover:text-brand-600 md:ml-2">Choix Société</a>
                                </div>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Paiement</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-6">
                    <h2 class="text-lg font-semibold text-gray-800 mb-4">Résumé du compte</h2>
                    <div class="grid grid-cols-2 gap-4 text-sm">
                        <div class="text-gray-500">Total dû (Toutes diffusions) :</div>
                        <div class="font-medium text-gray-900">
                            <fmt:formatNumber value="${totalDu}" type="currency" currencySymbol="Ar" />
                        </div>
                        
                        <div class="text-gray-500">Total déjà payé :</div>
                        <div class="font-medium text-brand-600">
                            <fmt:formatNumber value="${totalPaye}" type="currency" currencySymbol="Ar" />
                        </div>
                        
                        <div class="text-gray-500 font-bold border-t pt-2 mt-2">Reste à payer :</div>
                        <div class="font-bold text-red-600 border-t pt-2 mt-2">
                            <fmt:formatNumber value="${resteAPayer}" type="currency" currencySymbol="Ar" />
                        </div>
                    </div>
                    <div class="mt-4 p-3 bg-blue-50 text-blue-700 text-xs rounded-md">
                        <p>Note : Le montant saisi sera réparti proportionnellement sur toutes les diffusions de la société.</p>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                    <form action="/publicites/payer-societe/save" method="post" class="space-y-6">
                        <input type="hidden" name="societeId" value="${societe.id}">
                        
                        <div>
                            <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">Montant du versement (Ar)</label>
                            <input type="number" name="montant" id="montant" step="0.01" required
                                   value="${resteAPayer}"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent text-lg font-bold">
                        </div>

                        <div>
                            <label for="datePayment" class="block text-sm font-medium text-gray-700 mb-2">Date du paiement</label>
                            <input type="datetime-local" name="datePayment" id="datePayment"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent">
                            <p class="mt-1 text-xs text-gray-500">Laisser vide pour utiliser la date actuelle.</p>
                        </div>

                        <div class="flex gap-3 pt-4">
                            <button type="submit" class="bg-brand-600 text-white px-6 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium">
                                Enregistrer le paiement groupé
                            </button>
                            <a href="/publicites/payer-societe" class="bg-gray-100 text-gray-700 px-6 py-2 rounded-md hover:bg-gray-200 shadow-sm transition-colors text-sm font-medium">
                                Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
