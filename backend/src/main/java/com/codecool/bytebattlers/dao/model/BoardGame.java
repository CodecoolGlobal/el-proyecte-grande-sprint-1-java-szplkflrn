package com.codecool.bytebattlers.dao.model;

public record BoardGame(Integer id, String gameName, int minPlayer, int maxPlayer,
                        int playTimeInMinutes, int recommendedAge, String description,
                        double rating, Integer publisherId, Integer categoryId) {
}
