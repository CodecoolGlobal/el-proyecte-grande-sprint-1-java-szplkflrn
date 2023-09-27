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
@Table(name = "publisher")
public class Publisher {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "public_id", unique = true, insertable = false)
    @JdbcTypeCode(SqlTypes.UUID)
    private UUID publicID;


    @Column(name = "publisher_name", nullable = false, unique = true, length = 50)
    @JdbcTypeCode(SqlTypes.VARCHAR)
    private String publisherName;

    @OneToMany(mappedBy = "publisher", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<BoardGame> boardGames = new LinkedHashSet<>();

}