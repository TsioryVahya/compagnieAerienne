<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="w-64 bg-gray-50 border-r border-gray-200 hidden md:flex flex-col h-screen fixed inset-y-0 left-0 z-10">
    <!-- Logo Area -->
    <div class="h-16 flex items-center px-6 border-b border-gray-200 bg-white">
        <div class="flex items-center gap-2 font-semibold text-gray-800 text-lg">
            <div class="w-8 h-8 bg-brand-600 rounded-md flex items-center justify-center text-white">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 13.5l10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75z" />
                </svg>
            </div>
            <span>E-Sky ERP</span>
        </div>
    </div>

    <!-- Scrollable Navigation -->
    <nav class="flex-1 overflow-y-auto py-4 px-3 space-y-1">
        <!-- Section: Core -->
        <div class="px-3 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Tableau de Bord
        </div>
        <% String activePage = (String) request.getAttribute("activePage"); %>
        
        <a href="/" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "home".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "home".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z" />
            </svg>
            Accueil
        </a>

        <!-- Section: Operations -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Opérations
        </div>
        
        <a href="/vols" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "vols".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "vols".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5" />
            </svg>
            Vols
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 text-sm font-medium text-gray-600 rounded-md hover:bg-gray-100 hover:text-gray-900 group">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-gray-400 group-hover:text-gray-500">
                <path stroke-linecap="round" stroke-linejoin="round" d="M11.42 15.17L17.25 21A2.652 2.652 0 0021 17.25l-5.877-5.877M11.425 15.17V8.625c0-1.78-1.442-3.223-3.223-3.223h3.224m0 0h.01m-6.845 0a3.224 3.224 0 00-3.222 3.223v6.52" />
            </svg>
            Maintenance
        </a>
    </nav>
    
    <!-- User Footer -->
    <div class="border-t border-gray-200 p-4">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-gray-200 flex items-center justify-center text-gray-500 font-bold">
                A
            </div>
            <div class="flex-1 min-w-0">
                <p class="text-sm font-medium text-gray-900 truncate">Admin User</p>
                <p class="text-xs text-gray-500 truncate">admin@esky.com</p>
            </div>
        </div>
    </div>
</aside>
