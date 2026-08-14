package com.dafina.assettracker.models;

import jakarta.persistence.*;

@Entity
@Table(name = "assets")
public class Asset {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String tagNumber;

    private String status; // We will use "AVAILABLE" or "IN_USE"

    // Empty constructor required by JPA
    public Asset() {}

    // Getters and Setters (If you selected Lombok, you can just put @Data at the top of the class instead of writing these)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getTagNumber() { return tagNumber; }
    public void setTagNumber(String tagNumber) { this.tagNumber = tagNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
