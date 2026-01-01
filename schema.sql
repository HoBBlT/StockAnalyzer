--
-- PostgreSQL database dump
--

\restrict dKyErd6gvy483LE3h76KJ0SzqUOGEV2vZ8Ux27kTx6s6c5LzZQNpg2rzmxQsb7A

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-01 23:53:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16436)
-- Name: history_trends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history_trends (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    calculated_at date NOT NULL,
    days integer NOT NULL,
    sma_short numeric(12,4),
    sma_long numeric(12,4),
    diff_percent numeric(8,3),
    trend character varying(15),
    CONSTRAINT history_trends_trend_check CHECK (((trend)::text = ANY ((ARRAY['UP'::character varying, 'DOWN'::character varying, 'FLAT'::character varying, 'NOT_ENOUGH_DATA'::character varying])::text[])))
);


ALTER TABLE public.history_trends OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16435)
-- Name: history_trends_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.history_trends_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.history_trends_id_seq OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 223
-- Name: history_trends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.history_trends_id_seq OWNED BY public.history_trends.id;


--
-- TOC entry 222 (class 1259 OID 16403)
-- Name: prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prices (
    id integer NOT NULL,
    stock_id integer NOT NULL,
    trade_date date NOT NULL,
    close numeric(12,4) NOT NULL
);


ALTER TABLE public.prices OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16402)
-- Name: prices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prices_id_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 221
-- Name: prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prices_id_seq OWNED BY public.prices.id;


--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stocks (
    id integer NOT NULL,
    ticker character varying(12) NOT NULL,
    name text,
    uid uuid NOT NULL,
    figi character varying(12) NOT NULL
);


ALTER TABLE public.stocks OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stocks_id_seq OWNER TO postgres;

--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 219
-- Name: stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stocks_id_seq OWNED BY public.stocks.id;


--
-- TOC entry 4767 (class 2604 OID 16439)
-- Name: history_trends id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_trends ALTER COLUMN id SET DEFAULT nextval('public.history_trends_id_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 16406)
-- Name: prices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices ALTER COLUMN id SET DEFAULT nextval('public.prices_id_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 16393)
-- Name: stocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks ALTER COLUMN id SET DEFAULT nextval('public.stocks_id_seq'::regclass);


--
-- TOC entry 4783 (class 2606 OID 16446)
-- Name: history_trends history_trends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_trends
    ADD CONSTRAINT history_trends_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 16412)
-- Name: prices prices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_pkey PRIMARY KEY (id);


--
-- TOC entry 4770 (class 2606 OID 16464)
-- Name: stocks stocks_figi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_figi_key UNIQUE (figi);


--
-- TOC entry 4772 (class 2606 OID 16399)
-- Name: stocks stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_pkey PRIMARY KEY (id);


--
-- TOC entry 4774 (class 2606 OID 16401)
-- Name: stocks stocks_ticker_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_ticker_key UNIQUE (ticker);


--
-- TOC entry 4776 (class 2606 OID 16459)
-- Name: stocks stocks_uid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_uid_key UNIQUE (uid);


--
-- TOC entry 4781 (class 2606 OID 16414)
-- Name: prices unique_price; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT unique_price UNIQUE (stock_id, trade_date);


--
-- TOC entry 4785 (class 2606 OID 16448)
-- Name: history_trends unique_trend_calc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_trends
    ADD CONSTRAINT unique_trend_calc UNIQUE (stock_id, calculated_at);


--
-- TOC entry 4777 (class 1259 OID 16420)
-- Name: idx_prices_stock_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prices_stock_date ON public.prices USING btree (stock_id, trade_date);


--
-- TOC entry 4787 (class 2606 OID 16449)
-- Name: history_trends history_trends_stock_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_trends
    ADD CONSTRAINT history_trends_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES public.stocks(id) ON DELETE CASCADE;


--
-- TOC entry 4786 (class 2606 OID 16415)
-- Name: prices prices_stock_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prices
    ADD CONSTRAINT prices_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES public.stocks(id) ON DELETE CASCADE;


-- Completed on 2026-01-01 23:53:10

--
-- PostgreSQL database dump complete
--

\unrestrict dKyErd6gvy483LE3h76KJ0SzqUOGEV2vZ8Ux27kTx6s6c5LzZQNpg2rzmxQsb7A

