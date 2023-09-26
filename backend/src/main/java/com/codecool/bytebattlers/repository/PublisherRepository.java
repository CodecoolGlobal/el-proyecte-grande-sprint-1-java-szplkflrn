package com.codecool.bytebattlers.repository;

import com.codecool.bytebattlers.model.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PublisherRepository extends JpaRepository<Publisher, Long> {
}