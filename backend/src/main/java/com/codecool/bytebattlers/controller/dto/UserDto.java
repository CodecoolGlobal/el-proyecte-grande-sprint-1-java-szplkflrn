package com.codecool.bytebattlers.controller.dto;

import com.codecool.bytebattlers.model.User;

import java.io.Serializable;

/**
 * DTO for {@link User}
 */
public record UserDto(Long id, String userName, String password, String email) implements Serializable {
}