package com.dafina.assettracker.repositories;

import com.dafina.assettracker.models.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

public interface AssetRepository extends JpaRepository<Asset, Long>{ //
    List<Asset> findByStatus(String status);
}
