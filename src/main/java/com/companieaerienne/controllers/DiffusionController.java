package com.companieaerienne.controllers;

import com.companieaerienne.entities.Diffusion;
import com.companieaerienne.services.DiffusionService;
import com.companieaerienne.services.SocieteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/diffusions")
public class DiffusionController {
    @Autowired
    private DiffusionService service;
    @Autowired
    private SocieteService societeService;

    @GetMapping
    public String findAll(Model model) {
        model.addAttribute("activePage", "diffusions");
        model.addAttribute("diffusions", service.findAll());
        return "diffusion/list";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("activePage", "diffusions");
        model.addAttribute("diffusion", new Diffusion());
        model.addAttribute("societes", societeService.findAll());
        return "diffusion/create";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        model.addAttribute("activePage", "diffusions");
        model.addAttribute("diffusion", service.findById(id).orElseThrow());
        model.addAttribute("societes", societeService.findAll());
        return "diffusion/create";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute Diffusion entity) {
        service.save(entity);
        return "redirect:/diffusions";
    }

    @GetMapping("/{id}/delete")
    public String deleteById(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/diffusions";
    }
}
