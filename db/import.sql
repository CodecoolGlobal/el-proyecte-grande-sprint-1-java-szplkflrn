--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Debian 12.17-1.pgdg110+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg110+1)

-- Started on 2024-01-02 10:51:30 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--


--
-- TOC entry 3103 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 17375)
-- Name: app_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_user (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    user_name character varying(255),
    password character varying(255),
    email character varying(255),
    role character varying(255),
    CONSTRAINT app_user_role_check CHECK (((role)::text = ANY ((ARRAY['USER'::character varying, 'ADMIN'::character varying])::text[])))
);


--
-- TOC entry 215 (class 1259 OID 19332)
-- Name: app_user_favorite_board_game; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_user_favorite_board_game (
    app_user_id bigint NOT NULL,
    favorite_board_game_id bigint NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 17436)
-- Name: app_user_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.app_user_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 206 (class 1259 OID 17340)
-- Name: board_game; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.board_game (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    game_name character varying(255),
    min_player integer NOT NULL,
    max_player integer NOT NULL,
    play_time_in_minutes integer NOT NULL,
    recommended_age integer NOT NULL,
    description character varying(255),
    publisher_id bigint NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 17349)
-- Name: board_game_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.board_game_categories (
    board_game_id bigint NOT NULL,
    categories_id bigint NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 19383)
-- Name: board_game_ratings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.board_game_ratings (
    board_game_id bigint NOT NULL,
    ratings_id bigint NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 17423)
-- Name: board_game_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.board_game_reviews (
    board_game_id bigint NOT NULL,
    reviews_id bigint NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 17438)
-- Name: board_game_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.board_game_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 208 (class 1259 OID 17354)
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    name character varying(50) NOT NULL,
    description character varying(255) NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 17323)
-- Name: category_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 216 (class 1259 OID 19360)
-- Name: product_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 209 (class 1259 OID 17363)
-- Name: publisher; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publisher (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    publisher_name character varying(50) NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 17325)
-- Name: publisher_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publisher_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 217 (class 1259 OID 19362)
-- Name: rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rating (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    rating_number double precision NOT NULL,
    app_user_id bigint NOT NULL,
    board_game_id bigint NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 19371)
-- Name: rating_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rating_seq
    START WITH 286
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 210 (class 1259 OID 17369)
-- Name: review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    description character varying(255),
    board_game_id bigint NOT NULL,
    app_user_id bigint NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 17327)
-- Name: review_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.review_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 220 (class 1259 OID 19489)
-- Name: v_all_board_games; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_all_board_games AS
 SELECT bg.public_id,
    bg.game_name,
    bg.min_player,
    bg.max_player,
    bg.play_time_in_minutes,
    bg.recommended_age,
    bg.description,
    p.public_id AS publisher_public_id,
    p.publisher_name,
    string_agg(DISTINCT (c.name)::text, ', '::text) AS categories,
    COALESCE(avg(r.rating_number), (0)::double precision) AS average_rating
   FROM ((((public.board_game bg
     JOIN public.publisher p ON ((bg.publisher_id = p.id)))
     JOIN public.board_game_categories bgc ON ((bgc.board_game_id = bg.id)))
     JOIN public.category c ON ((bgc.categories_id = c.id)))
     LEFT JOIN public.rating r ON ((r.board_game_id = bg.id)))
  GROUP BY bg.public_id, bg.game_name, bg.min_player, bg.max_player, bg.play_time_in_minutes, bg.recommended_age, bg.description, p.publisher_name, p.public_id;


