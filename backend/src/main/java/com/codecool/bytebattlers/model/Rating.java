package com.codecool.bytebattlers.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.proxy.HibernateProxy;
import org.hibernate.type.SqlTypes;

import java.util.Objects;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "rating", uniqueConstraints = {
        @UniqueConstraint(name = "uc_rating_board_game_id", columnNames = {"board_game_id", "app_user_id"})
})
public class Rating {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "public_id", unique = true, insertable = false)
    @JdbcTypeCode(SqlTypes.UUID)
    private UUID publicID = UUID.randomUUID();

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "app_user_id", nullable = false)
    private AppUser appUser;

    @ManyToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "board_game_id", nullable = false)
    private BoardGame boardGame;

    @Column(name = "rating_number", nullable = false)
    @JdbcTypeCode(SqlTypes.DOUBLE)
    private Double ratingNumber;

    @Override
    public final boolean equals(Object o) {
        if (this == o) return true;
        if (o == null) return false;
        Class<?> oEffectiveClass = o instanceof HibernateProxy ? ((HibernateProxy) o).getHibernateLazyInitializer().getPersistentClass() : o.getClass();
        Class<?> thisEffectiveClass = this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass() : this.getClass();
        if (thisEffectiveClass != oEffectiveClass) return false;
        Rating rating = (Rating) o;
        return getId() != null && Objects.equals(getId(), rating.getId());
    }

    @Override
    public final int hashCode() {
        return this instanceof HibernateProxy ? ((HibernateProxy) this).getHibernateLazyInitializer().getPersistentClass().hashCode() : getClass().hashCode();
    }
}