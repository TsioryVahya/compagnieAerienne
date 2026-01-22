package com.companieaerienne.repositories;

import com.companieaerienne.entities.PaymentDetailsDiffusion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PaymentDetailsDiffusionRepository extends JpaRepository<PaymentDetailsDiffusion, Integer> {
    List<PaymentDetailsDiffusion> findByPaymentId(Integer paymentId);
}