--
-- TOC entry 3089 (class 0 OID 17375)
-- Dependencies: 211
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (252, 'faaad4d9-d5e1-4735-acec-b32c7781f3fb', 'Master', '$2a$10$tI7gEggKyi/XXWnGIz4x9ev96MuTqN8J/GIDCIqYvbatwK.YisdRK', 'email', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (302, '2668777e-d991-45d9-83ea-aa6e7fbe696d', 'Where am I?', '$2a$10$eBm/cmJT2w3PEVnQelNW4O31KluxCOsPaPvIAnzhaBC0fuzpYK5y2', 'email@gmail.com', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (202, '182446f6-66ac-4885-90e8-7dbbfe9e28b7', 'Noob', '$2a$10$LynNaQtitFsqWKMj3wJEbeo/rbd7bjed660ar118zGXymfLRFfP0a', 'i@g', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (153, 'e815eb95-9525-47ee-9975-dd5e67ab1fa4', 'Overlord', '$2a$10$O.5nGXIKzsD2bWgMm855JeTI60k5wfl8oVMEO9aK.A7drLBSVimtW', 'iflesav@gea', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (152, '7419d226-e6ad-4356-81f9-4d83ecf6c133', 'I am the smart one', '$2a$10$tbNVuSZOqnVa8bIVQ2.YVOmFFsxu/n568cM2fBczCw6alBXYik.pC', 'ile@fjfes', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (352, '0ff9f2cd-0a40-497a-923b-ecb8371710c8', 'I am the best', '$2a$10$J8hU/Z2mJin3DvNomN6OZu3Z7ueAr6FK70ulmS2hjBuzZb.jKJGwq', 'kkfds@gma', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (353, '614d35c5-e0d7-45d9-9288-ed49b0cc65b6', 'LOL', '$2a$10$4kHxKinneBafhQUh1rc1a.8wjw9B1smAVmpq37bj5wbmoFuRjuTMu', 'ifsf@es', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (354, '9b8b7036-ecd7-48a0-8b85-7c2e8ee7e00c', 'Find me if you can', '$2a$10$LNu4sh1jRISS9wcZUbS8fO4MfCRxWUt3OM4QQQ6jp6mWuph00daQm', 'ifesafvesf@es', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (355, '90255773-41cf-461b-8819-2784754cfbf2', 'User', '$2a$10$7b97d.0UDZC0R6Gf5G6dnOcKWvWs5diei6UcS4zYcUr/Yp7y/AYZy', 'es@es', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (356, '82f70de3-578d-4221-a8ee-3d82d0ff0b0e', 'ProGamer', '$2a$10$HFnCmPQrl/9aYp6F9e1s1.7azyn3MD6N4A62SbWdlYbgirNMxBtN.', 'ffsea@Äsa', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (357, 'a87b8b58-e392-4d72-a6c6-3a1c4e87b323', 'Try me', '$2a$10$68vU.x9LxsQ85eM2LXtqZujF0F.r1vIN44NVsMLLt3MoTvKpADdiO', 'fsdf', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (358, '8090d1f8-2dd2-4dc8-8d41-a9dec1801ebf', 'me', '$2a$10$Os61lpIIw2MyO3x2u3reQ.bxYK.AVy/ZSfPLjwnq7ryfeia9JPaCG', 'me@me', 'ADMIN');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (402, '412e39bb-3658-4f7c-9527-cef9fdc13723', 'me2', '$2a$10$MJ2Wh1M7LX3pF1EqsCOF8.fnZCQa.fwaZGUT7XpEeiPxEIxVlVav.', 'me2@me2', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (452, 'b11c5a39-df35-4f17-89fe-688acbbf9361', 'me3@me3', '$2a$10$XsrAKMNvjJZMAA9.EO8ZoOKIkh7lhOG4Qf3BvSolmpJaCw.QwV2KK', 'fesf@es', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (453, '58e11e34-96e5-433d-ada4-52caf4d3d895', 'm2', '$2a$10$5sh9xAOKwUp/pjjhG.eqFe86c3TJIzRMb7gyyNFaYy49YKubf24Lu', 'm2@m2', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (502, '09877700-1845-4142-8d47-e52779a5e141', 'me3', '$2a$10$A8HPnkTBDK72UrlSHDPaVuPh3la7vjETklGI.zrGVoEmhPZxTCQxO', 'me3', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (503, 'e03c6b02-78a8-4d6f-b305-8ac9376bbe79', 'me4', '$2a$10$8.DRFrRTilDXfx1TisnH5ONLMYYCiTQMS2waGCdl3v17SRG455zGS', 'me4@me4', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (552, 'b184f7e3-0a13-4199-b203-187d47ed60ea', 'me5', '$2a$10$KTWDs2W0oC6HOQUNlV4LpeQddlcZM2btaXmmPnl1riAmJvBfmOqga', 'me5@me5', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (602, 'fd0d8871-81c3-4ce9-9d97-39561b860008', 'admin', '$2a$10$LYdjBP7CgrOH69wprPjFIub.CR9AEd9SE/CnjxDyyLvvLrYj7E2/e', 'admin@admin.com', 'USER');
INSERT INTO public.app_user (id, public_id, user_name, password, email, role) VALUES (652, '936436f2-d277-41df-b993-2703402da33f', 'pixel', '$2a$10$mxc1R4a6I4iGDO2c730wmuPfp.Ax/ymVydmzH50ApWr2liS3Tkz6C', 'pixel@email', 'USER');


--
-- TOC entry 3093 (class 0 OID 19332)
-- Dependencies: 215
-- Data for Name: app_user_favorite_board_game; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.app_user_favorite_board_game (app_user_id, favorite_board_game_id) VALUES (358, 5);
INSERT INTO public.app_user_favorite_board_game (app_user_id, favorite_board_game_id) VALUES (358, 2);
INSERT INTO public.app_user_favorite_board_game (app_user_id, favorite_board_game_id) VALUES (358, 29);
INSERT INTO public.app_user_favorite_board_game (app_user_id, favorite_board_game_id) VALUES (358, 16);


--
-- TOC entry 3084 (class 0 OID 17340)
-- Dependencies: 206
-- Data for Name: board_game; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (12, '3bbd7f1f-6468-4ded-b105-ab27795648c0', 'Gaia Project', 2, 4, 120, 10, 'Expand, research, upgrade, and settle the galaxy with one of 14 alien species.', 12);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (17, '7b68831b-80d0-4417-b693-5f0e4693508a', 'Eclipse: Second Dawn for the Galaxy', 4, 6, 90, 8, 'Build an interstellar civilization by exploration, research, conquest, and diplomacy.', 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (24, 'b230c8e5-7819-4edf-84f6-559f9ea07731', 'Terra Mystica', 4, 5, 60, 12, 'Play fantastical factions. Expand your influence by terraforming and joining cults.', 12);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (302, 'af72fc7b-b9fb-42d5-8e21-580c9216b623', 'Detective Club', 4, 8, 120, 12, 'Social deduction game', 10);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (25, '955af743-be09-4df0-9d62-6a8f1b16ac4a', 'Arkham Horror: The Card Game ', 3, 6, 90, 8, 'Investigate the horrors of Arkham while courting cosmic doom.', 1);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (16, '3bf7a53d-25ab-42a5-903c-36374d96fb6b', 'Scythe', 4, 6, 90, 8, 'Five factions vie for dominance in a war-torn, mech-filled, dieselpunk 1920s Europe.', 4);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (29, '0a671be1-9b18-4bfc-a750-c79b43f52e78', 'Great Western Trail: Second Edition', 4, 4, 120, 10, 'Wrangle your herd of cows across the Midwest prairie and deliver it to Kansas City.', 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (28, '5220f197-249c-401b-8a5d-3de0aefe1629', 'Orléans ', 4, 4, 120, 10, 'Craftsmen, scholars & monks can help you reign supreme—but who will turn up to help?', 4);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (10, '4ae33f16-90d0-487c-bc08-d7f18c297113', 'Star Wars: Rebellion', 2, 4, 120, 10, 'Strike from your hidden base as the Rebels—or find and destroy it as the Empire', 10);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (22, 'adb7df8c-783f-4244-8b0d-630c85ce5183', 'Clank! Legacy: Acquisitions Incorporated', 4, 5, 60, 12, 'Go forth, be bold, and ACQUIRE! in this campaign version of Clank!', 10);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (20, '85bef0f6-e534-42b2-80cc-ebaa1a12b007', 'Concordia ', 3, 4, 120, 10, 'Traders compete to build the greatest empire in the Roman Mediterranean.', 8);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (21, '054fda0b-81ff-4c3d-9997-f45d74a899ce', 'A Feast for Odin', 3, 4, 120, 10, 'Puzzle together the life of a Viking village as you hunt, farm, craft, and explore.', 9);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (14, '00cfd0b3-a14e-4e34-a158-63ad37de9aa2', 'Twilight Struggle ', 3, 5, 60, 12, 'Relive the Cold War and rewrite history in an epic clash between the USA and USSR.', 2);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (202, 'e0d4616d-906c-49a2-9b67-998f403ce3f5', 'Ticket To Ride', 2, 5, 120, 8, 'Fun with trains', 9);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (2, '83b17de7-9791-4c49-8848-982f0aa0c8f9', 'Pandemic Legacy: Season 1 ', 2, 4, 120, 10, 'Mutating diseases are spreading around the world - can your team save humanity?', 2);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (452, 'f29cc790-45ef-4d0d-9d34-fb049164ba89', 'Aye, Dark Overlord', 3, 12, 100, 10, 'Good', 11);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (402, '5b061dac-3f95-43d8-9939-faef0d2d3d04', 'Dixit', 3, 6, 60, 10, 'Nice game', 12);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (26, '3c89ed9b-888e-4ad6-bd3a-9253a4a4972a', 'Lost Ruins of Arnak', 3, 6, 90, 8, 'Explore an island to find resources and discover the lost ruins of Arnak.', 2);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (23, 'fd1f3131-b695-46b5-a02f-fd4b90b8c668', 'Wingspan', 4, 5, 60, 12, 'Attract a beautiful and diverse collection of birds to your wildlife preserve.', 11);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (30, '8aec0141-f215-4256-83ea-18e06e005f72', 'Everdell', 4, 4, 120, 10, 'Gather resources to develop a harmonious village of woodland critters and structures.', 6);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (19, '8b483f40-67c3-4d27-9c15-ff26ac53d297', 'Nemesis', 3, 4, 120, 10, 'Survive an alien-infested spaceship, but beware of other players and their agendas!', 7);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (18, '52cda9c2-1db1-45a8-9039-4a6d8f6bdcb8', 'Brass: Lancashire', 4, 6, 90, 8, 'Test your economic mettle as you build and network in the Industrial Revolution.', 6);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (8, 'd8b94151-cbac-4b65-bcac-cbf52ae46298', 'Gloomhaven: Jaws of the Lion', 4, 6, 90, 8, 'Vanquish monsters with strategic cardplay in a 25-scenario Gloomhaven campaign', 8);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (11, '20d37f60-b6ff-4244-a125-2d4dddbf1b38', 'Spirit Island ', 2, 4, 120, 10, 'Island Spirits join forces using elemental powers to defend their home from invaders', 11);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (9, 'ff057632-a90a-4d4d-83e3-50f04431e9d5', 'War of the Ring: Second Edition', 4, 6, 90, 8, 'The Fellowship and the Free Peoples clash with Sauron over the fate of Middle-Earth.', 9);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (15, '7d50222f-cd54-4741-ab2d-3024f62b8739', 'Great Western Trail', 3, 5, 60, 12, 'Use strategic outposts and navigate danger as you herd your cattle to Kansas City.', 3);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (13, '04e8361f-0efe-45b9-a30a-65860dd3ed71', 'Through the Ages: A New Story of Civilization', 3, 5, 60, 12, 'Rewrite history as you build up your civilization in this epic card drafting game!', 1);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (5, '00651364-3047-46a4-8c3e-a51434fa28f7', 'Twilight Imperium: Fourth Edition ', 3, 5, 60, 12, 'Build an intergalactic empire through trade, research, conquest and grand politics.', 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (3, '81ad68a0-a30f-4bca-9a02-5676d499b205', 'Gloomhaven', 2, 4, 120, 10, 'Vanquish monsters with strategic cardplay. Fulfill your quest to leave your legacy!', 3);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (152, 'c17aaf34-8079-463c-9820-583625cb9c79', 'Trash Pandas', 2, 4, 20, 10, 'Cute pandas', 11);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (252, 'e0f13c9b-0f7f-43f3-888f-b8eb6d2769ac', 'Splendor', 2, 5, 20, 10, 'Good', 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (27, 'd1ba3b23-0597-43bc-a194-95e12d482df4', 'Root ', 3, 6, 90, 8, 'Decide the fate of the forest as woodland factions fight for contrasting goals.', 3);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (6, 'dd30c754-3ea9-4b78-822c-89941787a3e3', 'Terraforming Mars', 3, 5, 60, 12, 'Compete with rival CEOs to make Mars habitable and build your corporate empire.', 6);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (7, 'b5374b9a-51da-4ac0-be15-4b38511debe5', 'Dune: Imperium', 4, 6, 90, 8, 'Influence, intrigue, and combat in the universe of Dune', 7);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (4, 'a363ed8c-f344-4012-b0b2-0eb144498e5f', 'Ark Nova ', 3, 5, 60, 12, 'Plan and build a modern, scientifically managed zoo to support conservation projects.', 4);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, publisher_id) VALUES (1, 'e79ea172-40ce-4fdc-b6d7-c5c2abb3161b', 'Brass: Birmingham', 2, 4, 120, 10, 'Build networks, grow industries, and navigate the world of the Industrial Revolution.', 1);


--
-- TOC entry 3085 (class 0 OID 17349)
-- Dependencies: 207
-- Data for Name: board_game_categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (1, 1);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (2, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (3, 3);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (4, 4);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (5, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (6, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (7, 7);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (8, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (9, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (10, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (11, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (12, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (13, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (14, 1);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (15, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (16, 3);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (17, 4);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (18, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (19, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (20, 7);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (21, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (22, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (23, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (24, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (25, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (26, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (27, 1);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (28, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (29, 3);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (30, 4);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (1, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (2, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (3, 7);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (4, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (5, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (6, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (7, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (8, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (9, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (10, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (11, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (12, 7);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (13, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (14, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (15, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (16, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (17, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (18, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (19, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (20, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (21, 7);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (22, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (23, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (24, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (25, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (26, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (27, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (28, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (29, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (30, 7);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (1, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (2, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (3, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (4, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (5, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (6, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (7, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (8, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (9, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (10, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (11, 7);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (12, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (13, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (14, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (15, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (16, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (17, 13);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (18, 6);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (19, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (20, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (21, 9);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (22, 11);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (23, 12);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (24, 8);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (25, 10);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (26, 1);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (27, 3);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (28, 4);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (29, 5);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (30, 1);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (152, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (152, 4);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (202, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (252, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (252, 3);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (302, 3);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (402, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (452, 2);
INSERT INTO public.board_game_categories (board_game_id, categories_id) VALUES (452, 3);


--
-- TOC entry 3097 (class 0 OID 19383)
-- Dependencies: 219
-- Data for Name: board_game_ratings; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3090 (class 0 OID 17423)
-- Dependencies: 212
-- Data for Name: board_game_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (1, 1);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (2, 2);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (3, 3);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (4, 4);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (5, 5);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (6, 6);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (7, 7);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (8, 8);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (9, 9);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (10, 10);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (1, 11);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (2, 12);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (3, 13);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (4, 14);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (5, 15);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (6, 16);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (7, 17);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (8, 18);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (9, 19);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (10, 20);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (1, 21);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (2, 22);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (3, 23);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (4, 24);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (5, 25);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (6, 26);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (7, 27);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (8, 28);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (9, 29);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (10, 30);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (3, 152);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (202, 202);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (202, 203);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (152, 204);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (152, 205);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (1, 252);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (1, 302);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (1, 303);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (2, 352);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (2, 402);
INSERT INTO public.board_game_reviews (board_game_id, reviews_id) VALUES (21, 452);


--
-- TOC entry 3086 (class 0 OID 17354)
-- Dependencies: 208
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.category (id, public_id, name, description) VALUES (1, '00ce4a31-fa82-4d75-aab1-5999b39f93f5', 'City Building', 'City Building games compel players to construct and manage a city in a way that is efficient  powerful  and/or lucrative.');
INSERT INTO public.category (id, public_id, name, description) VALUES (2, 'e4a884c7-5bb0-4962-92c7-0252db1152a7', 'Abstract Strategy', 'Abstract Strategy games are often (but not always): theme-less (without storyline)  built on simple and/or straightforward design and mechanics.');
INSERT INTO public.category (id, public_id, name, description) VALUES (3, '6caac651-d050-40cb-bbfb-d41c3a46f1c0', 'Ancient', 'Ancient games often have themes or storylines set in the Old World  between 3000 BC (the beginning of the Egyptian dynasties).');
INSERT INTO public.category (id, public_id, name, description) VALUES (4, 'a15cc241-337d-49a9-b965-e4576416b070', 'Bluffing', 'Bluffing games encourage players to use deception to achieve their aims. All Bluffing games have an element of hidden information in them.');
INSERT INTO public.category (id, public_id, name, description) VALUES (5, '8de070b3-87c2-4c1c-ab8b-dccf0ffbc7b7', 'Card Games', 'Card Games use cards as its sole or central component. There are stand-alone card games  in which all the cards necessary for gameplay are purchased at once.');
INSERT INTO public.category (id, public_id, name, description) VALUES (6, 'ccf4e441-4357-4419-852e-9d5d62a6d017', 'Dice Games', 'Dice games traditionally focus almost exclusively on dice rolling as a mechanic (e.g.  Yahtzee  Perudo  Can''t Stop)');
INSERT INTO public.category (id, public_id, name, description) VALUES (7, 'c91dc929-4a77-4763-8c0c-3a1bb5b38d09', 'Fantasy', 'Fantasy games are those that have themes and scenarios that exist in a fictional world. ');
INSERT INTO public.category (id, public_id, name, description) VALUES (8, 'b175d223-2b87-4145-bc4a-135d64b6a4a8', 'Murder/Mystery', 'Murder/Mystery games often involve an unsolved murder or murders. ');
INSERT INTO public.category (id, public_id, name, description) VALUES (9, 'cf189d91-2547-4b93-8733-5761b69653f5', 'Pirate', 'Pirate games often have themes or storylines of piracy. Some of the most popular themes and imagery in Pirate games concerns treasure hunting  sea robbery');
INSERT INTO public.category (id, public_id, name, description) VALUES (10, 'ac54cc39-be63-472a-8612-15ed7623e85a', 'Science Fiction', 'Science Fiction games often have themes relating to imagined possibilities in the sciences. Such games need not be futuristic; they can be based on an alternative past');
INSERT INTO public.category (id, public_id, name, description) VALUES (11, '9a258446-0748-4b72-9abc-cbcf2591fd6a', 'Economic', 'Economic games encourage players to manage a system of production  distribution  trade  and/or consumption of goods.');
INSERT INTO public.category (id, public_id, name, description) VALUES (12, 'a557dd38-59b1-40ed-8c79-a9752a4fe1d3', 'Humor', 'Humor games often have themes and gameplay that provoke laughter and amusement.');
INSERT INTO public.category (id, public_id, name, description) VALUES (13, '93ded7fe-a6c8-41d9-9889-b0f8f367e8c4', 'Maze', 'Maze games often require players to navigate a series of pathways that are located on the game board.');


--
-- TOC entry 3087 (class 0 OID 17363)
-- Dependencies: 209
-- Data for Name: publisher; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (1, 'ee7ca3ff-2579-4023-ac4b-4b027ec33ebf', '10 Traders');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (2, 'a6aa9eb1-3b41-41e8-ab79-ecb65f502e9d', '1A Games');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (3, '70c22937-4df6-4ee2-999c-a31635976325', 'Hasbro');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (4, '67ed7aad-3b62-47ae-b6da-92114cc7c013', 'Days of Wonder');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (5, 'd5aec7c4-c0cd-4ba3-86d3-933220ca12ac', 'Alderac');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (6, '511633d5-7e22-4578-b41f-5d945e9a7075', 'Games Workshop');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (7, '12f57af0-9c81-4bfc-b2dd-9cb906b994fa', 'Fantasy Flight Games');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (8, 'e98a2f5c-d904-4a68-9580-dbaa7f0a5d80', 'Asmodee');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (9, '3406a2d6-962a-4a43-8c87-8fdbe30eba5b', 'Stonemaier');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (10, '62bc9301-738d-4449-bfa3-35e4cdce7ede', 'Z-Man games');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (11, '1620dfa8-b085-4457-93cc-ed9044535428', 'Mayfair games');
INSERT INTO public.publisher (id, public_id, publisher_name) VALUES (12, '04d7add4-1218-48e7-a844-26fac1d77be9', 'C-Mon');


--
-- TOC entry 3095 (class 0 OID 19362)
-- Dependencies: 217
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (1, '1a2fcca1-e013-486c-ba05-b383f568cac4', 4, 152, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (2, '21c69452-bc05-494d-b6d0-808dedf17411', 3, 153, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (3, '04076adb-16fe-4606-a7b5-1d5eabb59ca8', 10, 202, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (4, '9a93d4cd-94f4-4b85-b159-2a371ded29a6', 7, 252, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (5, '9b052eb1-8e6b-44d8-8e15-60feb33bca3a', 8, 302, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (6, '36525836-3398-4661-9387-a2c885838c3c', 6, 352, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (7, 'a443f833-93d2-4924-a426-42b8f0dcacff', 8, 353, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (8, '2d565804-452d-4c44-8b48-16529b14b6ae', 2, 354, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (9, 'a9c531e2-395f-4ea4-bee2-8a8c5eacef4a', 3, 355, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (10, 'ebeec235-e0cd-47d2-989c-50d5f583bc41', 1, 356, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (11, '9648ab48-0180-4b5b-9108-a4051399c180', 1, 357, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (12, 'aead9353-5594-4f94-8ae1-4252fe30cb07', 0, 358, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (13, 'f031859e-1114-4cd2-b899-96fcfcf10730', 3, 402, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (14, '0465e141-2ab1-4403-9bf5-210e8a9f8be1', 10, 452, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (15, 'c57cae00-b7d6-4a9c-a479-4c4586014979', 9, 453, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (16, 'd4df5263-4ae8-4a3e-a5d6-d50bc252bcd1', 7, 502, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (17, 'd5d0da76-0a7a-4d34-990b-a22db6bab90a', 10, 503, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (18, '1b7923c3-f1f8-4797-9eaf-ae023584cbd1', 4, 552, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (19, '6f928fc8-d459-46e9-af15-f52fa35dbdc3', 3, 602, 1);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (20, '07fe1c47-d495-4341-a06f-0ab26486702e', 10, 152, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (21, '62214278-23d5-42d4-8197-c71f7bb87176', 7, 153, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (22, '0b9b5bff-359f-4791-8ad6-a900c297b0b5', 8, 202, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (23, 'd353e4b0-7ec0-477d-85cb-d9663c67a865', 6, 252, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (24, 'e5444616-99ce-448c-ae90-46d9c86cc1e1', 8, 302, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (25, '3be8e1c1-6852-4a5d-ae2f-ae9c35bf8aae', 2, 352, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (26, '77ccb6b3-503a-48ae-a28e-730a944deff4', 3, 353, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (27, 'a4c012be-e687-4a3b-a1e3-14c6ed0f8e3f', 1, 354, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (28, '1de6a221-00e6-4f86-90f9-d5a03a0aabb2', 1, 355, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (29, '35b196c9-929f-4d2d-b1ef-da7bbfcb08c7', 0, 356, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (30, 'f9b75888-2848-4726-89f3-7b4872f0ac59', 3, 357, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (31, '5faae712-9c8a-47ed-bbd3-d39cf0048326', 10, 358, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (32, '118f1b86-ef81-49f8-8366-4175f074053e', 9, 402, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (33, 'cc07c0a1-b452-46bf-b106-6d401c60ae9f', 7, 452, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (34, '71e1a1e0-3645-43c7-b977-f003497b7d5a', 10, 453, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (35, 'cad77569-86c1-4f60-80b2-5cb5190bb34d', 4, 502, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (36, 'e4ff4338-c094-4ee5-939d-0fa173751ee6', 3, 503, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (37, '79209a41-797d-48ce-97db-69fddc4cb759', 10, 552, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (38, 'ba763b6c-a30c-4f2c-b29c-aed1eb3b565d', 7, 602, 3);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (39, '1e549e6f-9a8b-4eda-ad74-71efaf374493', 8, 152, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (40, '3ba64493-4d2a-469d-a7fd-1c1434594d96', 6, 153, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (41, '86f354df-9fda-4d58-ae2d-c0de23332525', 8, 202, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (42, '71a54bc3-a0c4-4e82-ae50-9b172650ab9b', 2, 252, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (43, '2c861259-0edc-4906-9b99-da32c77bdd4d', 3, 302, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (44, '15775e31-acf3-4d5b-bc5c-a9002a4bb567', 1, 352, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (45, 'fad50b52-1e2a-4a9c-a022-396a151ba6a6', 1, 353, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (46, '14bd3980-3ab0-46b7-97dc-3ed250fdcc2f', 0, 354, 4);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (47, 'c4690453-bce0-4c42-ad24-758b4bcb2eea', 3, 355, 5);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (48, '980b4a8a-6662-4efc-9ddb-9c9774d10369', 10, 356, 5);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (49, 'd9961ee4-03e6-4879-b6f7-5fedeeb33847', 9, 357, 5);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (50, '7817315e-7408-424b-80f3-ec32dd09b860', 7, 358, 5);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (51, 'c2fd9dbc-f237-41cf-82af-d168f9267ec8', 10, 402, 5);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (52, '940f1b7f-01bd-467f-b0b5-2b371bfca6d5', 4, 452, 5);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (53, '8372f939-03a5-4e78-b3b6-922161020eb5', 3, 453, 6);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (54, '4a41f638-8913-498d-8762-f9077957ab8c', 10, 502, 6);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (55, '4344836b-9659-4512-b8d0-3b791da26551', 7, 503, 6);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (56, '9f2b34a1-7402-4c9f-9cce-6cd61011891f', 8, 552, 6);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (57, '6531d9f9-70a9-4949-b160-5a9c7a25da01', 6, 602, 6);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (58, '2a2d5d7b-a9c8-4c4d-87c5-b9f455fc0394', 8, 152, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (59, 'b426d10f-d8a5-4068-8c74-7dbe2299867a', 2, 153, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (60, '8020cc4f-2226-4956-a62b-1c35289d9399', 3, 202, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (61, '70c5c99b-94a8-4f55-9b27-791a02bbc891', 1, 252, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (62, 'd3a0ff4c-0075-4524-becd-b4fd56c6d505', 1, 302, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (63, '0d1fd393-092a-4ccc-b076-e792269afb82', 0, 352, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (64, 'd34473d3-aaaf-48db-8f38-cf08beb9653a', 3, 353, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (65, '0b7a9d87-e6fa-49ed-96f6-12f19fe52551', 10, 354, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (66, 'a0c51e35-8129-4d79-a629-0927016b8e14', 9, 355, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (67, '4b2bd6da-00c8-4778-97ee-2aecdb228215', 7, 356, 7);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (68, '5d33916c-702f-4692-8597-43ab64d233b5', 10, 357, 8);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (69, '6231ba28-b57b-4c78-b792-80fa5c476428', 4, 358, 8);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (70, 'c89e683f-1510-496e-8929-e8574926480c', 3, 402, 8);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (71, '247e88a0-bc9e-422b-8d36-743bd4b2a5b7', 10, 452, 8);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (72, 'd437cd7e-de17-465d-a17a-eaabdc4b751f', 7, 453, 8);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (73, '7637e651-6e54-430f-b101-57ef93a6314e', 8, 502, 8);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (74, '7f393cd4-fe1c-4a1f-898f-a92414b9c781', 6, 503, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (75, '0b15b8cf-1de7-4669-94db-9680e8bd4cdd', 8, 552, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (76, '56932edf-cdb2-4353-9d6b-412a881fc432', 2, 602, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (77, '89a421fb-0f19-44fb-b97d-34c5e4480f32', 3, 152, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (78, 'ff90d70e-d186-4cf7-929a-aa70cde41fc9', 1, 153, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (79, 'f6212cb4-a06e-40a9-960d-d6d6ce154374', 1, 202, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (80, '011af49a-f7da-4d4f-bfff-4bbb031dda2a', 0, 252, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (81, 'a63f582a-cb3d-4226-85cf-e4e75799c4e6', 3, 302, 9);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (82, 'ba2a9dbb-3ba9-4d72-8a8c-823b8e65c44f', 10, 352, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (83, 'b2c79406-24bc-472f-bf30-cd1c6093c33f', 9, 353, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (84, '629aa34d-d6aa-4c7d-bc60-08273d209987', 7, 354, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (85, 'e4639f44-9289-4235-b16c-7f7604462436', 10, 355, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (86, '5cab473f-8bdf-4080-8cb0-03fded74da6e', 4, 356, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (87, '5f16ef9d-27c3-4441-8fae-5fd73025de8d', 3, 357, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (88, '06554845-37e2-408a-8850-0b1500c985f3', 10, 358, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (89, '3ccfcc65-acb2-4988-82a0-8232ec18d84f', 7, 402, 10);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (90, 'b8cf5680-05c6-4d33-93f7-ebf2bf8d6311', 8, 452, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (91, '8ba6b65e-3d3a-4cf1-9cfb-d4bc6953374b', 6, 453, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (92, '3d4925e8-a90b-46a9-b8a2-542a9e3df1e5', 8, 502, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (93, 'bf9eeecd-1047-46fa-945d-d39996dd3d69', 2, 503, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (94, 'af473d1a-3db7-4e86-8822-f3b89757efbb', 3, 552, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (95, '7d594983-b83a-4706-91e6-657089d08cb9', 1, 602, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (96, 'b8872198-de91-4e8a-b140-a68dd65a1d68', 1, 152, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (97, '8028fbe4-e19f-41bc-be4f-92c5b67e5a74', 0, 153, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (98, '48fd46c8-a858-4300-b082-f80ebe821f47', 3, 202, 11);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (99, '6bffa0d3-a505-44cd-9a70-ec08d8298950', 10, 252, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (100, '054b7205-6479-453f-a9bc-8266da4ee640', 9, 302, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (101, '446a8444-9204-40c7-af3f-46cffc79edda', 7, 352, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (102, '2d50de33-7e44-46d7-806f-dabc93a1cd06', 10, 353, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (103, 'b372ee72-a07b-4d6c-af91-e20131b376e3', 4, 354, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (104, '75e3caed-211e-43f4-96c9-e754b3f1a081', 3, 355, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (105, '4bb11f35-2852-44fa-8585-57f3f42fce87', 10, 356, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (106, '027a2823-235f-40f1-a720-3d1d5ffc3f06', 7, 357, 12);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (107, 'fc775b4b-a535-4232-ae99-79d93eef91db', 8, 358, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (108, 'cc3f99f8-9cd3-4694-aa36-f4e89617a603', 6, 402, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (109, '82fd97c6-2093-4e29-85e2-a4453348c7a9', 8, 452, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (110, 'd94c629e-9883-45c7-8951-a1fd71823bb0', 2, 453, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (111, '38344666-60ec-4847-b208-5bc311849946', 3, 502, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (112, 'd3a0c543-cd03-4250-bb38-6ccbc5b8e433', 1, 503, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (113, 'a406a0db-59b4-4e83-a603-b2b2588ee879', 1, 552, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (114, '91902e68-0e0a-44ef-849e-9b909247b536', 0, 602, 13);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (115, 'ce9e6251-8776-4c9c-9bab-e9346e1bec72', 3, 152, 14);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (116, '7b79b98c-dfa6-4892-ab2f-0e42dd63286a', 10, 153, 14);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (117, '81ed9a63-327c-4b21-bd14-c595526cc274', 9, 202, 14);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (118, 'a1fd26ab-305c-422c-94c6-0b85b2b17551', 7, 252, 14);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (119, '720c1c42-a312-4c40-ba96-dbe9ebebae26', 10, 302, 14);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (120, '68099cf0-5f8c-411b-9a47-03bed7634e53', 4, 352, 14);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (121, '6b06866a-1fb4-4a86-81c3-d1eba9b8b9d1', 3, 353, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (122, '5869bd24-09b1-486e-81c3-b0ab6dc17b02', 10, 354, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (123, '7b9aff9f-5a78-4478-88a2-8be5589672a4', 7, 355, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (124, 'aad8ce34-f2c9-412f-af5c-294caefb7c84', 8, 356, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (125, '5fc379a4-0817-4f1a-be75-732b9f343f64', 6, 357, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (126, '6ca86561-dd58-4e92-a466-0ee505e94760', 8, 358, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (127, '342f3fc5-2bc5-4474-bbaa-204f56da9006', 2, 402, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (128, '80397a6c-c936-4dfc-9618-9334928f4078', 3, 452, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (129, '905481f4-326d-4a18-a43c-38efe179a076', 1, 453, 15);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (130, '8ade1afa-8741-45aa-aea5-08f7cbece504', 1, 502, 16);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (131, 'c5cd27b9-8d60-4d00-8873-4fdefd58f5a1', 0, 503, 16);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (132, '2190dc1c-dbc9-47bd-8d9d-cd2ed42eb2d2', 3, 552, 16);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (133, 'fa760c84-1cb9-42fe-a906-87918c689e82', 10, 602, 16);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (134, '2b76bf08-0b3d-4633-8ddd-3568178b92a5', 9, 152, 17);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (135, 'f6d22b5e-1e81-470b-b85d-0a6de2cc9c38', 7, 153, 17);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (136, 'abd1e94f-664a-4aac-a515-eaf4ec7ebd8a', 10, 202, 17);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (137, 'bb08994f-c69f-4067-858d-c3dd8ffdd988', 4, 252, 17);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (138, 'baadb7c7-3c20-451b-a70f-f5cf71099cf1', 3, 302, 17);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (139, '55c15e0b-eb7e-4323-bdcd-93c2a5e038be', 10, 352, 17);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (140, '778f163a-0f97-43ca-b17d-28b5c71f271c', 7, 353, 17);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (141, '63e1e323-671c-4e08-b0ee-3b710fcafe4a', 8, 354, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (142, '6922b2f7-a426-4431-8e27-203a77c349a3', 6, 355, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (143, '1366f67b-42ec-44fe-ae91-5a578f5ed115', 8, 356, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (144, '1730fdc8-e2b1-48d5-919c-ca022b0e53f2', 2, 357, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (145, '9e4365b3-10de-40a9-a9d8-df25f5df53e2', 3, 358, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (146, '7e810145-b622-4021-ba82-b818686d1851', 1, 402, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (147, 'bc8fc5e8-240a-4797-a047-dc09770c9210', 1, 452, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (148, 'f19153ac-f893-490a-8169-74d678430e88', 0, 453, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (149, 'a7788bc2-de5a-4ab9-9b80-0c691202b9ea', 3, 502, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (150, 'bfbb0ca9-66eb-4f9d-870e-442d9341b858', 10, 503, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (151, '29e832fc-6623-4dec-862d-ca574b5c3051', 9, 552, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (152, 'eac734d3-06bd-4dbf-b0a2-3b77ec73dee8', 7, 602, 18);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (153, '639a849b-6985-4133-9498-ac5bc254890a', 10, 152, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (154, 'cd4e39a5-9887-4a55-845e-213bb5f07a84', 4, 153, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (155, 'a7ba826f-46d9-4547-b961-3d46abcdb4ab', 3, 202, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (156, '692d3245-af9f-45dc-82aa-842d389e89ff', 10, 252, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (157, '0812ea1f-6f26-45bc-b453-2ade9e2559e3', 7, 302, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (158, 'd80d3edc-a7c1-4dea-9709-852a9400b7a7', 8, 352, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (159, 'de5d6ed7-7669-40ed-ac5b-520431721137', 6, 353, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (160, 'd7ea29e6-7f88-48ad-8789-0aff699b869f', 8, 354, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (161, 'a61c79d7-a151-489d-97c3-973f74ca2289', 2, 355, 19);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (162, '9b7a5db4-ea17-423e-89f4-a2576c638f40', 3, 356, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (163, '25b48a76-e9ba-4aa2-8676-356757009974', 1, 357, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (164, 'bbfa6a15-935a-4db5-8e8b-ed41481fe4fe', 1, 358, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (165, '4865c864-905f-4be2-9d58-43a064a0ff7a', 0, 402, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (166, 'feb05930-7246-40e1-9bf8-547228ec857c', 3, 452, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (167, 'cbf14b1c-3fe3-457a-b55f-bd3422a2e118', 10, 453, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (168, '9d722284-bb3a-4e67-a227-6637dc5365e4', 9, 502, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (169, '6d1aa625-755d-45db-a8c4-402c70b5f6a8', 7, 503, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (170, '134753d7-a04d-4542-9bae-2958a1fe8579', 10, 552, 20);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (171, '30c8d281-0db4-4b51-8b32-8f01de92a40c', 4, 602, 21);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (172, 'f482fe9d-e7c6-47dc-a918-1985599a7641', 3, 152, 21);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (173, 'c6c2c6a5-37ea-4c82-8ed3-a4204a323fc3', 10, 153, 21);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (174, '303cef4a-6875-4118-874f-973d11dc85f2', 7, 202, 21);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (175, '9d0e153f-5d90-4b12-a275-02e28ad647a5', 8, 252, 21);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (176, 'efbc47ad-b608-4578-97a6-ef9b1e6c45d1', 6, 302, 22);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (177, '1ed1c159-7b0c-4f3c-a821-f32a13169de4', 8, 352, 22);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (178, 'b88eb5ef-4094-4dec-acc4-6da3a556ef90', 2, 353, 22);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (179, 'eb6417e4-d0cf-46fc-ab40-b882533b2b28', 3, 354, 22);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (180, '139d1afb-279e-4b14-99d5-bb493e1fcae5', 1, 355, 22);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (181, '0399dbb7-1f25-472b-875f-c2ec9628dbcf', 1, 356, 22);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (182, '6a2ff764-7f41-4b76-885f-bdb7e734bc77', 0, 357, 22);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (183, '1016d093-7232-4fd9-992b-d6c34d06178b', 3, 358, 23);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (184, '524058d0-bb8e-49fa-8918-77c09095fcb2', 10, 402, 23);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (185, '91a19118-ec86-44e0-bd33-efc935f2f648', 9, 452, 23);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (186, 'c51bbb78-6935-43b2-af4a-857d1137301f', 7, 453, 23);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (187, '9056dfed-18e9-4227-bae5-6b508671de87', 10, 502, 23);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (188, '2e087e2e-17ac-47fc-b4c4-2fed17a365b7', 4, 503, 23);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (189, '24cc180b-c985-4f79-900f-6497ac6ac308', 3, 552, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (190, '898c8e6f-28e7-4ada-9748-5dfc1fedd515', 10, 602, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (191, '40e03a1f-c9ba-44b5-bf10-281f60d122c6', 7, 152, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (192, '06503479-28bb-4eec-9804-79524f75d4dc', 8, 153, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (193, '2a02425e-b343-43f7-a890-77dd7ace7770', 6, 202, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (194, 'f644556c-3537-4d7e-9d74-7a8d197c8f08', 8, 252, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (195, 'b4830b09-b20b-45ee-b8d9-59fb1395e486', 2, 302, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (196, 'b16ec687-8add-4d0b-9991-34b9ceced091', 3, 352, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (197, '434078ce-c7fe-4cc3-a818-41c8d21c8a79', 1, 353, 24);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (198, '317a972b-bfcc-4638-92cb-3c5de645cbed', 1, 354, 25);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (199, 'b6268516-2d48-4355-8b35-9d436a14eec3', 0, 355, 25);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (200, 'ddfdf569-7cc1-47bf-8b41-3b8b7d1f01ca', 3, 356, 25);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (201, '48770d00-f9bf-4176-be89-0f10f670ee2c', 10, 357, 25);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (202, '643354f8-cdd8-4686-8fa0-1c7f50339e70', 9, 358, 25);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (203, '59d58182-1122-4ee0-b53e-16f2876d849e', 7, 402, 26);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (204, '06f914e5-aa6e-42c4-976a-861a5a50c06d', 10, 452, 26);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (205, '8cb81274-9e8a-4167-931b-0cadc4ede1f2', 4, 453, 26);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (206, '7d2223e0-c6a5-4d5b-b6f4-1c9fdc05cb29', 3, 502, 26);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (207, '9b1ec5b3-f9ce-4844-b8a4-dd9c9365517f', 10, 503, 26);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (208, 'bce6e08d-6c87-4eff-92df-72381e34747f', 7, 552, 26);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (209, 'e35715ab-0486-48d2-9a57-4354eefebaca', 8, 602, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (210, '030b5a4d-57b3-4277-94ee-26755da3f4b1', 6, 152, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (211, '739ee22d-26f8-4c09-a996-8207087d3672', 8, 153, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (212, '5c6fe6c0-7118-4eb6-b983-c6013ad8e639', 2, 202, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (213, 'fbc042e1-87bc-46a6-bc06-3b83bfa2418b', 3, 252, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (214, 'fc00b7a9-da2a-49b0-a4ce-a4ee3118dc00', 1, 302, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (215, '7156c876-e3f3-429d-94bf-001e1a554d4d', 1, 352, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (216, 'ef209c1a-e33d-4ee5-a05d-3b622dcfb685', 0, 353, 27);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (217, 'd7e85b22-2724-44de-8e8e-53cc318b5ae4', 3, 354, 28);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (218, 'a4e31c15-63ce-46b7-944b-32b76d4de64f', 10, 355, 28);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (219, 'a890f2f0-333e-4702-8dc7-d7166df0050b', 9, 356, 28);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (220, 'ce724531-640d-40e3-8348-ac21fe88318f', 7, 357, 28);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (221, 'd0cb74b6-a6a1-46d3-9398-423d8a51dbb9', 10, 358, 28);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (222, 'cf7a076a-30b2-4e1e-8296-c34ab460dfc9', 4, 402, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (223, '4b2c39a7-1ecb-45aa-b986-0d2f95c6f2f4', 3, 452, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (224, '087e828f-bd4d-43bc-b5b1-55c3a6aaeccf', 10, 453, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (225, '3ca482c7-8f7a-4fdc-8bc6-904b4fa3ae6a', 7, 502, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (226, '407972bf-11d5-4049-926e-ede46791947a', 8, 503, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (227, '36d4d4aa-8938-4527-b44a-70d3ad32d5c6', 6, 552, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (228, '89e3c73b-87ea-4cae-96ec-ec414fb2dbda', 8, 602, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (229, '06e34c88-caaa-4a46-9da0-9d3de84bb4f6', 2, 152, 30);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (230, '3743ffd3-fb09-4cf6-8a09-24829289ca3c', 3, 153, 30);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (231, 'e648b29f-0bc3-492f-beeb-cdfe8f8c1d0b', 1, 202, 30);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (232, '0635761f-5472-427d-8ae1-4699d4bd7e02', 1, 252, 30);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (233, '0e9a3189-867d-450f-9c22-27cae3d3d462', 0, 302, 30);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (234, 'a30731a8-cb77-4bf1-85c0-7b222abfe976', 3, 352, 152);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (235, 'f0fa2861-a1f3-4078-834b-87fb8cf8b33a', 10, 353, 152);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (236, '8aad4c8b-373a-46c1-bcf8-737db692d928', 9, 354, 152);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (237, '272785d0-6842-40d9-ad54-e596306226dc', 7, 355, 152);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (238, '116caf2e-3b84-466b-a46a-98cea56309f5', 10, 356, 152);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (239, 'e838404e-a014-4ba1-9cfc-0c761a574fc3', 4, 357, 152);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (240, 'f33aa071-8c6b-44ee-8d8f-566ec62dc8fe', 3, 358, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (241, 'c1e8a80c-f794-449f-9e15-ea492feef217', 10, 402, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (242, '8a919fb3-4d49-4304-ad47-81bea9ffe270', 7, 452, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (243, 'd2416af2-1556-4399-b89b-27724f09b607', 8, 453, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (244, '905a4032-34b0-4b90-b17c-c05fde5dc74b', 6, 502, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (245, '6d0e309a-b5b2-40c3-a0f6-ce80c98448ed', 8, 503, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (246, '38c5bbd7-8321-4eff-aa34-47372adfc605', 2, 552, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (247, '1c7324c5-8a58-4c24-91e8-0b41398c46be', 3, 602, 202);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (248, 'e5d0a5b2-7483-460b-8185-5f7cb48a2892', 1, 152, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (249, '0eca2a63-8145-4039-8172-406b9718b629', 1, 153, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (250, 'ea3cbb50-994b-4301-8059-6da2d320bddb', 0, 202, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (251, 'bd11c8fa-d185-47d6-b012-184d0e82dab4', 3, 252, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (252, '835a372e-05a9-46e5-bce0-90d77877eb62', 10, 302, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (253, 'dca49c7e-43d7-4971-a752-60b05207b952', 9, 352, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (254, '40f9afaa-917f-4809-bf35-7140b6bf59d2', 7, 353, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (255, '0392b452-3aa1-4770-8823-810907b39d7a', 10, 354, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (256, 'f8080baa-3cae-4494-a99c-bc954f2100d4', 4, 355, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (257, '178681ef-eead-48a7-ac87-99de604d4770', 3, 356, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (258, 'b39f8e76-8ebd-4d88-a750-ae3045dc7fe7', 10, 357, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (259, 'da8e9806-1c72-45b3-b9be-1af79f4afae7', 7, 358, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (260, '7ef4f1e6-95b6-4e04-a8fe-cf88a975f064', 8, 402, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (261, 'ce38a582-2d6e-41ae-922e-4aa9fbbb0355', 6, 452, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (262, '550da128-6d16-41d9-b1b8-9e103c7c95b3', 8, 453, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (263, '2dc0368b-65ef-41ec-8346-d4bdffc7c950', 2, 502, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (264, 'ca28e040-a9f4-4ce8-ad4e-d05da3a8d9ff', 3, 503, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (265, '74d8ffa3-9511-425f-bd11-47fda6212d53', 1, 552, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (266, 'a672706e-a871-4363-92b2-de2408b06e76', 1, 602, 252);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (267, '8033bc24-fc2d-4f1a-9e9b-782542229475', 0, 152, 302);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (268, '964b65b6-2470-4072-a4dc-0b747c4b732e', 3, 153, 302);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (269, 'c3a5a23b-03be-41fb-8278-442a07ca6865', 10, 202, 302);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (270, '3e413bdc-08c6-4cc1-9364-b62c197f851e', 9, 252, 302);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (271, '337eddd0-83b1-4fec-83cf-cacf8120f932', 7, 302, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (272, '9e390e86-9ea3-4c6c-afc4-54ba1d8e9b9b', 10, 352, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (273, 'a37f6c64-3a6b-4780-bfcb-438bb5039ea0', 4, 353, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (274, 'b55bdda2-4d09-4244-b0f8-3926d46c4b41', 3, 354, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (275, '34f3f8a5-eb0c-40b2-a260-9cac52fe3d9f', 10, 355, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (276, '40268ab5-5cbc-4610-9337-4dba5665c057', 7, 356, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (277, '2b30dac1-2df4-42ce-b841-4c27c1284396', 8, 357, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (278, '2b3a9224-142c-4609-9db7-c85ef6aa27fa', 6, 358, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (279, '2958656d-2caa-4c52-b202-ca513c7a6f92', 8, 402, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (280, 'f071fbce-ec81-4fad-8ada-eff39696c04c', 2, 452, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (281, '8896fdd7-973c-4035-b42d-efe0adc72e82', 3, 453, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (282, '634d52bf-1ef3-41a9-aeaf-717b1b6697dc', 1, 502, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (283, '7c25b72e-2438-402d-8a60-91427169dd50', 1, 503, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (284, '515acfa0-473f-4c76-8799-b243c038ff75', 0, 552, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (285, '7b4b3ec3-deae-4824-accd-5a7c7ccad6f8', 3, 602, 402);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (288, '8c2ab5f3-8230-415b-a67b-eacad63038c9', 2, 358, 2);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (389, 'e81afb8a-8533-470b-91fd-447d6919aa5c', 4.5, 358, 21);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (390, 'f8e4d2ab-c48e-4893-ba6a-10e24d86f144', 4.5, 358, 29);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (438, 'f45ff34b-9f04-41ef-bcbb-9d66240d5baa', 5.7, 358, 16);
INSERT INTO public.rating (id, public_id, rating_number, app_user_id, board_game_id) VALUES (488, '542f7fe8-5396-43ca-8408-dc0d91208972', 6.5, 358, 14);


--
-- TOC entry 3088 (class 0 OID 17369)
-- Dependencies: 210
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (2, '5330f8e3-6129-4557-8031-09dded5f49e0', 'Horrible', 2, 302);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (13, 'b79cddcf-0f33-46bf-a781-ccd3cf48ea9b', 'Cool', 3, 202);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (24, 'b2c46d23-ec0e-4cf2-8e91-bdf074529d97', 'It takes forever ', 4, 153);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (26, 'fb9faf17-1bd3-45df-bbce-3ecf79e428c6', 'Possibily the worst game I have ever played', 6, 252);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (28, '4c80677f-d3cd-4f05-ad18-1579553b44cb', 'Don''t waste your money', 8, 202);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (27, 'd71eb42f-5bcb-4f89-8237-48c03548b379', 'Forever my favorite', 18, 302);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (3, '523b7e9a-cbfb-411e-86af-89f8d319695e', 'Meh', 7, 202);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (8, '3371886e-7ce9-495e-bd7b-dfa4d3904b52', 'Not in a million times', 29, 202);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (1, '6aff32b9-11c6-4db0-b65c-8c08825f1b5b', 'Amazing', 23, 252);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (9, '208ef5cb-4a07-454c-8f15-10c0b5e191ae', 'Pass', 5, 153);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (30, 'e66935f9-96bc-416c-99ec-c03fc71f0c50', 'CATAN is horrible', 11, 152);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (17, '03bbc4a4-193b-47fb-b7cf-e8494ad605b3', 'FIRST!', 17, 302);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (16, 'b4c540b1-8cc1-4a9b-b3ce-2f5b0a13e79e', 'Please get me out of here', 16, 252);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (15, '5596b04e-c469-4201-871e-135e274616c4', 'Like it', 6, 152);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (5, '9c894930-3e97-402a-aaa9-a053cc9a45d0', 'Nope', 27, 152);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (29, '2b0f8a31-14f0-4589-a860-6d009a619e89', 'CATAN is the best', 12, 153);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (25, 'b0e61d2d-c842-4652-bf43-bb8e4c7e10c8', 'Never again', 5, 354);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (20, 'f33faf9e-3e25-4b8f-adf4-a63b09cd623f', 'Get the trolls out of here', 2, 352);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (10, '1ddab208-fff3-45bb-9eca-235f1b9c03f2', 'Wood for sheep?', 10, 353);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (23, 'b3f88b73-8e8d-434a-b31d-6669b8e643c4', 'Played better than this', 3, 352);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (11, '280a41d3-7564-45db-9747-8d162555327c', 'Please get a better version', 1, 356);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (19, 'ec7fca83-20b3-46c0-86f5-f6b3e630d8a7', 'PONG', 9, 357);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (7, '7f31adae-3062-4b4f-870b-903252e29030', 'The BEST', 7, 352);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (22, '8b1e4c3e-fcfe-4915-af45-e1dc01532469', 'Don''t listen to the reviews', 23, 357);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (18, '4cc2dbc2-69a3-42ac-80c8-30bff2bbeb71', 'LOL', 28, 353);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (4, 'a01933db-723e-488d-9cc1-b607ea90d147', 'Probaly wasted my money', 2, 356);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (6, 'fa317b44-e89c-4db3-8b0a-20d4806a6ef9', 'Please send this to hell', 17, 354);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (14, 'a4af3781-54bd-45e2-ba72-c592f02cf319', 'BGG Recommendation', 2, 355);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (12, '80d405bd-0891-4283-812c-5ca7001d1fba', 'Yikes!', 6, 353);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (21, '35ea8bf8-4ec0-49c8-adc9-eb27a9bb5088', 'BAN Noob!', 26, 357);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (152, 'a62a7b77-3288-4285-b96e-1aaabcbfd49e', 'Not bad', 3, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (202, '1fb5843e-3591-41cd-b7e9-84c348b6adb2', 'I love it', 202, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (203, '4db0e30a-8969-48c6-b4de-edd72966a868', 'I don''t like it', 202, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (204, '5002f475-5db9-47b8-9db5-3a89d99e560c', 'I love it', 152, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (205, 'f8cf16f7-3758-4bca-9901-90adee6eb00f', 'Not good', 152, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (252, '2e1117aa-4e62-4d76-b80f-3d87fb735aea', 'This is good', 1, 402);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (302, '915fd96a-e2dd-4d4c-aeda-49f0105c3136', 'Nice', 1, 503);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (303, '731785a0-9bde-4260-a4fc-e5bd017d0562', 'Bad', 1, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (352, 'eed3ffc0-2d5d-4c1a-9268-727dda2a2a16', 'YAY!', 2, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (402, '04cf9f4e-850a-4a83-9528-91feb8145375', 'Yeah!', 2, 358);
INSERT INTO public.review (id, public_id, description, board_game_id, app_user_id) VALUES (452, 'c589d29d-7973-43fd-96f5-c048fda2c8d9', 'OK', 21, 358);


--
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 213
-- Name: app_user_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.app_user_seq', 701, true);


--
-- TOC entry 3106 (class 0 OID 0)
-- Dependencies: 214
-- Name: board_game_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.board_game_seq', 501, true);


--
-- TOC entry 3107 (class 0 OID 0)
-- Dependencies: 203
-- Name: category_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_seq', 101, true);


--
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 216
-- Name: product_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_seq', 1, false);


--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 204
-- Name: publisher_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.publisher_seq', 101, true);


--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 218
-- Name: rating_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rating_seq', 537, true);


--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 205
-- Name: review_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.review_seq', 501, true);


--
-- TOC entry 2930 (class 2606 OID 19336)
-- Name: app_user_favorite_board_game app_user_favorite_board_game_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_user_favorite_board_game
    ADD CONSTRAINT app_user_favorite_board_game_pkey PRIMARY KEY (app_user_id, favorite_board_game_id);


--
-- TOC entry 2938 (class 2606 OID 19387)
-- Name: board_game_ratings board_game_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_ratings
    ADD CONSTRAINT board_game_ratings_pkey PRIMARY KEY (board_game_id, ratings_id);


--
-- TOC entry 2926 (class 2606 OID 17427)
-- Name: board_game_reviews board_game_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT board_game_reviews_pkey PRIMARY KEY (board_game_id, reviews_id);


--
-- TOC entry 2900 (class 2606 OID 17348)
-- Name: board_game pk_board_game; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT pk_board_game PRIMARY KEY (id);


--
-- TOC entry 2904 (class 2606 OID 17353)
-- Name: board_game_categories pk_board_game_categories; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_categories
    ADD CONSTRAINT pk_board_game_categories PRIMARY KEY (board_game_id, categories_id);


--
-- TOC entry 2906 (class 2606 OID 17362)
-- Name: category pk_category; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT pk_category PRIMARY KEY (id);


--
-- TOC entry 2912 (class 2606 OID 17368)
-- Name: publisher pk_publisher; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT pk_publisher PRIMARY KEY (id);


--
-- TOC entry 2918 (class 2606 OID 17374)
-- Name: review pk_review; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT pk_review PRIMARY KEY (id);


--
-- TOC entry 2922 (class 2606 OID 17383)
-- Name: app_user pk_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT pk_user PRIMARY KEY (id);


--
-- TOC entry 2932 (class 2606 OID 19366)
-- Name: rating rating_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- TOC entry 2902 (class 2606 OID 17385)
-- Name: board_game uc_board_game_public; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT uc_board_game_public UNIQUE (public_id);


--
-- TOC entry 2908 (class 2606 OID 17387)
-- Name: category uc_category_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT uc_category_name UNIQUE (name);


--
-- TOC entry 2910 (class 2606 OID 17389)
-- Name: category uc_category_public; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT uc_category_public UNIQUE (public_id);


--
-- TOC entry 2914 (class 2606 OID 17391)
-- Name: publisher uc_publisher_public; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT uc_publisher_public UNIQUE (public_id);


--
-- TOC entry 2916 (class 2606 OID 17393)
-- Name: publisher uc_publisher_publisher_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT uc_publisher_publisher_name UNIQUE (publisher_name);


--
-- TOC entry 2934 (class 2606 OID 19368)
-- Name: rating uc_rating_board_game_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT uc_rating_board_game_id UNIQUE (board_game_id, app_user_id);


--
-- TOC entry 2920 (class 2606 OID 17395)
-- Name: review uc_review_public; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT uc_review_public UNIQUE (public_id);


--
-- TOC entry 2924 (class 2606 OID 17397)
-- Name: app_user uc_user_public; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT uc_user_public UNIQUE (public_id);


--
-- TOC entry 2928 (class 2606 OID 17435)
-- Name: board_game_reviews uk_8fsv5nv6hhpwddui0lkh7e8ou; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT uk_8fsv5nv6hhpwddui0lkh7e8ou UNIQUE (reviews_id);


--
-- TOC entry 2936 (class 2606 OID 19370)
-- Name: rating uk_ojnu8aw7733ca2c4rjy1p19q6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT uk_ojnu8aw7733ca2c4rjy1p19q6 UNIQUE (public_id);


--
-- TOC entry 2940 (class 2606 OID 19389)
-- Name: board_game_ratings uk_pvxeu0tkd01ftw5ujmux07af5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_ratings
    ADD CONSTRAINT uk_pvxeu0tkd01ftw5ujmux07af5 UNIQUE (ratings_id);


--
-- TOC entry 2950 (class 2606 OID 19378)
-- Name: rating fk49oep7axfm99p9bjbp2b0knes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT fk49oep7axfm99p9bjbp2b0knes FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2952 (class 2606 OID 19390)
-- Name: board_game_ratings fk95n107kd2xe6ljxobcxwdor0w; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_ratings
    ADD CONSTRAINT fk95n107kd2xe6ljxobcxwdor0w FOREIGN KEY (ratings_id) REFERENCES public.rating(id);


--
-- TOC entry 2942 (class 2606 OID 17413)
-- Name: board_game_categories fk_boagamcat_on_board_game; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_categories
    ADD CONSTRAINT fk_boagamcat_on_board_game FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2943 (class 2606 OID 17418)
-- Name: board_game_categories fk_boagamcat_on_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_categories
    ADD CONSTRAINT fk_boagamcat_on_category FOREIGN KEY (categories_id) REFERENCES public.category(id);


--
-- TOC entry 2941 (class 2606 OID 17398)
-- Name: board_game fk_board_game_on_publisher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT fk_board_game_on_publisher FOREIGN KEY (publisher_id) REFERENCES public.publisher(id);


--
-- TOC entry 2944 (class 2606 OID 17403)
-- Name: review fk_review_on_board_game; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_on_board_game FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2945 (class 2606 OID 17408)
-- Name: review fk_review_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_on_user FOREIGN KEY (app_user_id) REFERENCES public.app_user(id);


--
-- TOC entry 2953 (class 2606 OID 19395)
-- Name: board_game_ratings fkamo2vox3diko2m5oivuirx5nl; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_ratings
    ADD CONSTRAINT fkamo2vox3diko2m5oivuirx5nl FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2948 (class 2606 OID 19337)
-- Name: app_user_favorite_board_game fkilfbd8k8kxolpdhc943mksi5d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_user_favorite_board_game
    ADD CONSTRAINT fkilfbd8k8kxolpdhc943mksi5d FOREIGN KEY (favorite_board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2951 (class 2606 OID 19373)
-- Name: rating fkimqrkkcgiyasre1b2qjkktt5f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT fkimqrkkcgiyasre1b2qjkktt5f FOREIGN KEY (app_user_id) REFERENCES public.app_user(id);


--
-- TOC entry 2946 (class 2606 OID 17440)
-- Name: board_game_reviews fkki564u29is2kkeh03gk2l5mjv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT fkki564u29is2kkeh03gk2l5mjv FOREIGN KEY (reviews_id) REFERENCES public.review(id);


--
-- TOC entry 2947 (class 2606 OID 17445)
-- Name: board_game_reviews fkl8pn42mu2vktex77qoqdhqqn1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT fkl8pn42mu2vktex77qoqdhqqn1 FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2949 (class 2606 OID 19342)
-- Name: app_user_favorite_board_game fkpb3dfit9oyxqw9kae5dq2c3xl; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_user_favorite_board_game
    ADD CONSTRAINT fkpb3dfit9oyxqw9kae5dq2c3xl FOREIGN KEY (app_user_id) REFERENCES public.app_user(id);


--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-01-02 10:51:31 CET

--
-- PostgreSQL database dump complete
--

