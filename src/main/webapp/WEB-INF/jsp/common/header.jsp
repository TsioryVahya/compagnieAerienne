<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Sky ERP - Emirates Airline System</title>
    <!-- Google Fonts: Inter & Poppins -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Emirates Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/emirates-theme.css">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        display: ['Poppins', 'sans-serif'],
                    },
                    colors: {
                        brand: {
                            50: '#fef9f3',
                            100: '#fef3e6',
                            200: '#fde8cc',
                            300: '#fcd789',
                            400: '#fac847',
                            500: '#d4a944',
                            600: '#b8860b',
                            700: '#8b6308',
                            800: '#6b4a04',
                            900: '#4a3202',
                        },
                        emirates: {
                            gold: '#d4a944',
                            darkGold: '#8b6308',
                            black: '#1a1a1a',
                            darkGray: '#2d2d2d',
                            lightGray: '#f5f5f5',
                            white: '#ffffff',
                            accent: '#00a86b',
                        }
                    }
                }
            }
        }
    </script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body { 
            font-family: 'Inter', sans-serif;
            background-color: #f5f5f5;
            color: #2d2d2d;
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            color: #1a1a1a;
        }
        
        /* Emirates Theme Variables */
        :root {
            --emirates-gold: #d4a944;
            --emirates-dark-gold: #8b6308;
            --emirates-black: #1a1a1a;
            --emirates-dark-gray: #2d2d2d;
            --emirates-light-gray: #f5f5f5;
            --emirates-white: #ffffff;
            --emirates-accent: #00a86b;
        }
        
        /* Global Styling */
        a {
            transition: all 0.3s ease;
        }
        
        button, [type="button"], [type="submit"] {
            transition: all 0.2s ease;
        }
        
        /* Focus States */
        input:focus, textarea:focus, select:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(212, 169, 68, 0.1);
            border-color: var(--emirates-gold);
        }
        
        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f5f5f5;
        }
        
        ::-webkit-scrollbar-thumb {
            background: var(--emirates-gold);
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: var(--emirates-dark-gold);
        }
    </style>
</head>
