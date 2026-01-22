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
                
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Programmations Publicitaires</h1>
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
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Programmations</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                    <div class="flex gap-3">
                        <a href="/publicites/create" class="bg-brand-600 text-white px-4 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium flex items-center gap-2">
                            Nouvelle Programmation
                        </a>
                    </div>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-gray-200">
                        <h3 class="text-lg font-medium text-gray-900">Liste des Programmations</h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3">ID</th>
                                    <th class="px-6 py-3">Date Vol</th>
                                    <th class="px-6 py-3">Vol</th>
                                    <th class="px-6 py-3">Diffusion (Pub)</th>
                                    <th class="px-6 py-3">Société</th>
                                    <th class="px-6 py-3 text-center">Nb Diffusions</th>
                                    <th class="px-6 py-3 text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:forEach items="${programmations}" var="p">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 font-medium text-brand-600">${p.id}</td>
                                        <td class="px-6 py-3 font-medium text-gray-900">
                                            <fmt:parseDate value="${p.dateProgrammation}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td class="px-6 py-3 text-gray-600">
                                            ${p.volProgrammation.vol.aeroportDepart.nom} → ${p.volProgrammation.vol.aeroportArrivee.nom}
                                        </td>
                                        <td class="px-6 py-3 font-medium text-gray-900">${p.diffusion.nom}</td>
                                        <td class="px-6 py-3 text-gray-600">${p.diffusion.societe.nom}</td>
                                        <td class="px-6 py-3 text-center font-medium text-gray-900">${p.nombreDiffusions}</td>
                                        <td class="px-6 py-3 flex justify-end gap-3">
                                            <a href="/publicites/payer/${p.id}" class="text-green-600 hover:text-green-800">Payer</a>
                                            <a href="/publicites/edit/${p.id}" class="text-brand-600 hover:text-brand-800">Modifier</a>
                                            <a href="/publicites/delete/${p.id}" class="text-red-600 hover:text-red-800" onclick="return confirm('Supprimer cette programmation ?')">Supprimer</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </main>
    </div>
</body>
</html>
