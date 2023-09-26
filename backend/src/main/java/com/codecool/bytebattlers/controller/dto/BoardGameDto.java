package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.codecool.bytebattlers.model.BoardGame}
 */
public record BoardGameDto(String gameName, int minPlayer, int maxPlayer, int playTimeInMinutes, int recommendedAge,
                           String description, double rating, Integer publisherId,
                           Integer categoryId) implements Serializable {
}