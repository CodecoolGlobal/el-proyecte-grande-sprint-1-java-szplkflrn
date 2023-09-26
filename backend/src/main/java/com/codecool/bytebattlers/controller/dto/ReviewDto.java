package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.Review}
 */
public record ReviewDto(UUID publicID, String description, UUID boardGamePublicID, String boardGameGameName,
                        UUID userPublicID, String userUserName) implements Serializable {
}