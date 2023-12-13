package com.codecool.bytebattlers.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Immutable;

import java.util.UUID;

/**
 * Mapping for DB view
 */
@Getter
@Setter
@Entity
@Immutable
@Table(name = "v_all_board_games")
public class VAllBoardGame {
    @Id
    @Column(name = "public_id")
    private UUID publicId;

    @Column(name = "game_name")
    private String gameName;

    @Column(name = "min_player")
    private Integer minPlayer;

    @Column(name = "max_player")
    private Integer maxPlayer;

    @Column(name = "play_time_in_minutes")
    private Integer playTimeInMinutes;

    @Column(name = "recommended_age")
    private Integer recommendedAge;

    @Column(name = "description")
    private String description;

    @Column(name = "publisher_public_id")
    private UUID publisherPublicId;

    @Column(name = "publisher_name", length = 50)
    private String publisherName;

    @Column(name = "categories", length = Integer.MAX_VALUE)
    private String categories;

    @Column(name = "average_rating")
    private Double averageRating;

}