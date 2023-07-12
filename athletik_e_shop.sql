--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    first_name character varying(10),
    last_name character varying(10),
    e_mail character varying(30),
    address character varying(30)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_customer_id_seq OWNER TO postgres;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_items_id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer,
    unit_price numeric
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_order_items_id_seq OWNED BY public.order_items.order_items_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(20),
    description character varying(20),
    price numeric,
    stock integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: customers customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);


--
-- Name: order_items order_items_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_items_id SET DEFAULT nextval('public.order_items_order_items_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, first_name, last_name, e_mail, address) FROM stdin;
1	Simon	Velcani	saimoundo@gmail.com	roumelis 14
2	Saimon	Veltsani	ice18390082@uniwa.gr	Dwdekanhsou 28
3	kiork	million	ice1839002@uniwa.gr	nikaia
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (order_items_id, order_id, product_id, quantity, unit_price) FROM stdin;
1	20	1	10	26
2	23	1	10	26
3	24	1	10	25.99
4	25	1	1	25.99
5	26	1	1	25.99
6	27	1	1	25.99
7	27	2	2	25.99
8	28	1	10	25.99
9	28	2	10	25.99
10	29	1	10	25.99
11	29	2	10	25.99
12	30	1	10	25.99
13	30	2	10	25.99
14	31	1	10	25.99
15	31	2	10	25.99
16	32	1	10	25.99
17	32	2	10	25.99
18	33	3	10	89.99
19	33	4	10	89.99
20	34	1	1	25.99
21	34	2	1	25.99
22	34	3	1	25.99
23	35	2	1	19.99
24	35	1	10	19.99
25	36	1	10	25.99
26	37	1	10	25.99
27	37	2	1	25.99
28	38	1	2	25.99
29	39	1	2	25.99
30	40	1	2	25.99
31	41	1	2	25.99
32	42	1	3	25.99
33	43	1	3	25.99
34	44	1	3	25.99
35	45	1	2	25.99
36	45	2	1	25.99
37	45	3	3	25.99
38	46	1	2	25.99
39	46	2	1	25.99
40	46	3	1	25.99
41	47	2	1	19.99
42	47	4	2	19.99
43	48	5	2	39.99
44	48	6	1	39.99
45	49	7	1	59.99
46	49	8	1	59.99
47	50	1	2	25.99
48	50	2	1	25.99
49	51	1	1	25.99
50	52	2	1	19.99
51	53	1	1	25.99
52	53	6	1	79.99
53	54	4	2	49.99
54	54	9	1	199.99
55	54	4	1	49.99
56	54	9	1	199.99
57	55	1	2	25.99
58	55	3	2	89.99
59	55	1	1	25.99
60	55	9	1	199.99
61	56	1	4	25.99
62	56	2	10	19.99
63	56	8	2	15.99
64	57	2	1	19.99
65	57	3	1	89.99
66	58	2	10	19.99
67	58	1	2	25.99
68	59	2	10	19.99
69	59	8	1	15.99
70	60	2	10	19.99
71	60	8	1	15.99
72	61	2	10	19.99
73	61	9	1	199.99
74	61	7	1	59.99
75	62	5	2	39.99
76	62	3	1	89.99
77	63	2	10	19.99
78	63	4	1	49.99
79	63	5	1	39.99
80	64	4	2	49.99
81	64	8	1	15.99
82	64	1	10	25.99
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_id, order_date, total_amount) FROM stdin;
1	1	2023-07-08 03:16:39.185176	109.98
2	1	2023-07-08 12:37:50.958068	0.0
3	1	2023-07-08 12:41:33.250337	129.97
4	1	2023-07-08 13:02:28.304417	149.96
5	1	2023-07-08 13:03:14.654541	77.97
6	1	2023-07-08 13:08:44.862514	51.98
7	1	2023-07-08 13:41:37.867383	459.80
8	1	2023-07-08 15:03:15.737546	0.0
9	1	2023-07-08 15:23:27.667318	25.99
10	1	2023-07-08 15:24:50.849144	25.99
11	1	2023-07-08 15:26:17.964683	259.90
12	1	2023-07-08 15:40:17.335151	25.99
13	1	2023-07-08 15:40:52.1107	25.99
14	1	2023-07-08 15:41:18.067477	25.99
15	1	2023-07-08 15:42:15.093448	25.99
16	1	2023-07-08 15:43:04.341849	25.99
17	1	2023-07-08 15:43:49.185705	25.99
18	1	2023-07-08 15:50:07.220372	25.99
19	1	2023-07-08 15:53:51.852687	25.99
20	1	2023-07-08 15:54:37.275428	25.99
21	1	2023-07-08 15:59:33.956129	259.90
22	1	2023-07-08 16:09:24.977673	259.90
23	1	2023-07-08 16:10:12.738889	259.90
24	1	2023-07-08 16:13:32.136759	259.90
25	1	2023-07-08 16:14:16.279308	25.99
26	1	2023-07-08 16:15:16.972189	25.99
27	1	2023-07-08 16:18:20.069401	25.99
28	1	2023-07-11 18:34:55.305655	259.90
29	1	2023-07-11 18:38:56.278713	259.90
30	1	2023-07-11 18:43:58.184376	259.90
31	1	2023-07-11 18:46:42.631923	259.90
32	1	2023-07-11 19:16:19.342745	259.90
33	1	2023-07-11 19:17:05.086538	899.90
34	1	2023-07-11 19:17:47.457503	25.99
35	1	2023-07-11 19:22:23.592347	19.99
36	1	2023-07-11 19:23:20.866856	259.90
37	1	2023-07-11 19:27:04.89782	259.90
38	1	2023-07-11 19:44:46.304235	51.98
39	1	2023-07-11 19:45:12.05907	51.98
40	1	2023-07-11 21:57:05.425714	51.98
41	1	2023-07-11 22:08:35.714037	51.98
42	1	2023-07-11 22:09:27.381114	77.97
43	1	2023-07-11 22:10:24.093862	77.97
44	1	2023-07-11 22:11:10.807487	77.97
45	1	2023-07-11 22:13:10.498065	51.98
46	1	2023-07-11 22:22:46.65891	51.98
47	1	2023-07-11 22:26:54.106409	19.99
48	1	2023-07-11 22:29:02.168939	79.98
49	1	2023-07-11 22:31:19.112401	59.99
50	1	2023-07-11 22:33:15.706766	51.98
51	1	2023-07-11 22:41:45.233469	25.99
52	1	2023-07-11 22:41:49.954627	45.98
53	1	2023-07-11 22:44:00.840443	105.98
54	1	2023-07-12 02:34:28.393422	749.94
55	1	2023-07-12 02:37:59.29137	457.94
56	1	2023-07-12 02:43:25.57322	335.84
57	1	2023-07-12 02:47:04.41313	109.98
58	2	2023-07-12 02:49:37.575096	251.88
59	2	2023-07-12 02:52:32.232811	215.89
60	2	2023-07-12 02:53:45.093601	215.89
61	2	2023-07-12 02:54:35.884036	459.88
62	3	2023-07-12 02:56:41.667616	169.97
63	2	2023-07-12 03:00:35.238161	289.88
64	2	2023-07-12 03:03:14.439934	427.85
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, description, price, stock) FROM stdin;
10	Table Tennis Balls	Lorem Ipsum	9.99	0
9	Golf Club Set	Lorem Ipsum	199.99	0
7	Cycling Helmet	Lorem Ipsum	59.99	18
3	Tennis Racket	Lorem Ipsum	89.99	46
2	Basket Ball	Lorem Ipsum	19.99	289
5	Yoga Mat	Lorem Ipsum	39.99	35
4	Baseball Glove	Lorem Ipsum	49.99	7
8	Swimming Goggles	Lorem Ipsum	15.99	29
1	Soccer Ball	Lorem Ipsum	25.99	29
6	Dumbell Set	Lorem Ipsum	79.99	8
\.


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 3, true);


--
-- Name: order_items_order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_order_items_id_seq', 82, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 64, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 10, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_items_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: SEQUENCE customers_customer_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.customers_customer_id_seq TO psymon;


--
-- Name: SEQUENCE orders_order_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.orders_order_id_seq TO psymon;


--
-- Name: SEQUENCE products_product_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.products_product_id_seq TO psymon;


--
-- PostgreSQL database dump complete
--

