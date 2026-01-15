<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="h-16 bg-gradient-to-r from-white to-brand-50 border-b border-brand-300 flex items-center justify-between px-6 z-20 shadow-md">
    <!-- Breadcrumbs / Search -->
    <div class="flex items-center gap-4 flex-1">
        <!-- Mobile Menu Button -->
        <button class="md:hidden p-2 text-brand-600 hover:bg-brand-100 rounded-md transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
            </svg>
        </button>

        <!-- AIRLINK Logo -->
        <div class="hidden md:flex items-center gap-2 mr-4 text-brand-700 font-bold text-xl font-display">
             <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8 text-brand-600">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 008.716-6.747M12 21a9.004 9.004 0 01-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 017.843 4.582M12 3a8.997 8.997 0 00-7.843 4.582m15.686 0A11.953 11.953 0 0112 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0121 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0112 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 013 12c0-1.605.42-3.113 1.157-4.418" />
            </svg>
            <span>AIRLINK ERP</span>
        </div>

        <!-- Search Bar -->
        <div class="relative w-full max-w-md hidden sm:block">
            <!-- <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-5 w-5 text-brand-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z" clip-rule="evenodd" />
                </svg>
            </div> -->
            <input type="text" name="search" id="search" class="block w-full pl-10 pr-3 py-2 border border-brand-200 rounded-md leading-5 bg-white placeholder-brand-400 focus:outline-none focus:placeholder-brand-500 focus:ring-2 focus:ring-brand-400 focus:border-brand-500 sm:text-sm shadow-sm" placeholder="Rechercher ">
        </div>
    </div>

    <!-- Right Actions -->
    <div class="flex items-center gap-4">
        <button class="p-2 text-brand-500 hover:text-brand-600 hover:bg-brand-100 rounded-md relative transition-colors">
            <span class="absolute top-2 right-2 h-2 w-2 rounded-full bg-red-500 border-2 border-white"></span>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0" />
            </svg>
        </button>
        <div class="h-8 w-px bg-brand-300"></div>
        <button class="text-sm font-medium text-brand-600 hover:text-brand-700 transition-colors">Aide</button>
    </div>
</header>
