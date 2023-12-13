package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.VAllBoardGame}
 */
public record VAllBoardGameDto(UUID publicId, String gameName, Integer minPlayer, Integer maxPlayer,
                               Integer playTimeInMinutes, Integer recommendedAge, String description,
                               UUID publisherPublicId, String publisherName, String categories,
                               Double averageRating) implements Serializable {
}