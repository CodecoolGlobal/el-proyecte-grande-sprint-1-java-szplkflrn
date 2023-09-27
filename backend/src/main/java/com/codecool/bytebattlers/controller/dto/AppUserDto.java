package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.Set;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.AppUser}
 */
public record AppUserDto(UUID publicID, String name, Set<ReviewDto> reviews) implements Serializable {
    /**
     * DTO for {@link com.codecool.bytebattlers.model.Review}
     */
    public record ReviewDto(UUID publicID, String description) implements Serializable {
    }
}