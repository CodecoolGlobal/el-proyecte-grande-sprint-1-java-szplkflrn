CREATE SEQUENCE IF NOT EXISTS category_seq START WITH 1 INCREMENT BY 50;

CREATE SEQUENCE IF NOT EXISTS publisher_seq START WITH 1 INCREMENT BY 50;

CREATE SEQUENCE IF NOT EXISTS review_seq START WITH 1 INCREMENT BY 50;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE board_game
(
    id                   BIGINT           NOT NULL,
    public_id            UUID DEFAULT uuid_generate_v4(),
    game_name            VARCHAR(255),
    min_player           INTEGER          NOT NULL,
    max_player           INTEGER          NOT NULL,
    play_time_in_minutes INTEGER          NOT NULL,
    recommended_age      INTEGER          NOT NULL,
    description          VARCHAR(255),
    rating               DOUBLE PRECISION NOT NULL,
    publisher_id         BIGINT           NOT NULL,
    CONSTRAINT pk_board_game PRIMARY KEY (id)
);

CREATE TABLE board_game_categories
(
    board_game_id BIGINT NOT NULL,
    categories_id BIGINT NOT NULL,
    CONSTRAINT pk_board_game_categories PRIMARY KEY (board_game_id, categories_id)
);

CREATE TABLE category
(
    id          BIGINT      NOT NULL,
    public_id   UUID DEFAULT uuid_generate_v4(),
    name        VARCHAR(50) NOT NULL,
    description VARCHAR     NOT NULL,
    CONSTRAINT pk_category PRIMARY KEY (id)
);

CREATE TABLE publisher
(
    id             BIGINT      NOT NULL,
    public_id      UUID DEFAULT uuid_generate_v4(),
    publisher_name VARCHAR(50) NOT NULL,
    CONSTRAINT pk_publisher PRIMARY KEY (id)
);

CREATE TABLE review
(
    id            BIGINT NOT NULL,
    public_id     UUID DEFAULT uuid_generate_v4(),
    description   VARCHAR(255),
    board_game_id BIGINT NOT NULL,
    app_user_id       BIGINT NOT NULL,
    CONSTRAINT pk_review PRIMARY KEY (id)
);

CREATE TABLE "app_user"
(
    id        BIGINT NOT NULL,
    public_id UUID DEFAULT uuid_generate_v4(),
    user_name VARCHAR(255),
    password  VARCHAR(255),
    email     VARCHAR(255),
    CONSTRAINT pk_user PRIMARY KEY (id)
);

ALTER TABLE board_game
    ADD CONSTRAINT uc_board_game_public UNIQUE (public_id);

ALTER TABLE category
    ADD CONSTRAINT uc_category_name UNIQUE (name);

ALTER TABLE category
    ADD CONSTRAINT uc_category_public UNIQUE (public_id);

ALTER TABLE publisher
    ADD CONSTRAINT uc_publisher_public UNIQUE (public_id);

ALTER TABLE publisher
    ADD CONSTRAINT uc_publisher_publisher_name UNIQUE (publisher_name);

ALTER TABLE review
    ADD CONSTRAINT uc_review_public UNIQUE (public_id);

ALTER TABLE app_user
    ADD CONSTRAINT uc_user_public UNIQUE (public_id);

ALTER TABLE board_game
    ADD CONSTRAINT FK_BOARD_GAME_ON_PUBLISHER FOREIGN KEY (publisher_id) REFERENCES publisher (id);

ALTER TABLE review
    ADD CONSTRAINT FK_REVIEW_ON_BOARD_GAME FOREIGN KEY (board_game_id) REFERENCES board_game (id);

ALTER TABLE review
    ADD CONSTRAINT FK_REVIEW_ON_USER FOREIGN KEY (app_user_id) REFERENCES app_user (id);

ALTER TABLE board_game_categories
    ADD CONSTRAINT fk_boagamcat_on_board_game FOREIGN KEY (board_game_id) REFERENCES board_game (id);

ALTER TABLE board_game_categories
    ADD CONSTRAINT fk_boagamcat_on_category FOREIGN KEY (categories_id) REFERENCES category (id);