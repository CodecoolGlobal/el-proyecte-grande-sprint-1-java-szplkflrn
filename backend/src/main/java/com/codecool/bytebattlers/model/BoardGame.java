package com.codecool.bytebattlers.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "board_game")
public class BoardGame {
    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "game_name")
    private String gameName;

    @Column(name = "min_player", nullable = false)
    private int minPlayer;

    @Column(name = "max_player", nullable = false)
    private int maxPlayer;

    @Column(name = "play_time_in_minutes", nullable = false)
    private int playTimeInMinutes;

    @Column(name = "recommended_age", nullable = false)
    private int recommendedAge;

    @Column(name = "description")
    private String description;

    @Column(name = "rating", nullable = false)
    private double rating;

    @Column(name = "publisher_id")
    private Integer publisherId;

    @Column(name = "category_id")
    private Integer categoryId;

}