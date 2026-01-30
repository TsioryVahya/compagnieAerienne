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

        <a href="/vol-programmation" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "programmation".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "programmation".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5" />
            </svg>
            Programmations
        </a>

        <a href="/vol-programmation/rapport-ca-global" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "rapport-ca-global".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "rapport-ca-global".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6a7.5 7.5 0 107.5 7.5h-7.5V6z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 10.5H21A7.5 7.5 0 0013.5 3v7.5z" />
            </svg>
            Rapport CA Global
        </a>

        <a href="/vol-programmation/rapport-mensuel" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "rapport-mensuel".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "rapport-mensuel".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 3v11.25A2.25 2.25 0 006 16.5h2.25M3.75 3h-1.5m1.5 0v11.25m0 0h1.5m11.25-11.25v11.25A2.25 2.25 0 0115 16.5h-2.25m2.25-13.5h1.5m-1.5 0v11.25m0 0h-1.5M6.75 21h10.5M18 21a.75.75 0 00.75-.75V3.75a.75.75 0 00-.75-.75H6a.75.75 0 00-.75.75v16.5c0 .414.336.75.75.75h12z" />
            </svg>
            Rapport Mensuel
        </a>

        <a href="/reservations" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "reservations".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "reservations".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h3.75M9 15h3.75M9 18h3.75m3 .75H18a2.25 2.25 0 002.25-2.25V6.108c0-1.135-.845-2.098-1.976-2.192a48.424 48.424 0 00-1.123-.08m-5.801 0c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m0 0H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V9.375c0-.621-.504-1.125-1.125-1.125H8.25zM6.75 12h.008v.008H6.75V12zm0 3h.008v.008H6.75V15zm0 3h.008v.008H6.75V18z" />
            </svg>
            Réservations
        </a>

        <!-- Section: Publicité -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Publicité
        </div>

        <a href="/publicites" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "publicites".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "publicites".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.34 15.84c-.688-.06-1.386-.09-2.09-.09H7.5a4.5 4.5 0 110-9h.75c.704 0 1.402-.03 2.09-.09m0 9.18c.253.962.584 1.892.985 2.783.247.55.06 1.21-.463 1.511l-.657.38c-.551.318-1.26.117-1.527-.461a13.247 13.247 0 01-1.022-2.89m2.684-1.331l-.442 1.453m2.242-1.453a18.112 18.112 0 01.303-3.57m.495 2.14a8.055 8.055 0 011.012 3.65m0 0a3.03 3.03 0 01-.504 1.353 3 3 0 01-2.52 1.252m5.01-6.12c.163-.332.317-.67.46-1.012m.133 1.012a10.97 10.97 0 001.63-5.062c0-.181-.044-.356-.13-.523a3 3 0 00-5.37 0 10.97 10.97 0 00-1.63 5.062V11m3.36 3.012l-.442-1.453m4.56-3.773c.162.332.317.67.46 1.012m-3.967-3.146a18.117 18.117 0 01.303 3.57m-.495-2.14a8.055 8.055 0 011.012-3.65m0 0a3.03 3.03 0 01.504-1.353 3 3 0 012.52-1.252" />
            </svg>
            Programmations
        </a>

        <a href="/publicites/payer-societe" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "payer-societe".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "payer-societe".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0115.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75m0 1.5v.75m0 1.5v.75m0 1.5V15m-1.5-1.5h1.5m-1.5-1.5h1.5m-1.5-1.5h1.5m-1.5-1.5h1.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            Paiement Société
        </a>

        <a href="/publicites/factures" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "factures-societe".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "factures-societe".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
            </svg>
            Factures Société
        </a>

        <!-- Section: Services Extra -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Services Extra
        </div>

        <a href="/produits-extra" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "produits-extra".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "produits-extra".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z" />
            </svg>
            Produits Extra
        </a>

        <a href="/produits-extra/ventes" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "ventes-extra".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "ventes-extra".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.12-1.243l1.264-12A1.125 1.125 0 015.513 7.5h12.974c.576 0 1.059.435 1.119 1.007zM8.625 10.5a.375.375 0 11-.75 0 .375.375 0 01.75 0zm7.5 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
            </svg>
            Ventes Extra
        </a>

        <!-- Section: Settings -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Paramètres
        </div>

        <a href="/aeroports" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "aeroports".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "aeroports".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" />
            </svg>
            Aéroports
        </a>

        <a href="/avions" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "avions".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "avions".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5" />
            </svg>
            Avions
        </a>

        <a href="/avions/classes-places" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "classes-places".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "classes-places".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25a2.25 2.25 0 01-2.25-2.25v-2.25z" />
            </svg>
            Classes de Places
        </a>

        <a href="/statuts-vol" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "statuts-vol".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "statuts-vol".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            Statuts de Vol
        </a>

        <a href="/classes" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "classes".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "classes".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z" />
            </svg>
            Classes
        </a>

        <a href="/type-passager" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "type-passager".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "type-passager".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
            </svg>
            Types de Passager
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