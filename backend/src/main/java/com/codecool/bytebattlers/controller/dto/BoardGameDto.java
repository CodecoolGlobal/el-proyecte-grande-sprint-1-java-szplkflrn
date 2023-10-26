package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.Set;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.BoardGame}
 */
public record BoardGameDto(UUID publicID, String gameName, int minPlayer, int maxPlayer, int playTimeInMinutes,
                           Set<CategoryDto1> categories, int recommendedAge, String description, double rating,
                           UUID publisherPublicID, String publisherPublisherName, Set<ReviewDto1> reviews,
                           Set<UUID> appUserPublicIDS) implements Serializable {
    /**
     * DTO for {@link com.codecool.bytebattlers.model.Category}
     */
    public record CategoryDto1(UUID publicID, String name, String description) implements Serializable {
    }

    /**
     * DTO for {@link com.codecool.bytebattlers.model.Review}
     */
    public record ReviewDto1(UUID publicID, String description) implements Serializable {
    }
}
