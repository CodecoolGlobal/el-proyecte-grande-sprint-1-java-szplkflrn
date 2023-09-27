package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface PublisherRepository extends JpaRepository<Publisher, Long> {
    Publisher findPublisherByPublicID(UUID publicId);
}