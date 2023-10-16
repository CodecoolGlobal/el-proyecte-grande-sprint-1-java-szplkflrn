package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    Review findByPublicID(UUID publicID);


    void deleteByPublicID(UUID publicID);
}
