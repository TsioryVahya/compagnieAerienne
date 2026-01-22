package com.companieaerienne.controllers;

import com.companieaerienne.entities.TarifPub;
import com.companieaerienne.services.TarifPubService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tarifs-pub")
public class TarifPubController {
    @Autowired
    private TarifPubService service;

    @GetMapping
    public String findAll(Model model) {
        model.addAttribute("activePage", "tarifs-pub");
        model.addAttribute("tarifs", service.findAll());
        return "tarif-pub/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("activePage", "tarifs-pub");
        model.addAttribute("tarif", new TarifPub());
        return "tarif-pub/create";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "tarifs-pub");
        model.addAttribute("tarif", service.findById(id).orElseThrow());
        return "tarif-pub/create";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute TarifPub entity) {
        service.save(entity);
        return "redirect:/tarifs-pub";
    }

    @GetMapping("/{id}/delete")
    public String deleteById(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/tarifs-pub";
    }
}
