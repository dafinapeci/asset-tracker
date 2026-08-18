package com.dafina.assettracker.services;
import com.dafina.assettracker.models.*;
import com.dafina.assettracker.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class CheckoutLogService {
    @Autowired
    private CheckoutLogRepository checkoutLogRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AssetRepository assetRepository;

    public CheckoutLog requestCheckout(Long userId, Long assetId) {
        // 1. Find the user and asset (or throw an error if they don't exist)
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Asset asset = assetRepository.findById(assetId)
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        // 2. Business Rule: Only allow checkout if the asset is AVAILABLE
        if (!"AVAILABLE".equals(asset.getStatus())) {
            throw new RuntimeException("This asset is currently not available.");
        }

        // 3. Create the log
        CheckoutLog log = new CheckoutLog();
        log.setUser(user);
        log.setAsset(asset);
        log.setCheckoutDate(LocalDateTime.now());
        log.setStatus("PENDING"); // Waits for Admin approval

        // 4. Update the asset status so no one else requests it
        asset.setStatus("PENDING");
        assetRepository.save(asset);

        return checkoutLogRepository.save(log);
    }

    public List<CheckoutLog> getLogsByUser(Long userId) {
        return checkoutLogRepository.findByUserId(userId);
    }
    public List<CheckoutLog> getAllCheckouts() {
        return checkoutLogRepository.findAll();
    }

    @Transactional
    public void approveCheckout(Long id) {
        // 1. Update the log
        CheckoutLog log = checkoutLogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Checkout not found"));
        log.setStatus("APPROVED");
        checkoutLogRepository.save(log);

        // 2. Update the asset so no one else can borrow it
        Asset asset = log.getAsset();
        asset.setStatus("CHECKED_OUT");
        assetRepository.save(asset); //
    }

    @Transactional
    public void rejectCheckout(Long id) {
        CheckoutLog log = checkoutLogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Checkout not found"));
        log.setStatus("REJECTED");
        checkoutLogRepository.save(log);

        // Asset goes back to available
        Asset asset = log.getAsset();
        asset.setStatus("AVAILABLE");
        assetRepository.save(asset);
    }
}
