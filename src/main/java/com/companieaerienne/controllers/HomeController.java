package com.companieaerienne.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String index(org.springframework.ui.Model model) {
        model.addAttribute("activePage", "home");
        return "index";
    }
}
