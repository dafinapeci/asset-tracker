package com.dafina.assettracker.models;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "checkout_logs")
public class CheckoutLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // This creates a foreign key column called 'user_id'
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // This creates a foreign key column called 'asset_id'
    @ManyToOne
    @JoinColumn(name = "asset_id", nullable = false)
    private Asset asset;

    private LocalDateTime checkoutDate;

    private LocalDateTime returnDate;

    private String status; // "PENDING", "APPROVED", "RETURNED", "REJECTED"

    // Empty constructor required by JPA
    public CheckoutLog() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Asset getAsset() { return asset; }
    public void setAsset(Asset asset) { this.asset = asset; }

    public LocalDateTime getCheckoutDate() { return checkoutDate; }
    public void setCheckoutDate(LocalDateTime checkoutDate) { this.checkoutDate = checkoutDate; }

    public LocalDateTime getReturnDate() { return returnDate; }
    public void setReturnDate(LocalDateTime returnDate) { this.returnDate = returnDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
