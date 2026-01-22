package com.companieaerienne.controllers;

import com.companieaerienne.entities.Societe;
import com.companieaerienne.services.SocieteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/societes")
public class SocieteController {
    @Autowired
    private SocieteService service;

    @GetMapping
    public String findAll(Model model) {
        model.addAttribute("activePage", "societes");
        model.addAttribute("societes", service.findAll());
        return "societe/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("activePage", "societes");
        model.addAttribute("societe", new Societe());
        return "societe/create";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "societes");
        model.addAttribute("societe", service.findById(id).orElseThrow());
        return "societe/create";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute Societe entity) {
        service.save(entity);
        return "redirect:/societes";
    }

    @GetMapping("/{id}/delete")
    public String deleteById(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/societes";
    }
}
