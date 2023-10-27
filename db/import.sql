--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Debian 12.16-1.pgdg110+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg110+1)

-- Started on 2023-10-26 15:32:14 CEST

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 17329)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 17375)
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.app_user OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 19332)
-- Name: app_user_favorite_board_game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user_favorite_board_game (
    app_user_id bigint NOT NULL,
    favorite_board_game_id bigint NOT NULL
);


ALTER TABLE public.app_user_favorite_board_game OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17436)
-- Name: app_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_user_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.app_user_seq OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 17340)
-- Name: board_game; Type: TABLE; Schema: public; Owner: postgres
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
    rating double precision NOT NULL,
    publisher_id bigint NOT NULL
);


ALTER TABLE public.board_game OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 17349)
-- Name: board_game_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.board_game_categories (
    board_game_id bigint NOT NULL,
    categories_id bigint NOT NULL
);


ALTER TABLE public.board_game_categories OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17423)
-- Name: board_game_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.board_game_reviews (
    board_game_id bigint NOT NULL,
    reviews_id bigint NOT NULL
);


ALTER TABLE public.board_game_reviews OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17438)
-- Name: board_game_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.board_game_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.board_game_seq OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17354)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    name character varying(50) NOT NULL,
    description character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17323)
-- Name: category_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_seq OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17363)
-- Name: publisher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publisher (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    publisher_name character varying(50) NOT NULL
);


ALTER TABLE public.publisher OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17325)
-- Name: publisher_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publisher_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publisher_seq OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17369)
-- Name: review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.review (
    id bigint NOT NULL,
    public_id uuid DEFAULT public.uuid_generate_v4(),
    description character varying(255),
    board_game_id bigint NOT NULL,
    app_user_id bigint NOT NULL
);


ALTER TABLE public.review OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17327)
-- Name: review_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.review_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_seq OWNER TO postgres;

--
-- TOC entry 3057 (class 0 OID 17375)
-- Dependencies: 211
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
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


