package com.dafina.assettracker.services;
import com.dafina.assettracker.models.*;
import com.dafina.assettracker.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AssetService {
    @Autowired
    private AssetRepository assetRepository;

    public List<Asset> getAllAssets() {
        return assetRepository.findAll();
    }

    public List<Asset> getAvailableAssets() {
        return assetRepository.findByStatus("AVAILABLE");
    }

    public Asset addAsset(Asset asset) {
        // Force the status to be available when a new item is added
        asset.setStatus("AVAILABLE");
        return assetRepository.save(asset);
    }
}
