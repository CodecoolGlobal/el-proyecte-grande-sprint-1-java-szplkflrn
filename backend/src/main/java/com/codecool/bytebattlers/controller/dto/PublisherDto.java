package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.Set;

/**
 * DTO for {@link com.codecool.bytebattlers.model.Publisher}
 */
public record PublisherDto(String publisherName, Set<BoardGameDto1> boardGames) implements Serializable {
    /**
     * DTO for {@link com.codecool.bytebattlers.model.BoardGame}
     */
    public record BoardGameDto1(String gameName, int minPlayer, int maxPlayer, int playTimeInMinutes,
                                int recommendedAge, String description, double rating,
                                Integer categoryId) implements Serializable {
    }
}