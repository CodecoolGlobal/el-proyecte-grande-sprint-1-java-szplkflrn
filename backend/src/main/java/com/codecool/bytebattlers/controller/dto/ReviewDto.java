package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.codecool.bytebattlers.model.Review}
 */
public record ReviewDto(String description, Long boardGameId, String boardGameGameName, Long userId,
                        String userUserName) implements Serializable {
}