--
-- TOC entry 3061 (class 0 OID 19332)
-- Dependencies: 215
-- Data for Name: app_user_favorite_board_game; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3052 (class 0 OID 17340)
-- Dependencies: 206
-- Data for Name: board_game; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (1, 'e79ea172-40ce-4fdc-b6d7-c5c2abb3161b', 'Brass: Birmingham', 2, 4, 120, 10, 'Build networks, grow industries, and navigate the world of the Industrial Revolution.', 7.3, 1);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (2, '83b17de7-9791-4c49-8848-982f0aa0c8f9', 'Pandemic Legacy: Season 1 ', 2, 4, 120, 10, 'Mutating diseases are spreading around the world - can your team save humanity?', 7.1, 2);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (3, '81ad68a0-a30f-4bca-9a02-5676d499b205', 'Gloomhaven', 2, 4, 120, 10, 'Vanquish monsters with strategic cardplay. Fulfill your quest to leave your legacy!', 7.2, 3);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (4, 'a363ed8c-f344-4012-b0b2-0eb144498e5f', 'Ark Nova ', 3, 5, 60, 12, 'Plan and build a modern, scientifically managed zoo to support conservation projects.', 8.1, 4);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (5, '00651364-3047-46a4-8c3e-a51434fa28f7', 'Twilight Imperium: Fourth Edition ', 3, 5, 60, 12, 'Build an intergalactic empire through trade, research, conquest and grand politics.', 8.5, 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (6, 'dd30c754-3ea9-4b78-822c-89941787a3e3', 'Terraforming Mars', 3, 5, 60, 12, 'Compete with rival CEOs to make Mars habitable and build your corporate empire.', 8.6, 6);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (7, 'b5374b9a-51da-4ac0-be15-4b38511debe5', 'Dune: Imperium', 4, 6, 90, 8, 'Influence, intrigue, and combat in the universe of Dune', 9.1, 7);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (8, 'd8b94151-cbac-4b65-bcac-cbf52ae46298', 'Gloomhaven: Jaws of the Lion', 4, 6, 90, 8, 'Vanquish monsters with strategic cardplay in a 25-scenario Gloomhaven campaign', 9.2, 8);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (9, 'ff057632-a90a-4d4d-83e3-50f04431e9d5', 'War of the Ring: Second Edition', 4, 6, 90, 8, 'The Fellowship and the Free Peoples clash with Sauron over the fate of Middle-Earth.', 9.2, 9);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (10, '4ae33f16-90d0-487c-bc08-d7f18c297113', 'Star Wars: Rebellion', 2, 4, 120, 10, 'Strike from your hidden base as the Rebels—or find and destroy it as the Empire', 6.1, 10);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (11, '20d37f60-b6ff-4244-a125-2d4dddbf1b38', 'Spirit Island ', 2, 4, 120, 10, 'Island Spirits join forces using elemental powers to defend their home from invaders', 6.2, 11);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (12, '3bbd7f1f-6468-4ded-b105-ab27795648c0', 'Gaia Project', 2, 4, 120, 10, 'Expand, research, upgrade, and settle the galaxy with one of 14 alien species.', 4.3, 12);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (13, '04e8361f-0efe-45b9-a30a-65860dd3ed71', 'Through the Ages: A New Story of Civilization', 3, 5, 60, 12, 'Rewrite history as you build up your civilization in this epic card drafting game!', 7.3, 1);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (14, '00cfd0b3-a14e-4e34-a158-63ad37de9aa2', 'Twilight Struggle ', 3, 5, 60, 12, 'Relive the Cold War and rewrite history in an epic clash between the USA and USSR.', 7.1, 2);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (15, '7d50222f-cd54-4741-ab2d-3024f62b8739', 'Great Western Trail', 3, 5, 60, 12, 'Use strategic outposts and navigate danger as you herd your cattle to Kansas City.', 7.2, 3);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (16, '3bf7a53d-25ab-42a5-903c-36374d96fb6b', 'Scythe', 4, 6, 90, 8, 'Five factions vie for dominance in a war-torn, mech-filled, dieselpunk 1920s Europe.', 8.1, 4);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (17, '7b68831b-80d0-4417-b693-5f0e4693508a', 'Eclipse: Second Dawn for the Galaxy', 4, 6, 90, 8, 'Build an interstellar civilization by exploration, research, conquest, and diplomacy.', 8.5, 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (18, '52cda9c2-1db1-45a8-9039-4a6d8f6bdcb8', 'Brass: Lancashire', 4, 6, 90, 8, 'Test your economic mettle as you build and network in the Industrial Revolution.', 8.6, 6);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (19, '8b483f40-67c3-4d27-9c15-ff26ac53d297', 'Nemesis', 3, 4, 120, 10, 'Survive an alien-infested spaceship, but beware of other players and their agendas!', 9.1, 7);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (20, '85bef0f6-e534-42b2-80cc-ebaa1a12b007', 'Concordia ', 3, 4, 120, 10, 'Traders compete to build the greatest empire in the Roman Mediterranean.', 9.2, 8);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (21, '054fda0b-81ff-4c3d-9997-f45d74a899ce', 'A Feast for Odin', 3, 4, 120, 10, 'Puzzle together the life of a Viking village as you hunt, farm, craft, and explore.', 9.2, 9);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (22, 'adb7df8c-783f-4244-8b0d-630c85ce5183', 'Clank! Legacy: Acquisitions Incorporated', 4, 5, 60, 12, 'Go forth, be bold, and ACQUIRE! in this campaign version of Clank!', 6.1, 10);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (23, 'fd1f3131-b695-46b5-a02f-fd4b90b8c668', 'Wingspan', 4, 5, 60, 12, 'Attract a beautiful and diverse collection of birds to your wildlife preserve.', 6.2, 11);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (24, 'b230c8e5-7819-4edf-84f6-559f9ea07731', 'Terra Mystica', 4, 5, 60, 12, 'Play fantastical factions. Expand your influence by terraforming and joining cults.', 4.3, 12);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (25, '955af743-be09-4df0-9d62-6a8f1b16ac4a', 'Arkham Horror: The Card Game ', 3, 6, 90, 8, 'Investigate the horrors of Arkham while courting cosmic doom.', 7.3, 1);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (26, '3c89ed9b-888e-4ad6-bd3a-9253a4a4972a', 'Lost Ruins of Arnak', 3, 6, 90, 8, 'Explore an island to find resources and discover the lost ruins of Arnak.', 7.1, 2);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (27, 'd1ba3b23-0597-43bc-a194-95e12d482df4', 'Root ', 3, 6, 90, 8, 'Decide the fate of the forest as woodland factions fight for contrasting goals.', 7.2, 3);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (28, '5220f197-249c-401b-8a5d-3de0aefe1629', 'Orléans ', 4, 4, 120, 10, 'Craftsmen, scholars & monks can help you reign supreme—but who will turn up to help?', 8.1, 4);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (29, '0a671be1-9b18-4bfc-a750-c79b43f52e78', 'Great Western Trail: Second Edition', 4, 4, 120, 10, 'Wrangle your herd of cows across the Midwest prairie and deliver it to Kansas City.', 8.5, 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (30, '8aec0141-f215-4256-83ea-18e06e005f72', 'Everdell', 4, 4, 120, 10, 'Gather resources to develop a harmonious village of woodland critters and structures.', 8.6, 6);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (152, 'c17aaf34-8079-463c-9820-583625cb9c79', 'Trash Pandas', 2, 4, 20, 10, 'Cute pandas', 7, 11);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (202, 'e0d4616d-906c-49a2-9b67-998f403ce3f5', 'Ticket To Ride', 2, 5, 120, 8, 'Fun with trains', 8, 9);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (252, 'e0f13c9b-0f7f-43f3-888f-b8eb6d2769ac', 'Splendor', 2, 5, 20, 10, 'Good', 7, 5);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (302, 'af72fc7b-b9fb-42d5-8e21-580c9216b623', 'Detective Club', 4, 8, 120, 12, 'Social deduction game', 8.5, 10);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (402, '5b061dac-3f95-43d8-9939-faef0d2d3d04', 'Dixit', 3, 6, 60, 10, 'Nice game', 7.5, 12);
INSERT INTO public.board_game (id, public_id, game_name, min_player, max_player, play_time_in_minutes, recommended_age, description, rating, publisher_id) VALUES (452, 'f29cc790-45ef-4d0d-9d34-fb049164ba89', 'Aye, Dark Overlord', 3, 12, 100, 10, 'Good', 8.5, 11);


--
-- TOC entry 3053 (class 0 OID 17349)
-- Dependencies: 207
-- Data for Name: board_game_categories; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- TOC entry 3058 (class 0 OID 17423)
-- Dependencies: 212
-- Data for Name: board_game_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
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


--
-- TOC entry 3054 (class 0 OID 17354)
-- Dependencies: 208
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- TOC entry 3055 (class 0 OID 17363)
-- Dependencies: 209
-- Data for Name: publisher; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- TOC entry 3056 (class 0 OID 17369)
-- Dependencies: 210
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: postgres
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


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 213
-- Name: app_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_user_seq', 601, true);


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 214
-- Name: board_game_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.board_game_seq', 501, true);


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 203
-- Name: category_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_seq', 101, true);


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 204
-- Name: publisher_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publisher_seq', 101, true);


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 205
-- Name: review_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.review_seq', 451, true);


--
-- TOC entry 2913 (class 2606 OID 19336)
-- Name: app_user_favorite_board_game app_user_favorite_board_game_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_favorite_board_game
    ADD CONSTRAINT app_user_favorite_board_game_pkey PRIMARY KEY (app_user_id, favorite_board_game_id);


--
-- TOC entry 2909 (class 2606 OID 17427)
-- Name: board_game_reviews board_game_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT board_game_reviews_pkey PRIMARY KEY (board_game_id, reviews_id);


--
-- TOC entry 2883 (class 2606 OID 17348)
-- Name: board_game pk_board_game; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT pk_board_game PRIMARY KEY (id);


--
-- TOC entry 2887 (class 2606 OID 17353)
-- Name: board_game_categories pk_board_game_categories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game_categories
    ADD CONSTRAINT pk_board_game_categories PRIMARY KEY (board_game_id, categories_id);


--
-- TOC entry 2889 (class 2606 OID 17362)
-- Name: category pk_category; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT pk_category PRIMARY KEY (id);


--
-- TOC entry 2895 (class 2606 OID 17368)
-- Name: publisher pk_publisher; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT pk_publisher PRIMARY KEY (id);


--
-- TOC entry 2901 (class 2606 OID 17374)
-- Name: review pk_review; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT pk_review PRIMARY KEY (id);


--
-- TOC entry 2905 (class 2606 OID 17383)
-- Name: app_user pk_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT pk_user PRIMARY KEY (id);


--
-- TOC entry 2885 (class 2606 OID 17385)
-- Name: board_game uc_board_game_public; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT uc_board_game_public UNIQUE (public_id);


--
-- TOC entry 2891 (class 2606 OID 17387)
-- Name: category uc_category_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT uc_category_name UNIQUE (name);


--
-- TOC entry 2893 (class 2606 OID 17389)
-- Name: category uc_category_public; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT uc_category_public UNIQUE (public_id);


--
-- TOC entry 2897 (class 2606 OID 17391)
-- Name: publisher uc_publisher_public; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT uc_publisher_public UNIQUE (public_id);


--
-- TOC entry 2899 (class 2606 OID 17393)
-- Name: publisher uc_publisher_publisher_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT uc_publisher_publisher_name UNIQUE (publisher_name);


--
-- TOC entry 2903 (class 2606 OID 17395)
-- Name: review uc_review_public; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT uc_review_public UNIQUE (public_id);


--
-- TOC entry 2907 (class 2606 OID 17397)
-- Name: app_user uc_user_public; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT uc_user_public UNIQUE (public_id);


--
-- TOC entry 2911 (class 2606 OID 17435)
-- Name: board_game_reviews uk_8fsv5nv6hhpwddui0lkh7e8ou; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT uk_8fsv5nv6hhpwddui0lkh7e8ou UNIQUE (reviews_id);


--
-- TOC entry 2915 (class 2606 OID 17413)
-- Name: board_game_categories fk_boagamcat_on_board_game; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game_categories
    ADD CONSTRAINT fk_boagamcat_on_board_game FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2916 (class 2606 OID 17418)
-- Name: board_game_categories fk_boagamcat_on_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game_categories
    ADD CONSTRAINT fk_boagamcat_on_category FOREIGN KEY (categories_id) REFERENCES public.category(id);


--
-- TOC entry 2914 (class 2606 OID 17398)
-- Name: board_game fk_board_game_on_publisher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game
    ADD CONSTRAINT fk_board_game_on_publisher FOREIGN KEY (publisher_id) REFERENCES public.publisher(id);


--
-- TOC entry 2917 (class 2606 OID 17403)
-- Name: review fk_review_on_board_game; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_on_board_game FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2918 (class 2606 OID 17408)
-- Name: review fk_review_on_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_on_user FOREIGN KEY (app_user_id) REFERENCES public.app_user(id);


--
-- TOC entry 2921 (class 2606 OID 19337)
-- Name: app_user_favorite_board_game fkilfbd8k8kxolpdhc943mksi5d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_favorite_board_game
    ADD CONSTRAINT fkilfbd8k8kxolpdhc943mksi5d FOREIGN KEY (favorite_board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2919 (class 2606 OID 17440)
-- Name: board_game_reviews fkki564u29is2kkeh03gk2l5mjv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT fkki564u29is2kkeh03gk2l5mjv FOREIGN KEY (reviews_id) REFERENCES public.review(id);


--
-- TOC entry 2920 (class 2606 OID 17445)
-- Name: board_game_reviews fkl8pn42mu2vktex77qoqdhqqn1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.board_game_reviews
    ADD CONSTRAINT fkl8pn42mu2vktex77qoqdhqqn1 FOREIGN KEY (board_game_id) REFERENCES public.board_game(id);


--
-- TOC entry 2922 (class 2606 OID 19342)
-- Name: app_user_favorite_board_game fkpb3dfit9oyxqw9kae5dq2c3xl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_favorite_board_game
    ADD CONSTRAINT fkpb3dfit9oyxqw9kae5dq2c3xl FOREIGN KEY (app_user_id) REFERENCES public.app_user(id);


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-10-26 15:32:15 CEST

--
-- PostgreSQL database dump complete
--

