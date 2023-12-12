package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.Rating}
 */
public record RatingDto(UUID publicID, UUID appUserPublicID, String appUserName, UUID boardGamePublicID,
                        String boardGameGameName, Double ratingNumber) implements Serializable {
}