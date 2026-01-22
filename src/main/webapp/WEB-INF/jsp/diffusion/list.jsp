<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                <!-- Page Header -->
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Catalogue des Diffusions</h1>
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
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Diffusions</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                    <div class="flex gap-3">
                        <a href="/diffusions/create" class="bg-brand-600 text-white px-4 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium flex items-center gap-2">
                            Nouvelle Diffusion
                        </a>
                    </div>
                </div>

                <!-- List Table -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-gray-200">
                        <h3 class="text-lg font-medium text-gray-900">Liste des Diffusions</h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider">ID</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider">Nom</th>
                                    <th class="px-6 py-3 text-left text-xs font-semibold text-gray-500 uppercase tracking-wider">Société</th>
                                    <th class="px-6 py-3 text-right text-xs font-semibold text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:forEach items="${diffusions}" var="d">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">#${d.id}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${d.nom}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${d.societe.nom}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium space-x-3">
                                            <a href="/diffusions/edit/${d.id}" class="text-brand-600 hover:text-brand-900">Modifier</a>
                                            <a href="/diffusions/${d.id}/delete" class="text-red-600 hover:text-red-900" onclick="return confirm('Supprimer cette diffusion ?')">Supprimer</a>
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
