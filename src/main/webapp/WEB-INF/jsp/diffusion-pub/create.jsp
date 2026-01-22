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
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">${programmation.id != null ? 'Modifier' : 'Nouvelle'} Programmation</h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">Accueil</a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <a href="/publicites" class="ml-1 text-sm font-medium text-gray-500 hover:text-brand-600 md:ml-2">Programmations</a>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                    <form action="/publicites/save" method="post" class="space-y-6">
                        <input type="hidden" name="id" value="${programmation.id}">
                        
                        <div>
                            <label for="volProgrammation" class="block text-sm font-medium text-gray-700 mb-2">Vol Programmé</label>
                            <select name="volProgrammation.id" id="volProgrammation" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent">
                                <option value="">Sélectionner un vol</option>
                                <c:forEach items="${vols}" var="v">
                                    <option value="${v.id}" ${programmation.volProgrammation.id == v.id ? 'selected' : ''}>
                                        <fmt:parseDate value="${v.dateHeure}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                        <fmt:formatDate value="${parsedDateTime}" pattern="dd/MM/yyyy HH:mm" /> : 
                                        ${v.vol.aeroportDepart.nom} → ${v.vol.aeroportArrivee.nom} (${v.avion.matricule})
                                    </option>
                                </c:forEach>
                            </select>
                            <p class="mt-1 text-xs text-gray-500">La date de programmation sera automatiquement définie sur la date du vol.</p>
                        </div>

                        <div>
                            <label for="diffusion" class="block text-sm font-medium text-gray-700 mb-2">Diffusion (Pub)</label>
                            <select name="diffusion.id" id="diffusion" required
                                    class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent">
                                <option value="">Sélectionner une pub</option>
                                <c:forEach items="${diffusions}" var="d">
                                    <option value="${d.id}" ${programmation.diffusion.id == d.id ? 'selected' : ''}>${d.nom} (${d.societe.nom})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label for="nombreDiffusions" class="block text-sm font-medium text-gray-700 mb-2">Nombre de Diffusions</label>
                            <input type="number" name="nombreDiffusions" id="nombreDiffusions" value="${programmation.nombreDiffusions}" min="1" required
                                   class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-transparent">
                        </div>

                        <div class="flex gap-3 pt-4">
                            <button type="submit" class="bg-brand-600 text-white px-6 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium">
                                Enregistrer
                            </button>
                            <a href="/publicites" class="bg-gray-100 text-gray-700 px-6 py-2 rounded-md hover:bg-gray-200 shadow-sm transition-colors text-sm font-medium">
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
