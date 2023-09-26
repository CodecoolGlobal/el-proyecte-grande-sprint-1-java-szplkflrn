package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.Set;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.Category}
 */
public record CategoryDto(UUID public_id, String name, String description, Set<BoardGameDto> boardGames) implements Serializable {
    /**
     * DTO for {@link com.codecool.bytebattlers.model.BoardGame}
     */
    public record BoardGameDto(UUID public_id, String gameName, int minPlayer, int maxPlayer, int playTimeInMinutes, int recommendedAge,
                               String description, double rating) implements Serializable {
    }
}