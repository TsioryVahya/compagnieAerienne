package com.companieaerienne.services;

import com.companieaerienne.entities.DiffusionProgrammation;
import com.companieaerienne.entities.PaymentDetailsDiffusion;
import com.companieaerienne.entities.PaymentDiffusion;
import com.companieaerienne.repositories.DiffusionProgrammationRepository;
import com.companieaerienne.repositories.PaymentDetailsDiffusionRepository;
import com.companieaerienne.repositories.PaymentDiffusionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class PaymentPubliciteService {

    @Autowired
    private PaymentDiffusionRepository paymentRepository;

    @Autowired
    private PaymentDetailsDiffusionRepository detailsRepository;

    @Autowired
    private DiffusionProgrammationRepository programmationRepository;

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
}
