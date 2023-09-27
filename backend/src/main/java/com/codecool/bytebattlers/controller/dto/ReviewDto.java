package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.Review}
 */
public record ReviewDto(UUID publicID, String description, UUID boardGamePublicID, String boardGameGameName,
                        int boardGameMinPlayer, int boardGameMaxPlayer, int boardGamePlayTimeInMinutes,
                        int boardGameRecommendedAge, String boardGameDescription, double boardGameRating,
                        UUID appUserPublicID, String appUserName) implements Serializable {
}