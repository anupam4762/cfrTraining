--
-- PostgreSQL database dump
--

\restrict fjtTmaNcQoiGfFfXVeVqztB5MxltSDdhdNcxmcZ9HTLWjPAhQgXQBkEoOQJqdfm

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-05-28 21:21:03

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
-- TOC entry 226 (class 1259 OID 16421)
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    user_email character varying(100),
    course character varying(50),
    rating integer,
    feedback text,
    suggestions text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16420)
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_id_seq OWNER TO postgres;

--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 225
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- TOC entry 236 (class 1259 OID 16502)
-- Name: form_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_answers (
    id integer NOT NULL,
    response_id integer,
    question_id integer,
    answer_text text
);


ALTER TABLE public.form_answers OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16501)
-- Name: form_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_answers_id_seq OWNER TO postgres;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 235
-- Name: form_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_answers_id_seq OWNED BY public.form_answers.id;


--
-- TOC entry 232 (class 1259 OID 16471)
-- Name: form_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_options (
    id integer NOT NULL,
    question_id integer,
    option_text text NOT NULL,
    is_correct boolean DEFAULT false
);


ALTER TABLE public.form_options OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16470)
-- Name: form_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_options_id_seq OWNER TO postgres;

--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 231
-- Name: form_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_options_id_seq OWNED BY public.form_options.id;


--
-- TOC entry 230 (class 1259 OID 16453)
-- Name: form_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_questions (
    id integer NOT NULL,
    form_id integer,
    question text NOT NULL,
    question_type character varying(30) NOT NULL,
    image_url text,
    question_order integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.form_questions OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16452)
-- Name: form_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_questions_id_seq OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 229
-- Name: form_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_questions_id_seq OWNED BY public.form_questions.id;


--
-- TOC entry 234 (class 1259 OID 16488)
-- Name: form_responses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form_responses (
    id integer NOT NULL,
    form_id integer,
    user_email character varying(255),
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.form_responses OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16487)
-- Name: form_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.form_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.form_responses_id_seq OWNER TO postgres;

--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 233
-- Name: form_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.form_responses_id_seq OWNED BY public.form_responses.id;


--
-- TOC entry 228 (class 1259 OID 16441)
-- Name: forms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forms (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.forms OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16440)
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forms_id_seq OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 227
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forms_id_seq OWNED BY public.forms.id;


--
-- TOC entry 222 (class 1259 OID 16401)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    question text NOT NULL,
    option_a text,
    option_b text,
    option_c text,
    option_d text,
    correct_option character(1)
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16400)
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 221
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- TOC entry 224 (class 1259 OID 16412)
-- Name: test_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_results (
    id integer NOT NULL,
    user_email character varying(100),
    score integer,
    total integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.test_results OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16411)
-- Name: test_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_results_id_seq OWNER TO postgres;

--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 223
-- Name: test_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_results_id_seq OWNED BY public.test_results.id;


