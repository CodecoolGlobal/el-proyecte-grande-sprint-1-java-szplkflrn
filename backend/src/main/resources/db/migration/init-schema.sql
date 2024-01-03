--
-- PostgreSQL database dump
--
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Dumped from database version 12.17 (Debian 12.17-1.pgdg110+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg110+1)

-- Started on 2024-01-03 13:38:25 CET

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
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


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


-- Completed on 2024-01-03 13:38:25 CET

--
-- PostgreSQL database dump complete
--

