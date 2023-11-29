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
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "public_id", unique = true, insertable = false)
    @JdbcTypeCode(SqlTypes.UUID)
    private UUID publicID;

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
            joinColumns = @JoinColumn(name = "board_game_id"),
            inverseJoinColumns = @JoinColumn(name = "categories_id"))
    private Set<Category> categories = new LinkedHashSet<>();

    @Column(name = "recommended_age", nullable = false)
    private int recommendedAge;

    @Column(name = "description")
    private String description;

    @Column(name = "rating", nullable = false)
    private double rating;

    @Column(name = "rating_count")
    @JdbcTypeCode(SqlTypes.INTEGER)
    private Integer ratingCount;

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "publisher_id", nullable = false)
    private Publisher publisher;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Review> reviews = new LinkedHashSet<>();

    @ManyToMany(mappedBy = "favoriteBoardGames", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    private Set<AppUser> usersWhoFavorited = new LinkedHashSet<>();

}
