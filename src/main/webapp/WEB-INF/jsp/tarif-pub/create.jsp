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
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${tarif.id != null ? 'Modifier' : 'Nouveau'} Tarif</h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">Accueil</a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <a href="/tarifs-pub" class="ml-1 text-sm font-medium text-gray-500 hover:text-brand-600 md:ml-2">Tarifs Pub</a>
                                </div>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Détails</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                    <form action="/tarifs-pub/save" method="post" class="space-y-6">
                        <input type="hidden" name="id" value="${tarif.id}">
                        
                        <div>
                            <label for="dateApplication" class="block text-sm font-medium text-gray-700 mb-2">Date d'Application</label>
                            <input type="date" name="dateApplication" id="dateApplication" value="${tarif.dateApplication}" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent">
                        </div>

                        <div>
                            <label for="montant" class="block text-sm font-medium text-gray-700 mb-2">Montant (Ar)</label>
                            <input type="number" step="0.01" name="montant" id="montant" value="${tarif.montant}" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent">
                        </div>

                        <div class="flex gap-3 pt-4">
                            <button type="submit" class="bg-brand-600 text-white px-6 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium">
                                Enregistrer
                            </button>
                            <a href="/tarifs-pub" class="bg-gray-100 text-gray-700 px-6 py-2 rounded-md hover:bg-gray-200 shadow-sm transition-colors text-sm font-medium">
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