--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100),
    designation character varying(100),
    lab character varying(150),
    lab_address text,
    mobile character varying(15),
    official_email character varying(100),
    personal_email character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    password character varying(100)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4901 (class 2604 OID 16424)
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 16505)
-- Name: form_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_answers ALTER COLUMN id SET DEFAULT nextval('public.form_answers_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 16474)
-- Name: form_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_options ALTER COLUMN id SET DEFAULT nextval('public.form_options_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 16456)
-- Name: form_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_questions ALTER COLUMN id SET DEFAULT nextval('public.form_questions_id_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 16491)
-- Name: form_responses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_responses ALTER COLUMN id SET DEFAULT nextval('public.form_responses_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 16444)
-- Name: forms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forms ALTER COLUMN id SET DEFAULT nextval('public.forms_id_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 16404)
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 16415)
-- Name: test_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results ALTER COLUMN id SET DEFAULT nextval('public.test_results_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 16393)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5089 (class 0 OID 16421)
-- Dependencies: 226
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback (id, user_email, course, rating, feedback, suggestions, created_at) FROM stdin;
1	tanu@gmail.com	DRET	5	Good work team	All good, thanks 	2026-05-23 21:01:15.318794
2	tanu@gmail.com	DRET	4	Ok	okay	2026-05-24 18:13:31.430108
3	tanu@gmail.com	DRET	4	nice course	okay	2026-05-24 18:17:26.442827
4	tanu@gmail.com	DRET	5	ok	nin	2026-05-24 18:18:15.711106
\.


--
-- TOC entry 5099 (class 0 OID 16502)
-- Dependencies: 236
-- Data for Name: form_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_answers (id, response_id, question_id, answer_text) FROM stdin;
1	1	1	Two
2	1	2	one, two, three
3	1	3	anupam anand
4	1	4	anu
\.


--
-- TOC entry 5095 (class 0 OID 16471)
-- Dependencies: 232
-- Data for Name: form_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_options (id, question_id, option_text, is_correct) FROM stdin;
1	1	one 	t
2	1	Two	f
3	1	three	f
4	1	four	f
5	2	one	t
6	2	two	t
7	2	three	t
8	4	anu	t
9	4	tanu	f
\.


--
-- TOC entry 5093 (class 0 OID 16453)
-- Dependencies: 230
-- Data for Name: form_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_questions (id, form_id, question, question_type, image_url, question_order, created_at) FROM stdin;
1	1	Reliability question 1	mcq	\N	1	2026-05-27 20:29:04.408381
2	1	Reliability question 2	checkbox	\N	2	2026-05-27 20:29:04.423519
3	1	Who are you question	text	\N	3	2026-05-27 20:29:04.427382
4	1	Who is he	mcq	/uploads/1779893944096-Screenshot (1).png	4	2026-05-27 20:29:04.428239
\.


--
-- TOC entry 5097 (class 0 OID 16488)
-- Dependencies: 234
-- Data for Name: form_responses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form_responses (id, form_id, user_email, submitted_at) FROM stdin;
1	1	\N	2026-05-27 20:52:45.977623
\.


--
-- TOC entry 5091 (class 0 OID 16441)
-- Dependencies: 228
-- Data for Name: forms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forms (id, title, description, created_at) FROM stdin;
1	Test 1	Let us check the test builder	2026-05-27 20:29:04.398156
\.


--
-- TOC entry 5085 (class 0 OID 16401)
-- Dependencies: 222
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, question, option_a, option_b, option_c, option_d, correct_option) FROM stdin;
30	Which of the following statement is true about bathtub curve?	The early phase show increasing failure rate	The middle phase represents random failures	The early phase represents wear out failures	The middle phase shows a decreasing failure rate	B
29	A parts-count reliability prediction is calculated by summing only the 	Parts failure rates	Number of parts in the system	Variance of the part failure rates	Parts failure rates with application stress	A
1	For a mission time of 100 hours and the failure rate of the item is 0.002. What is the Reliability of an item?	100%	81.87%	52%	33%	B
2	A reliability expression for three independent components in parallel with component reliability R is :	3R	3R-3R2+R3	[1-(1-R)2]+R	(1-R)3	B
5	What is the failure rate of a system composed of three components, each of which can cause a system failure, and which have the following information? Components Test Time Failures:\n\nI. 1500 hours 1\n\nII. 2200 hours 2\n\nlll. 3000 hours 3	0.001 f/hr	0.00258 f/hr	0.009 f/hr	0.0067 f/hr	B
4	Assuming an exponential failure distribution, the probability of surviving an operating time equal to twice the MTBF is:	About 8 percent	About 14 percent	About 18 percent	About 36 percent	B
3	The nature of device malfunction which resulted in the observed failure characteristics is:	Failure cause	Failure mode	Failure defect	Failure mechanism	C
10	What is the probability of observing 3 or 4 on the toss of a single die?	2/6	1	1/6	3/6	A
9	If the mean-time-between-failure is 200 hours, what is the probability of surviving for 200 hours?	0.50	0.90	0.63	0.37	D
8	If a 1 Watt resistor is to be derated 50%, what is the derated wattage?	1/4 watt	1/2 watt	3/4 watt	3/2 watt	B
7	What is the reliability of a five component series when the reliability of each component is 0.70?	0.1681	0.2401	0.6570	0.9976	A
6	Twelve identical units are reliability tested under the same stresses and conditions. All units are tested and test was terminated after five units failed. The failure times of the five units are as follows: 50, 75, 100, 200 and 300 hours. The remaining seven items have survived without failures. What will be median rank percentage calculation at the 4th failure time?	68.5%	31.48%	29.83%	5.6%	C
15	Of the following, which is the most important reliability principle?	Use only proven designs	Specify only high reliability components	Consider reliability early in the design phase	Use redundancy throughout the design	C
14	Variation in the shape parameter for the Weibull distribution can in turn, create all of the following distribution shapes except	Rayleigh	Hyper geometric	A minimum of failures	A reduction in test time	A
13	The coefficients for sample size eight in the binomial expansion would be:	1, 5, 10, 10, 5, 1	16, 15, 20, 15, 6, 1	1, 8, 28, 56, 70, 56, 28, 8, 1	1, 7, 21, 35, 21, 7, 1	C
12	A coin and a die are tossed simultaneously. What is the probability of getting tail from coin tossing and observing even number of a die?	0.5 and 0	0.5 and 0.5	Both 0	Both 100%	B
11	What is the probability of observing a total of 13 on the toss of two dies?	90%	0	13/36	1	B
20	A system has three components having reliabilities A, B and C. These components can operate either in series or parallel. Therefore the reliability of the system, R can be calculated from which of the following equations? \n\nI. R = A + B + C\n\nII. R = A *B * C\n\nIII. R =1/A * 1/B * 1/C\n\nIV. R = 1 - [(1-A) * (1-B) * (1-C)]	I and IV only	II and III only	II and IV only	II, III, and IV only	C
19	The first phase in the operation life history of a population of product units is typically called the :	Debugging phase	Wear out phase	Transition phase	Chance failure phase	A
18	Looking at systems in terms of (1) a series-parallel functional configuration, (2) using a truth table approach, or (3) performing a Monte-Carlo simulation are techniques for:	Trade-off studies	Sneak circuit analysis	Modeling systems	Fault Tree Analysis	C
17	The distribution which has a mean equal to the standard deviation is the:	Poisson	Exponential	Weibull	Rayleigh	B
16	FMECA is:	A professional engineering organization	A formal technique for review of failure potentials during design	A technique to assure that design performance guidelines are fulfilled	A technique useful for space-government projects	B
25	Given mean-time-to-failure for three components as M1 = 100 hours, M2 = 500 hours, M3= 1000 hours; what is the mean-time-to-failure of the system if the three components are in series?	160 hours	100 hours	77 hours	13 hours	C
24	Failure modes	Are very consistent among components of a given product class, i.e., pumps, transformers, integrated circuits	Are well documented in military and industry handbooks	Can vary dramatically due to changes in use applications	Are difficult to be determined for any product class	C
23	The time to fail for a flexible membrane follows the Weibull distribution with β (Beta)=2, ƞ (Eeta)=300 months. If the reliability at 200 months is 0.6412, after how many months is 90% reliability achieved?	67.58	97.38	92.72	89.34	C
22	FMEA is a good technique to achieve:	Constant failure rate	Only wear out failure	A minimum of failures	A reduction in test time	B
21	Which statement is NOT TRUE for Reliability Prediction?	Stress details are accounted for	Confidence level is attached	Environment in which the system works is considered	Failure rate & MTBF is determined	B
28	Which of the following considerations should a criticality analysis (CA) take into account?\n\n I. Consequences of a failure\n\nII. Consequential damage of a failure\n\nIII. Damage to the environment\n\nIV. Potential increase in efficiencies	I only	I and II only	I, II, and III only	I, II, III, and IV	C
27	A component follows a Weibull distribution with characteristic life of 4000 hours and slope of 2. What is the expected reliability after 2000 hours of testing?	0.500	0.591	0.779	0.856	C
26	The constant failure rate for a television receiver is 0.02 failures per hour. Calculate the mean time between failure (MTBF).	60 hours	50 hours	40 hours	35 hours	B
\.


--
-- TOC entry 5087 (class 0 OID 16412)
-- Dependencies: 224
-- Data for Name: test_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_results (id, user_email, score, total, created_at) FROM stdin;
1	tanu@gmail.com	2	2	2026-05-22 22:01:44.169015
2	tanu@gmail.com	0	2	2026-05-22 22:12:17.036921
3	tanu@gmail.com	0	2	2026-05-22 22:14:11.865258
4	tanu@gmail.com	2	2	2026-05-22 22:31:53.493488
5	tanu@gmail.com	2	2	2026-05-22 22:40:18.074046
6	anu@gmail.com	2	2	2026-05-23 20:22:12.618604
7	anu@gmail.com	2	2	2026-05-23 20:24:56.156076
8	anu@gmail.com	2	2	2026-05-23 20:43:24.063336
9	tanu@gmail.com	1	2	2026-05-24 18:05:10.085686
10	tanu@gmail.com	2	2	2026-05-24 18:07:52.562698
11	anu@gmail.com	7	15	2026-05-27 21:33:10.420733
12	anu@gmail.com	2	30	2026-05-27 22:19:42.285917
\.


--
-- TOC entry 5083 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, designation, lab, lab_address, mobile, official_email, personal_email, created_at, password) FROM stdin;
1	Anupam Anand	SCB	ETDC	Chennai	1234567890	anupam@test.co	test@test.com	2026-05-20 19:58:46.916687	\N
2	Anu	Sssf	dfsdfdf	dfsdfd	456576576	dsds@scfdf	sds@dfds	2026-05-20 20:02:48.188454	\N
3	Tanu	jhsf	dfsdfdf	dfssdfd	1234567890	tanu@gmail.com	tanu@gmail.com	2026-05-20 20:08:46.490278	$2b$10$oDOeIYTLZAZ8P2zo5VMuHODq7oGcbB6vb4kdoWK0xMRz/JUap9Qgm
4	Anupam	SCB	CFR	Chennai	123456789	anu@gmail.com	anu@gmail.com	2026-05-23 20:13:53.92013	$2b$10$A8YR/Vosbo033hw9tUWvx.R7s695t0iu0HHGWBMganxzCB/Ay.gW6
\.


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 225
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_id_seq', 4, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 235
-- Name: form_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_answers_id_seq', 4, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 231
-- Name: form_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_options_id_seq', 9, true);


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 229
-- Name: form_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_questions_id_seq', 4, true);


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 233
-- Name: form_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.form_responses_id_seq', 1, true);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 227
-- Name: forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forms_id_seq', 1, true);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 221
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 3, true);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 223
-- Name: test_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_results_id_seq', 12, true);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 4919 (class 2606 OID 16430)
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- TOC entry 4929 (class 2606 OID 16510)
-- Name: form_answers form_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_answers
    ADD CONSTRAINT form_answers_pkey PRIMARY KEY (id);


--
-- TOC entry 4925 (class 2606 OID 16481)
-- Name: form_options form_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_options
    ADD CONSTRAINT form_options_pkey PRIMARY KEY (id);


--
-- TOC entry 4923 (class 2606 OID 16464)
-- Name: form_questions form_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_questions
    ADD CONSTRAINT form_questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4927 (class 2606 OID 16495)
-- Name: form_responses form_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_responses
    ADD CONSTRAINT form_responses_pkey PRIMARY KEY (id);


--
-- TOC entry 4921 (class 2606 OID 16451)
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- TOC entry 4915 (class 2606 OID 16410)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4917 (class 2606 OID 16419)
-- Name: test_results test_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_results
    ADD CONSTRAINT test_results_pkey PRIMARY KEY (id);


--
-- TOC entry 4913 (class 2606 OID 16399)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4933 (class 2606 OID 16516)
-- Name: form_answers form_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_answers
    ADD CONSTRAINT form_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.form_questions(id);


--
-- TOC entry 4934 (class 2606 OID 16511)
-- Name: form_answers form_answers_response_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_answers
    ADD CONSTRAINT form_answers_response_id_fkey FOREIGN KEY (response_id) REFERENCES public.form_responses(id) ON DELETE CASCADE;


--
-- TOC entry 4931 (class 2606 OID 16482)
-- Name: form_options form_options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_options
    ADD CONSTRAINT form_options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.form_questions(id) ON DELETE CASCADE;


--
-- TOC entry 4930 (class 2606 OID 16465)
-- Name: form_questions form_questions_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_questions
    ADD CONSTRAINT form_questions_form_id_fkey FOREIGN KEY (form_id) REFERENCES public.forms(id) ON DELETE CASCADE;


--
-- TOC entry 4932 (class 2606 OID 16496)
-- Name: form_responses form_responses_form_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form_responses
    ADD CONSTRAINT form_responses_form_id_fkey FOREIGN KEY (form_id) REFERENCES public.forms(id);


-- Completed on 2026-05-28 21:21:03

--
-- PostgreSQL database dump complete
--

\unrestrict fjtTmaNcQoiGfFfXVeVqztB5MxltSDdhdNcxmcZ9HTLWjPAhQgXQBkEoOQJqdfm

