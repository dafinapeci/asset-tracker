package com.dafina.assettracker.repositories;
import com.dafina.assettracker.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface UserRepository extends JpaRepository<User, Long>{
}
