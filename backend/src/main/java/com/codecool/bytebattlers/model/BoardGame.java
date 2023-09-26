package com.codecool.bytebattlers.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "board_game")
public class BoardGame {
    @Id
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "public_id", nullable = false, unique = true)
    @JdbcTypeCode(SqlTypes.UUID)
    private UUID publicID = UUID.randomUUID();

    @Column(name = "game_name")
    private String gameName;

    @Column(name = "min_player", nullable = false)
    private int minPlayer;

    @Column(name = "max_player", nullable = false)
    private int maxPlayer;

    @Column(name = "play_time_in_minutes", nullable = false)
    private int playTimeInMinutes;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinTable(name = "board_game_categories",
            joinColumns = @JoinColumn(name = "boardGame_id"),
            inverseJoinColumns = @JoinColumn(name = "categories_id"))
    private Set<Category> categories = new LinkedHashSet<>();

    @Column(name = "recommended_age", nullable = false)
    private int recommendedAge;

    @Column(name = "description")
    private String description;

    @Column(name = "rating", nullable = false)
    private double rating;


    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "publisher_id", nullable = false)
    private Publisher publisher;

    @OneToMany(mappedBy = "boardGame", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Review> reviews = new LinkedHashSet<>();

}
