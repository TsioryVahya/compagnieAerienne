<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <!-- Main Content Wrapper -->
    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <!-- Top Navbar -->
        <jsp:include page="../common/navbar.jsp" />

        <!-- Main Page Content -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                
                <!-- Page Header with Breadcrumb -->
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Chiffre d'Affaires Publicités</h1>
                        <!-- Breadcrumb -->
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center">
                                    <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">
                                        <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path></svg>
                                        Accueil
                                    </a>
                                </li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Rapport CA Publicités</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <!-- Filters -->
                <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 mb-6">
                    <form action="/publicites/rapport-ca" method="get" class="flex flex-wrap items-end gap-4">
                        <div class="flex-1 min-w-[150px]">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Mois</label>
                            <select name="month" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-brand-500 focus:border-brand-500 block p-2.5">
                                <option value="" ${empty selectedMonth ? 'selected' : ''}>Tous les mois</option>
                                <option value="1" ${selectedMonth == 1 ? 'selected' : ''}>Janvier</option>
                                <option value="2" ${selectedMonth == 2 ? 'selected' : ''}>Février</option>
                                <option value="3" ${selectedMonth == 3 ? 'selected' : ''}>Mars</option>
                                <option value="4" ${selectedMonth == 4 ? 'selected' : ''}>Avril</option>
                                <option value="5" ${selectedMonth == 5 ? 'selected' : ''}>Mai</option>
                                <option value="6" ${selectedMonth == 6 ? 'selected' : ''}>Juin</option>
                                <option value="7" ${selectedMonth == 7 ? 'selected' : ''}>Juillet</option>
                                <option value="8" ${selectedMonth == 8 ? 'selected' : ''}>Août</option>
                                <option value="9" ${selectedMonth == 9 ? 'selected' : ''}>Septembre</option>
                                <option value="10" ${selectedMonth == 10 ? 'selected' : ''}>Octobre</option>
                                <option value="11" ${selectedMonth == 11 ? 'selected' : ''}>Novembre</option>
                                <option value="12" ${selectedMonth == 12 ? 'selected' : ''}>Décembre</option>
                            </select>
                        </div>
                        <div class="flex-1 min-w-[150px]">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Année</label>
                            <input type="number" name="year" value="${selectedYear}" class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-brand-500 focus:border-brand-500 block p-2.5" />
                        </div>
                        <button type="submit" class="bg-brand-600 text-white px-6 py-2.5 rounded-lg hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium">
                            Filtrer
                        </button>
                    </form>
                </div>

                <!-- Report Content -->
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-gray-200 flex justify-between items-center">
                        <h3 class="text-lg font-medium text-gray-900">
                            Récapitulatif - <c:choose>
                                <c:when test="${empty selectedMonth && empty selectedYear}">Tous les temps</c:when>
                                <c:when test="${empty selectedMonth}">${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 1}">Janvier ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 2}">Février ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 3}">Mars ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 4}">Avril ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 5}">Mai ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 6}">Juin ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 7}">Juillet ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 8}">Août ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 9}">Septembre ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 10}">Octobre ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 11}">Novembre ${selectedYear}</c:when>
                                <c:when test="${selectedMonth == 12}">Décembre ${selectedYear}</c:when>
                            </c:choose>
                        </h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold">
                                <tr>
                                    <th class="px-6 py-3">Société</th>
                                    <th class="px-6 py-3 text-center">Nombre de Diffusions</th>
                                    <th class="px-6 py-3 text-right">Montant Total (Ar)</th>
                                    <th class="px-6 py-3 text-right">Payé (Ar)</th>
                                    <th class="px-6 py-3 text-right">Reste à Payer (Ar)</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 border-t border-gray-100">
                                <c:forEach items="${amounts}" var="entry">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4 font-medium text-gray-900">${entry.key}</td>
                                        <td class="px-6 py-4 text-center text-gray-600">${counts[entry.key]}</td>
                                        <td class="px-6 py-4 text-right font-semibold text-gray-900">
                                            <fmt:formatNumber value="${entry.value}" type="number" groupingUsed="true" /> Ar
                                        </td>
                                        <td class="px-6 py-4 text-right text-green-600 font-medium">
                                            <fmt:formatNumber value="${paidAmounts[entry.key]}" type="number" groupingUsed="true" /> Ar
                                        </td>
                                        <td class="px-6 py-4 text-right font-bold ${entry.value - paidAmounts[entry.key] > 0 ? 'text-red-600' : 'text-brand-600'}">
                                            <fmt:formatNumber value="${entry.value - paidAmounts[entry.key]}" type="number" groupingUsed="true" /> Ar
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty amounts}">
                                    <tr>
                                        <td colspan="5" class="px-6 py-10 text-center text-gray-500">
                                            Aucune diffusion enregistrée pour cette période.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                            <tfoot class="bg-gray-50 font-bold text-gray-900 border-t-2 border-gray-200">
                                <tr>
                                    <td class="px-6 py-4">TOTAL GÉNÉRAL</td>
                                    <td class="px-6 py-4 text-center"></td>
                                    <td class="px-6 py-4 text-right text-lg">
                                        <fmt:formatNumber value="${totalCA}" type="number" groupingUsed="true" /> Ar
                                    </td>
                                    <td class="px-6 py-4 text-right text-lg text-green-700">
                                        <fmt:formatNumber value="${totalPaid}" type="number" groupingUsed="true" /> Ar
                                    </td>
                                    <td class="px-6 py-4 text-right text-lg text-brand-700">
                                        <fmt:formatNumber value="${totalCA - totalPaid}" type="number" groupingUsed="true" /> Ar
                                    </td>
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
