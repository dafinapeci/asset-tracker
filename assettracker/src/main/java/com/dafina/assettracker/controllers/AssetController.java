package com.dafina.assettracker.controllers;
import com.dafina.assettracker.models.*;
import com.dafina.assettracker.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
@RestController
@RequestMapping("/api/assets")
public class AssetController {
    @Autowired
    private AssetService assetService;


    // GET /api/assets (or /api/assets?status=AVAILABLE)
    @GetMapping
    public List<Asset> getAssets(@RequestParam(required = false) String status) {
        if ("AVAILABLE".equalsIgnoreCase(status)) {
            return assetService.getAvailableAssets();
        }
        return assetService.getAllAssets();
    }

    // POST /api/assets
    @PostMapping
    public Asset createAsset(@RequestBody Asset asset) {
        return assetService.addAsset(asset);
    }
}
