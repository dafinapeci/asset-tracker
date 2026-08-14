package com.dafina.assettracker.controllers;
import com.dafina.assettracker.dto.CheckoutRequest;
import com.dafina.assettracker.models.*;
import com.dafina.assettracker.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/checkouts")
@CrossOrigin(origins = "*")
public class CheckoutLogController {

    @Autowired
    private CheckoutLogService checkoutLogService;

    @PostMapping
    public CheckoutLog createRequest(@RequestBody CheckoutRequest request) {
        return checkoutLogService.requestCheckout(request.getUserId(), request.getAssetId());
    }

    @GetMapping("/user/{userId}")
    public List<CheckoutLog> getUserCheckouts(@PathVariable Long userId) {
        return checkoutLogService.getLogsByUser(userId);
    }
}