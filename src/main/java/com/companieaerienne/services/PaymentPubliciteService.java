package com.companieaerienne.services;

import com.companieaerienne.entities.DiffusionProgrammation;
import com.companieaerienne.entities.PaymentDetailsDiffusion;
import com.companieaerienne.entities.PaymentDiffusion;
import com.companieaerienne.repositories.DiffusionProgrammationRepository;
import com.companieaerienne.repositories.PaymentDetailsDiffusionRepository;
import com.companieaerienne.repositories.PaymentDiffusionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class PaymentPubliciteService {

    @Autowired
    private PaymentDiffusionRepository paymentRepository;

    @Autowired
    private PaymentDetailsDiffusionRepository detailsRepository;

    @Autowired
    private DiffusionProgrammationRepository programmationRepository;

    @Autowired
    @Lazy
    private PubliciteService publiciteService;

    public BigDecimal getTotalPaidForProgrammation(Integer programmationId) {
        return paymentRepository.findByDiffusionProgrammationId(programmationId)
                .map(payment -> detailsRepository.findByPaymentId(payment.getId()).stream()
                        .map(PaymentDetailsDiffusion::getMontant)
                        .reduce(BigDecimal.ZERO, BigDecimal::add))
                .orElse(BigDecimal.ZERO);
    }

    @Transactional
    public void savePayment(Integer programmationId, BigDecimal montant, LocalDateTime date) {
        DiffusionProgrammation dp = programmationRepository.findById(programmationId)
                .orElseThrow(() -> new RuntimeException("Programmation non trouvée"));

        PaymentDiffusion payment = paymentRepository.findByDiffusionProgrammationId(programmationId)
                .orElseGet(() -> {
                    PaymentDiffusion newPayment = new PaymentDiffusion();
                    newPayment.setSociete(dp.getDiffusion().getSociete());
                    newPayment.setDiffusionProgrammation(dp);
                    return paymentRepository.save(newPayment);
                });

        PaymentDetailsDiffusion details = new PaymentDetailsDiffusion();
        details.setPayment(payment);
        details.setMontant(montant);
        details.setDatePayment(date != null ? date : LocalDateTime.now());
        detailsRepository.save(details);
    }

    @Transactional
    public void savePaymentForSociete(Integer societeId, BigDecimal montantTotal, LocalDateTime date) {
        List<DiffusionProgrammation> programmations = programmationRepository.findByDiffusionSocieteId(societeId);
        if (programmations.isEmpty()) return;

        BigDecimal totalReste = programmations.stream()
                .map(dp -> publiciteService.getResteAPayer(dp))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        if (totalReste.compareTo(BigDecimal.ZERO) == 0) return;

        // Calculer le ratio de paiement sur le RESTE À PAYER
        // Si je dois 1M et je paie 500k, le ratio est 0.5
        BigDecimal ratio = montantTotal.divide(totalReste, 10, RoundingMode.HALF_UP);

        for (DiffusionProgrammation dp : programmations) {
            BigDecimal restePourCetteDiffusion = publiciteService.getResteAPayer(dp);
            
            // Si rien à payer sur cette diffusion, on passe
            if (restePourCetteDiffusion.compareTo(BigDecimal.ZERO) <= 0) continue;

            // Appliquer le ratio sur le montant restant
            BigDecimal montantAPayer = restePourCetteDiffusion.multiply(ratio).setScale(2, RoundingMode.HALF_UP);
            
            if (montantAPayer.compareTo(BigDecimal.ZERO) > 0) {
                // On s'assure de ne pas payer plus que le reste (cas d'arrondi ou surpaiement global)
                if (montantAPayer.compareTo(restePourCetteDiffusion) > 0) {
                    montantAPayer = restePourCetteDiffusion;
                }
                savePayment(dp.getId(), montantAPayer, date);
            }
        }
    }
}
