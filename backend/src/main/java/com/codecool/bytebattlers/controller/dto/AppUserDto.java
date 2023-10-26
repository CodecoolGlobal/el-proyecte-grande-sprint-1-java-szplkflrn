package com.codecool.bytebattlers.controller.dto;

import java.io.Serializable;
import java.util.Set;
import java.util.UUID;

/**
 * DTO for {@link com.codecool.bytebattlers.model.AppUser}
 */
public record AppUserDto(UUID publicID, String name, String password, String email, Set<ReviewDto1> reviews,
                         Set<UUID> favoriteBoardGamePublicIDS) implements Serializable {
    /**
     * DTO for {@link com.codecool.bytebattlers.model.Review}
     */
    public record ReviewDto1(UUID publicID, String description) implements Serializable {
    }
}
