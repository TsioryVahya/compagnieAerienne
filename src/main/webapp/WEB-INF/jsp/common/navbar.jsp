<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String activePage = (String) request.getAttribute("activePage"); %>
<!-- Navigation principale -->
<nav class="bg-black border-b-2 border-gold sticky top-0 z-50 shadow-lg">
    <div class="max-w-full mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <!-- Logo et Navigation principale -->
            <div class="flex">
                <!-- Logo -->
                <div class="flex-shrink-0 flex items-center">
                    <a href="/" class="flex items-center gap-2 font-bold text-xl text-gold hover:text-gold-300 transition-colors">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-8 h-8">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 12L3.269 3.126A59.768 59.768 0 0121.485 12 59.77 59.77 0 013.27 20.876L5.999 12zm0 0h7.5" />
                        </svg>
                        <span class="hidden sm:inline">AirLine</span>
                    </a>
                </div>
                
                <!-- Menu Desktop -->
                <div class="hidden lg:ml-8 lg:flex lg:space-x-1">
                    <a href="/" class="<%= "home".equals(activePage) ? "bg-black-lighter text-gold border-b-2 border-gold" : "text-gray-300 hover:bg-black-lighter hover:text-gold" %> px-3 py-2 text-sm font-semibold transition-all flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
                        </svg>
                        Accueil
                    </a>
                    
                    <!-- Menu Vols -->
                    <div class="relative group">
                        <button class="<%= "vols".equals(activePage) || "programmation".equals(activePage) ? "bg-black-lighter text-gold" : "text-gray-300 hover:bg-black-lighter hover:text-gold" %> px-3 py-2 text-sm font-semibold transition-all flex items-center gap-1">
                            Vols
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/></svg>
                        </button>
                        <div class="absolute left-0 mt-0 w-56 rounded-md shadow-lg bg-black-light border border-gold-900 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                            <div class="py-1">
                                <a href="/vols" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">📋 Liste des vols</a>
                                <a href="/vol-programmation" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">📅 Programmations</a>
                                <a href="/vol-programmation/rapport-ca-global" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">📊 Rapport CA</a>
                                <a href="/reservations" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">🎫 Réservations</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Menu Publicité -->
                    <div class="relative group">
                        <button class="text-gray-300 hover:bg-black-lighter hover:text-gold px-3 py-2 text-sm font-semibold transition-all flex items-center gap-1">
                            Publicité
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/></svg>
                        </button>
                        <div class="absolute left-0 mt-0 w-56 rounded-md shadow-lg bg-black-light border border-gold-900 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                            <div class="py-1">
                                <a href="/publicite/societes" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">🏢 Sociétés</a>
                                <a href="/publicite/videos" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">🎬 Vidéos</a>
                                <a href="/publicite/diffusions" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">📡 Diffusions</a>
                                <a href="/publicite/tarifs" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">💰 Tarifs</a>
                                <a href="/paiements-publicite" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">💳 Paiements</a>
                                <a href="/publicite/rapports" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">📈 Rapports</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Menu Paramètres -->
                    <div class="relative group">
                        <button class="text-gray-300 hover:bg-black-lighter hover:text-gold px-3 py-2 text-sm font-semibold transition-all flex items-center gap-1">
                            Paramètres
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/></svg>
                        </button>
                        <div class="absolute left-0 mt-0 w-56 rounded-md shadow-lg bg-black-light border border-gold-900 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                            <div class="py-1">
                                <a href="/aeroports" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">✈️ Aéroports</a>
                                <a href="/avions" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">🛩️ Avions</a>
                                <a href="/avions/classes-places" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">💺 Classes</a>
                                <a href="/statuts-vol" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">📌 Statuts Vol</a>
                                <a href="/type-passager" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">👥 Types Passager</a>
                                <a href="/pilotes" class="block px-4 py-2 text-sm text-gray-300 hover:bg-black-lighter hover:text-gold transition-colors">👨‍✈️ Pilotes</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Barre de recherche et actions -->
            <div class="hidden md:flex items-center gap-4">
                <div class="relative">
                    <input type="text" placeholder="Rechercher..." class="bg-black-light text-gray-300 border border-gold-900 rounded-lg px-4 py-2 pl-10 focus:outline-none focus:border-gold text-sm w-64">
                    <svg class="absolute left-3 top-2.5 h-5 w-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                
                <button class="relative p-2 text-gray-300 hover:text-gold transition-colors">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/></svg>
                    <span class="absolute top-1 right-1 w-2 h-2 bg-gold rounded-full"></span>
                </button>
                
                <div class="h-8 w-px bg-gold-900"></div>
                
                <div class="flex items-center gap-3">
                    <div class="text-right hidden xl:block">
                        <div class="text-sm font-semibold text-gold">Admin</div>
                        <div class="text-xs text-gray-400">Administrateur</div>
                    </div>
                    <div class="w-10 h-10 bg-gradient-to-br from-gold to-gold-700 rounded-full flex items-center justify-center text-black font-bold text-sm">
                        A
                    </div>
                </div>
            </div>

            <!-- Bouton menu mobile -->
            <div class="flex items-center lg:hidden">
                <button onclick="toggleMobileMenu()" class="text-gray-300 hover:text-gold p-2">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                    </svg>
                </button>
            </div>
        </div>
    </div>

    <!-- Menu Mobile -->
    <div id="mobileMenu" class="hidden lg:hidden bg-black-light border-t border-gold-900">
        <div class="px-2 pt-2 pb-3 space-y-1">
            <a href="/" class="block px-3 py-2 rounded-md text-base font-semibold text-gray-300 hover:text-gold hover:bg-black-lighter">🏠 Accueil</a>
            
            <div class="px-3 py-2 text-xs font-semibold text-gold uppercase tracking-wider">Vols</div>
            <a href="/vols" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">📋 Liste des vols</a>
            <a href="/vol-programmation" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">📅 Programmations</a>
            <a href="/vol-programmation/rapport-ca-global" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">📊 Rapport CA</a>
            <a href="/reservations" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">🎫 Réservations</a>
            
            <div class="px-3 py-2 text-xs font-semibold text-gold uppercase tracking-wider mt-2">Publicité</div>
            <a href="/publicite/societes" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">🏢 Sociétés</a>
            <a href="/publicite/videos" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">🎬 Vidéos</a>
            <a href="/publicite/diffusions" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">📡 Diffusions</a>
            <a href="/publicite/tarifs" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">💰 Tarifs</a>
            <a href="/paiements-publicite" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">💳 Paiements</a>
            <a href="/publicite/rapports" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">📈 Rapports</a>
            
            <div class="px-3 py-2 text-xs font-semibold text-gold uppercase tracking-wider mt-2">Paramètres</div>
            <a href="/aeroports" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">✈️ Aéroports</a>
            <a href="/avions" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">🛩️ Avions</a>
            <a href="/avions/classes-places" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">💺 Classes</a>
            <a href="/statuts-vol" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">📌 Statuts Vol</a>
            <a href="/type-passager" class="block px-6 py-2 rounded-md text-sm text-gray-300 hover:text-gold hover:bg-black-lighter">👥 Types Passager</a>
        </div>
    </div>
</nav>

<script>
    function toggleMobileMenu() {
        const menu = document.getElementById('mobileMenu');
        menu.classList.toggle('hidden');
    }
</script>
