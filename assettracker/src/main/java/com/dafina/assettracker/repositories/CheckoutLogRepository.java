package com.dafina.assettracker.repositories;
import com.dafina.assettracker.models.CheckoutLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CheckoutLogRepository extends JpaRepository<CheckoutLog, Long> {
    // Spring automatically writes the SQL to find all logs for a specific user ID
    List<CheckoutLog> findByUserId(Long userId);

    // Find logs by status (e.g., "PENDING") for the Admin dashboard
    List<CheckoutLog> findByStatus(String status);
}
