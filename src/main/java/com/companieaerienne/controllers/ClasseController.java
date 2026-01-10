package com.companieaerienne.controllers;

import com.companieaerienne.entities.Classe;
import com.companieaerienne.services.ClasseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/classes")
public class ClasseController {
    @Autowired
    private ClasseService service;

    @GetMapping
    public String findAll(Model model) {
        model.addAttribute("classes", service.findAll());
        return "classe/list";
    }

    @PostMapping
    public String save(@ModelAttribute Classe entity) {
        service.save(entity);
        return "redirect:/classes";
    }

    @GetMapping("/{id}")
    public String findById(@PathVariable Integer id, Model model) {
        model.addAttribute("classe", service.findById(id).orElse(null));
        return "classe/details";
    }

    @GetMapping("/{id}/delete")
    public String deleteById(@PathVariable Integer id) {
        service.deleteById(id);
        return "redirect:/classes";
    }
}
