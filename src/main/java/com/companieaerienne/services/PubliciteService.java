package com.companieaerienne.services;

import com.companieaerienne.entities.DiffusionProgrammation;
import com.companieaerienne.entities.TarifPub;
import com.companieaerienne.repositories.DiffusionProgrammationRepository;
import com.companieaerienne.repositories.TarifPubRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class PubliciteService {

    @Autowired
    private DiffusionProgrammationRepository programmationRepository;

    @Autowired
    private TarifPubRepository tarifRepository;

    @Autowired
    private PaymentPubliciteService paymentService;

    public List<DiffusionProgrammation> findAll() {
        return programmationRepository.findAll();
    }

    public java.util.Optional<DiffusionProgrammation> findById(Integer id) {
        return programmationRepository.findById(id);
    }

    public DiffusionProgrammation save(DiffusionProgrammation entity) {
        return programmationRepository.save(entity);
    }

    public void deleteById(Integer id) {
        programmationRepository.deleteById(id);
    }

    public List<DiffusionProgrammation> getProgrammations(Integer year, Integer month) {
        if (year == null && month == null) {
            return programmationRepository.findAll();
        }
        
        LocalDate start;
        LocalDate end;
        
        if (year != null && month != null) {
            YearMonth yearMonth = YearMonth.of(year, month);
            start = yearMonth.atDay(1);
            end = yearMonth.atEndOfMonth();
        } else if (year != null) {
            start = LocalDate.of(year, 1, 1);
            end = LocalDate.of(year, 12, 31);
        } else {
            // Seul le mois est fourni (peu probable avec l'UI actuelle, mais gérons-le)
            int currentYear = LocalDate.now().getYear();
            YearMonth yearMonth = YearMonth.of(currentYear, month);
            start = yearMonth.atDay(1);
            end = yearMonth.atEndOfMonth();
        }
        
        return programmationRepository.findByPeriod(start, end);
    }

    private BigDecimal getMontantForProgrammation(DiffusionProgrammation dp) {
        return tarifRepository.findLatestTarifForDate(dp.getDateProgrammation())
                .map(TarifPub::getMontant)
                .orElse(BigDecimal.ZERO)
                .multiply(BigDecimal.valueOf(dp.getNombreDiffusions()));
    }

    public BigDecimal calculateTotalCA(Integer year, Integer month) {
        List<DiffusionProgrammation> programmations = getProgrammations(year, month);
        return programmations.stream()
                .map(this::getMontantForProgrammation)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public Map<String, Long> getDiffusionCountBySociete(Integer year, Integer month) {
        List<DiffusionProgrammation> programmations = getProgrammations(year, month);
        return programmations.stream()
                .collect(Collectors.groupingBy(
                        dp -> dp.getDiffusion().getSociete().getNom(),
                        Collectors.summingLong(dp -> dp.getNombreDiffusions().longValue())
                ));
    }

    public Map<String, BigDecimal> getCABySociete(Integer year, Integer month) {
        List<DiffusionProgrammation> programmations = getProgrammations(year, month);
        return programmations.stream()
                .collect(Collectors.groupingBy(
                        dp -> dp.getDiffusion().getSociete().getNom(),
                        Collectors.mapping(this::getMontantForProgrammation, Collectors.reducing(BigDecimal.ZERO, BigDecimal::add))
                ));
    }

    public Map<String, BigDecimal> getPaidBySociete(Integer year, Integer month) {
        List<DiffusionProgrammation> programmations = getProgrammations(year, month);
        return programmations.stream()
                .collect(Collectors.groupingBy(
                        dp -> dp.getDiffusion().getSociete().getNom(),
                        Collectors.mapping(dp -> paymentService.getTotalPaidForProgrammation(dp.getId()), Collectors.reducing(BigDecimal.ZERO, BigDecimal::add))
                ));
    }
}
