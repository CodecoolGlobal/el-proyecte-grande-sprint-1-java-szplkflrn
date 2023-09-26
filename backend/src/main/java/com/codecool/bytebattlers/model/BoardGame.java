package com.codecool.bytebattlers.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

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

    @Column(name = "category_id")
    private Integer categoryId;

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "publisher_id", nullable = false)
    private Publisher publisher;

    @OneToMany(mappedBy = "boardGame", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Review> reviews = new LinkedHashSet<>();

}
