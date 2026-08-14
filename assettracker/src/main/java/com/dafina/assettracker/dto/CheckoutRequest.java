package com.dafina.assettracker.dto;

public class CheckoutRequest {
    private Long userId;
    private Long assetId;

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public Long getAssetId() { return assetId; }
    public void setAssetId(Long assetId) { this.assetId = assetId; }
}