--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Ubuntu 17.4-1.pgdg24.04+2)
-- Dumped by pg_dump version 17.4 (Ubuntu 17.4-1.pgdg24.04+2)

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

ALTER TABLE ONLY public.wishlist DROP CONSTRAINT wishlist_product_id_fkey;
ALTER TABLE ONLY public.basket_donations DROP CONSTRAINT basket_donations_basket_item_id_fkey;
ALTER TABLE ONLY public.wishlist DROP CONSTRAINT wishlist_session_id_product_id_key;
ALTER TABLE ONLY public.wishlist DROP CONSTRAINT wishlist_pkey;
ALTER TABLE ONLY public.team DROP CONSTRAINT team_pkey;
ALTER TABLE ONLY public.stories DROP CONSTRAINT stories_pkey;
ALTER TABLE ONLY public.settings DROP CONSTRAINT settings_pkey;
ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
ALTER TABLE ONLY public.programs DROP CONSTRAINT programs_pkey;
ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_pkey;
ALTER TABLE ONLY public.journey DROP CONSTRAINT journey_pkey;
ALTER TABLE ONLY public.gallery DROP CONSTRAINT gallery_pkey;
ALTER TABLE ONLY public.blogs DROP CONSTRAINT blogs_pkey;
ALTER TABLE ONLY public.blog_posts DROP CONSTRAINT blog_posts_slug_key;
ALTER TABLE ONLY public.blog_posts DROP CONSTRAINT blog_posts_pkey;
ALTER TABLE ONLY public.basket_items DROP CONSTRAINT basket_items_pkey;
ALTER TABLE ONLY public.basket_donations DROP CONSTRAINT basket_donations_pkey;
ALTER TABLE ONLY public.awards DROP CONSTRAINT awards_pkey;
ALTER TABLE public.wishlist ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.team ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.stories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.reviews ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.programs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.messages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.journey ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.gallery ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.blogs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.blog_posts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.basket_items ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.basket_donations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.awards ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.wishlist_id_seq;
DROP TABLE public.wishlist;
DROP SEQUENCE public.team_id_seq;
DROP TABLE public.team;
DROP SEQUENCE public.stories_id_seq;
DROP TABLE public.stories;
DROP TABLE public.settings;
DROP SEQUENCE public.reviews_id_seq;
DROP TABLE public.reviews;
DROP SEQUENCE public.programs_id_seq;
DROP TABLE public.programs;
DROP TABLE public.products;
DROP SEQUENCE public.orders_id_seq;
DROP TABLE public.orders;
DROP SEQUENCE public.messages_id_seq;
DROP TABLE public.messages;
DROP SEQUENCE public.journey_id_seq;
DROP TABLE public.journey;
DROP SEQUENCE public.gallery_id_seq;
DROP TABLE public.gallery;
DROP SEQUENCE public.blogs_id_seq;
DROP TABLE public.blogs;
DROP SEQUENCE public.blog_posts_id_seq;
DROP TABLE public.blog_posts;
DROP SEQUENCE public.basket_items_id_seq;
DROP TABLE public.basket_items;
DROP SEQUENCE public.basket_donations_id_seq;
DROP TABLE public.basket_donations;
DROP SEQUENCE public.awards_id_seq;
DROP TABLE public.awards;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: awards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.awards (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    year character varying(50),
    icon character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: awards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.awards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: awards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.awards_id_seq OWNED BY public.awards.id;


--
-- Name: basket_donations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.basket_donations (
    id integer NOT NULL,
    basket_item_id integer,
    quantity integer DEFAULT 1,
    donor_name character varying(255),
    donor_email character varying(255),
    donor_message text,
    amount numeric(10,2),
    payment_method character varying(50),
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: basket_donations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.basket_donations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: basket_donations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.basket_donations_id_seq OWNED BY public.basket_donations.id;


--
-- Name: basket_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.basket_items (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    image text,
    goal integer DEFAULT 100,
    donated integer DEFAULT 0,
    category character varying(100) DEFAULT 'essentials'::character varying
);


--
-- Name: basket_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.basket_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: basket_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.basket_items_id_seq OWNED BY public.basket_items.id;


--
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_posts (
    id integer NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    excerpt text,
    content text,
    image text,
    author text DEFAULT 'EARG Team'::text,
    published boolean DEFAULT false,
    published_at timestamp with time zone DEFAULT now()
);


--
-- Name: blog_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_posts_id_seq OWNED BY public.blog_posts.id;


--
-- Name: blogs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blogs (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    summary text,
    author character varying(255),
    image text,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    tags jsonb
);


--
-- Name: blogs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blogs_id_seq OWNED BY public.blogs.id;


--
-- Name: gallery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gallery (
    id integer NOT NULL,
    url text NOT NULL,
    caption text
);


--
-- Name: gallery_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gallery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gallery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gallery_id_seq OWNED BY public.gallery.id;


--
-- Name: journey; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.journey (
    id integer NOT NULL,
    year character varying(50),
    title character varying(255),
    description text
);


--
-- Name: journey_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journey_id_seq OWNED BY public.journey.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    message text,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    read boolean DEFAULT false
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    items jsonb,
    total numeric(10,2),
    status character varying(50) DEFAULT 'pending'::character varying,
    customer_info jsonb,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    category character varying(100),
    rating numeric(2,1),
    reviews integer,
    description text,
    material character varying(255),
    dimensions character varying(100),
    origin character varying(100),
    impact character varying(255),
    details jsonb,
    story jsonb,
    images jsonb,
    stock integer DEFAULT 0,
    offer_price numeric(10,2)
);


--
-- Name: programs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.programs (
    id integer NOT NULL,
    title character varying(255),
    description text,
    image text,
    features jsonb,
    header text,
    dropdown_title character varying(255)
);


--
-- Name: programs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.programs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.programs_id_seq OWNED BY public.programs.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    product_id character varying(50),
    rating integer,
    comment text,
    author character varying(255),
    status character varying(50) DEFAULT 'pending'::character varying,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    key character varying(50) NOT NULL,
    value jsonb
);


--
-- Name: stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stories (
    id integer NOT NULL,
    name character varying(255),
    role character varying(255),
    image text,
    quote text,
    featured boolean DEFAULT false
);


--
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stories_id_seq OWNED BY public.stories.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.team (
    id integer NOT NULL,
    name character varying(255),
    role character varying(255),
    image text
);


--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;


--
-- Name: wishlist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlist (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    product_id character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wishlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wishlist_id_seq OWNED BY public.wishlist.id;


--
-- Name: awards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards ALTER COLUMN id SET DEFAULT nextval('public.awards_id_seq'::regclass);


--
-- Name: basket_donations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_donations ALTER COLUMN id SET DEFAULT nextval('public.basket_donations_id_seq'::regclass);


--
-- Name: basket_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_items ALTER COLUMN id SET DEFAULT nextval('public.basket_items_id_seq'::regclass);


--
-- Name: blog_posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts ALTER COLUMN id SET DEFAULT nextval('public.blog_posts_id_seq'::regclass);


--
-- Name: blogs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blogs ALTER COLUMN id SET DEFAULT nextval('public.blogs_id_seq'::regclass);


--
-- Name: gallery id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gallery ALTER COLUMN id SET DEFAULT nextval('public.gallery_id_seq'::regclass);


--
-- Name: journey id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey ALTER COLUMN id SET DEFAULT nextval('public.journey_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: programs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programs ALTER COLUMN id SET DEFAULT nextval('public.programs_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: stories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories ALTER COLUMN id SET DEFAULT nextval('public.stories_id_seq'::regclass);


--
-- Name: team id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);


--
-- Name: wishlist id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist ALTER COLUMN id SET DEFAULT nextval('public.wishlist_id_seq'::regclass);


--
-- Data for Name: awards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.awards (id, title, description, year, icon, created_at) FROM stdin;
1	Winner of the Tharaka Nithi County Innovation Award.			emoji_events	2026-02-19 13:04:49.345601
2	Recipient of Gender Awards for policy advocacy (Gender/FGM).			emoji_events	2026-02-19 13:05:02.513228
3	Beneficiary of the Akili Dada Community Leaders’ Fellowship.			emoji_events	2026-02-19 13:05:12.373184
\.


--
-- Data for Name: basket_donations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.basket_donations (id, basket_item_id, quantity, donor_name, donor_email, donor_message, amount, payment_method, date) FROM stdin;
\.


--
-- Data for Name: basket_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.basket_items (id, name, description, price, image, goal, donated, category) FROM stdin;
1	Sanitary Pads (Pack of 10)	A pack of 10 high-quality, reusable sanitary pads that keep a girl in school for up to a year. Many girls miss school every month because they can't afford menstrual products.	8.00	https://images.unsplash.com/photo-1628619876503-2db74e724757?auto=format&fit=crop&q=80&w=800	200	0	menstrual health
2	Exercise Books (Set of 5)	Five exercise books so a girl can take notes, complete homework, and express her ideas. Education starts with the basics.	5.00	https://images.unsplash.com/photo-1531346878377-a5be20888e57?auto=format&fit=crop&q=80&w=800	300	0	school supplies
3	School Bag	A durable school bag to carry books, stationery, and hope. Every girl deserves to walk to school with pride.	15.00	https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&q=80&w=800	100	0	school supplies
4	Hygiene Kit	A complete hygiene kit including soap, toothbrush, toothpaste, and a washcloth. Clean hygiene promotes dignity, health, and confidence.	10.00	https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&q=80&w=800	150	0	essentials
5	School Uniform	A full school uniform set. In many rural areas, girls cannot attend school without a proper uniform — this removes that barrier.	25.00	https://images.unsplash.com/photo-1604671801908-6f0c6a092c05?auto=format&fit=crop&q=80&w=800	80	0	school supplies
6	Stationery Pack	Pens, pencils, rulers, erasers, and a sharpener. The essential tools every student needs to learn and succeed.	4.00	https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?auto=format&fit=crop&q=80&w=800	400	0	school supplies
\.


--
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.blog_posts (id, title, slug, excerpt, content, image, author, published, published_at) FROM stdin;
2	Gender Equality Issues: Context of rural communities	gender-equality-issues-context-of-rural-communities		“Hii malinda tumevaa imefunika mambo mengi ya kijamii. Ukifunua utaona wanawake wanapitia mashida mengi sana kwenye jamii,” said Nkatha an attendee of our Gender Champions training. During our recent gender champions training we invited women from various sub-counties in Tharaka Nithi County, we trained the women and the one gentleman in attendance about the various social inequalities that women and young girls in our communities go through. We focused mostly on the women and girls since they are the minority gender, however, this does not disqualify the fact that men too face various social inequalities.\n\nWe highlighted various forms of gender-based inequalities against women, the women in attendance had their own sad stories to tell which were very similar to the once I have read in some of my favorites reads this year; The girl with the louding voice, Pachinko and It ends with us.\n\n Adunni is the main character in the book, The Girl With The Louding Voice. She is a 14 year old girl growing up in a small village in Nigeria. She is a good student in school but she is forced to drop out of school after her mom passed away because her father could not afford to pay school fees for his children. In order for her father to be able to take care of the family he decides to marry off Adunni as a 3rd wife to a rich and old man from the neighboring village. Adunni is married off in a big traditional wedding and then she leaves her father’s house for the husband’s house who was her father’s age and had 2 other wives already. On the night of her wedding she is prepared by one of her co-wives so that she can spend the night with her new husband. Adunni who was too young to engage in sex leave alone see the naked body of a man is forced to have sex with her husband. “You are now a complete woman, tomorrow we do it again. We keep doing it until you are falling pregnant and you born a boy,” Says her husband after raping her. Adunni a young girl who had a dream a dream of becoming a teacher who drives big cars is now reduced to a child bride who will be raped frequently by her husband who is the chase for a son. This highlights some of gender based violence that we discussed during the training, that is; Harmful Traditional Practices and Sexual Violence. These two types of violence against women and girls are very common in rural areas. Young girls under go FGM, they are married off early, they are forced to drop out of school and women are also raped in their marriages by their husbands.\n\nIn the book Pachinko we meet two strong women characters. The two women are strong and hardworking women who would like to engage in work to earn some money to support their families but their husbands are very much against it because it is believed that the man is supposed to take care of the family and the woman is supposed to be cleaning and cooking for the family. Their husbands are caught in a financial crisis whereby they can no longer support their families but they are not willing to allow their wives to work and earn an extra income for the family. Eventually, things get out of hand financially and the men give in into the pressure of allowing their wives to work and earn some extra income for the family. However, their husbands are the ones to be handling the money that is once they get paid they gave the money to their husbands for them to manage the money for them. Financial violence against women is not a new occurrence in our society today especially in rural areas. Many are the times where women labor hard for their money only for their husbands to take the money from them once they get paid. The attendees highlighted instances where they could invest in agriculture only for them to get back home and find that their husbands have sold their goats or a sack of maize without their knowledge. It actually gets worse since they don’t get a single cent from the proceeds of the sale of their investments. Gone are the times where women were not allowed to earn a living, to invest for themselves and to manage their money.	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=1024	GLORIA KINYA MICHENI	t	2026-03-27 18:35:18.928453+03
3	PERIOD!!	period		HAPPY NEW MONTH! Where is time actually running to? It was just yesterday when we were setting our New Year’s resolutions.\nRecently, that’s on 28th of May we celebrated the Menstrual Hygiene Day. The theme for this year’s MHD was making menstruation a normal fact of life by 2030. Honestly, speaking I would have expected that by now menstruation has been normalized, come on, it’s a biological process and over half of the world’s population will undergo menstruation one day in their lives. I feel like to older generation of women thought that by the year 2022, a lot will have changed in menstrual health. I think by now we would be expecting safe sanitary pads to be readily available for all women, come on I think the government should have ensured that sanitary pads are tax free or better we are given them for free. Sadly, that is not the case, we have unsafe sanitary pads in the market that are affecting our bodies but nothing has been done about that, we still pay tax whenever we buy our pads and the free sanitary towels the government was giving out to school going children have been reduced and in no time they might as well as stop. As a country I don’t think we are anywhere close to making menstruation a normal fact of life. I don’t know why our leaders are comfortable with us paying monthly for a biological body process that we have no control over.\nThe fact that when women buy their sanitary pads they can’t just walk with it in the supermarket aisles without getting weird stares from random strangers says a lot about how menstruation is yet to be normalized in our country. Let’s not even talk about how supermarket attendants wrap sanitary pads in 50 gazettes, what happened using paper sparingly so that we can protect the planet? Women working in offices literally carry their handbags to the washroom during that time of the month to avoid making other office members uncomfortable. It’s about time we start carrying only our pad poach to the washroom or just the pad or maybe offices should start providing sanitary pads in the offices. God forbid that you drop your sanitary pad in a public place by mistake. It is about time we stopped PERIOD SHAMING WOMEN\nGrowing up, one of my biggest fears was staining myself when I was on my period. The thought of people pointing and laughing at me was scary. In short staining myself would mean that I have embarrassed the entire female generation, come one, I am expected to be perfect and ensure that nobody is aware that am on my periods. So, no mistakes are allowed. People should know that staining yourself during your periods is PERFECTLY NORMAL.\nWe need to change the conversation around menstruation. We have young girls believing that menstruation is dirty and they should be embarrassed of themselves for experiencing periods. Institutions should take up to themselves to educate people on what menstruation is all about so that we can break all the taboos surrounding menstruation and menstrual health.\nThe only way we will able to make menstruation a normal fact of life before the year 2030, is by breaking all the taboos surrounding menstruation.	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=386	EARG Team	t	2026-03-27 18:36:45.99435+03
4	Because Menstruation is such an Enigma…	because-menstruation-is-such-an-enigma		Introspection\n\nBecause menstruation is such an enigma, after 20 years of education, having graduated and learnt extensively about sexual reproductive health, having actually learnt about the importance of redressing retrogressive social norms…with all this knowledge and empowerment I am still struggling to discuss menstrual health with my old man even on the peripheries, because honestly vitu kwa ground ni different sana.\n\nBecause menstruation is such an enigma, a girl in a community Daba, here in Kenya is considered so impure and dirty that she is neither allowed to go near livestock, eat their meat nor drink their milk. Dare she drink camels’ milk, or even nears it, it is believed that she automatically becomes barren and her health declines automatically. If god forbid, she goes visit a man, she is collects a curse. Even the mothers their attest that they are embarrassed to discuss this with their daughters. Yani?\n\nBecause menstruation is indeed an enigma, we will not talk about “subtle’ issues that come with menstruation such as mood swings, the unbearable pain, let’s not talk about the tension that comes with staining your clothes. Let’s not talk about the diarrhea or the nausea. Worse still let’s not discuss PMS even though it is a medical reality and denying its existence actually harms women. Let’s not talk about it although in reality we want to scream about it.\n\nBecause menstruation is veritably an enigma. Let’s highlight the challenges an average Kenyan school girl would experience during menstruation.\n\nThe most basic would be lack of access of sanitary towels. And then lack of proper education or rather awareness about her menstrual health, this is the genesis of high female school drop outs, low quality education levels due to the 45 school days she will not be attending classes annually. The| low esteem when she stains her dress and the terror of seeing her body changing in ways, she can’t fathom, the helplessness, the fear to reach out due to the thought of being judged, the avalanche of negative  thoughts, the horror and just the crucifixion this girl faces because of  the natural phenomenon that  is JUST  menstruating.\n\nBecause menstruation is in fact an enigma,\n\nLet’s talk about what Educate a Rural Girl organization {EARG} is doing and we need our support.\n\nWe supply rural schools girls with sanitary towels, provide them with inner wears, we mentor both the girl and the boy, we actually educate both of them about menstrual health, we donate books, stationery and in less than a year we have made an impact on over,500 girls. Is that progress? You can support us buying a t-shirt at @ Ksh 1000. Thanks in advance!\n\nBecause menstruation is in point of fact an enigma, let us demystify it.	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=585	EARG Team	t	2026-03-27 18:38:05.410014+03
\.


--
-- Data for Name: blogs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.blogs (id, title, content, summary, author, image, date, tags) FROM stdin;
1	First Blog Post	This is a test post.	Testing...	Tester		2026-01-21 09:47:34.475774	["test"]
2	Final Verified Post	It works!	Success	Admin		2026-01-21 09:50:44.549476	["test"]
3	The promise on gender equality by Kenya Kwanza: How has Tharaka Nithi County integrated this promise in the new government?	Only two MCAs have been elected out of 15 in Tharaka Nithi County. This is despite the country’s affirmation to support women’s inclusion in positions of leadership after the county launched the gender mainstreaming policy during this year’s International Women’s Day. During the event, cultural, political and socio-economic achievements of women were highlighted, anchored on the theme, Gender Equality Today for a Sustainable Tomorrow. However, these gains remain a mirage for women in Tharaka Nithi as women’s representation on the political front continue to be underrepresented. Sadly, no woman vied for a senatorial nor gubernatorial seat in the county. Only one woman vied for the Member of Parliament seat. Patriarchy remains deeply entrenched disproportionately edging women out of political spaces.\n\nCulture, financial ability and lack of information has disadvantaged many women who would be interested in getting into politics. All is not lost. In its manifesto, the Kenya Kwanza administration made several promises on Gender Equality which included: placing women at the center of every decision-making process and prioritizing them in planning and execution of decisions, provide financial and capacity building support for women through the hustler fund.\n\nThe fund will fully focus on how this money is distributed to women led cooperative societies, chamas, merry go rounds and table banking initiatives as they are protected from predatory interest rates charged by unscrupulous money lenders.\n\nEducate A Rural Girl is a community- based organization that works in rural areas of Tharaka Nithi to ensure issues of gender equality are well understood and adopted at rural household level. Specifically, they empower women self-help groups to achieve economic justice, and improved their sources of income. This in turn increases participation of women at community level in issues that affect them economically.\n\nTo ensure that women are fully represented, the government pledged to ensure the of the 2/3rd gender rule, to be done through the elective and appointive positions in the public sector within 12 months of the election. This will go a long way in ensuring that more women toss themselves in the political field to ensure inclusivity in leadership is progressively achieved.	Only two MCAs have been elected out of 15 in Tharaka Nithi County. This is despite the country’s affirmation to support women’s inclusion in positions of leadership...	Jiljane Makena	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/whatsapp-image-2022-11-16-at-10.51.57-am.jpeg	2022-11-16 00:00:00	[]
4	Gender Equality Issues: Context of rural communities	“Hii malinda tumevaa imefunika mambo mengi ya kijamii. Ukifunua utaona wanawake wanapitia mashida mengi sana kwenye jamii,” said Nkatha an attendee of our Gender Champions training. During our recent gender champions training we invited women from various sub-counties in Tharaka Nithi County, we trained the women and the one gentleman in attendance about the various social inequalities that women and young girls in our communities go through. We focused mostly on the women and girls since they are the minority gender, however, this does not disqualify the fact that men too face various social inequalities.\n\nWe highlighted various forms of gender-based inequalities against women, the women in attendance had their own sad stories to tell which were very similar to the once I have read in some of my favorites reads this year; The girl with the louding voice, Pachinko and It ends with us.\n\nAdunni is the main character in the book, The Girl With The Louding Voice. She is a 14 year old girl growing up in a small village in Nigeria. She is a good student in school but she is forced to drop out of school after her mom passed away because her father could not afford to pay school fees for his children. In order for her father to be able to take care of the family he decides to marry off Adunni as a 3rd wife to a rich and old man from the neighboring village.\n\nIn the book Pachinko we meet two strong women characters. The two women are strong and hardworking women who would like to engage in work to earn some money to support their families but their husbands are very much against it because it is believed that the man is supposed to take care of the family and the woman is supposed to be cleaning and cooking for the family.\n\nFinancial violence against women is not a new occurrence in our society today especially in rural areas. Many are the times where women labor hard for their money only for their husbands to take the money from them once they get paid.	During our recent gender champions training we invited women from various sub-counties in Tharaka Nithi County, we trained the women and the one gentleman...	earg_org	\N	2022-10-19 00:00:00	[]
5	PERIOD!!	HAPPY NEW MONTH! Where is time actually running to? It was just yesterday when we were setting our New Year’s resolutions. Recently, that’s on 28th of May we celebrated the Menstrual Hygiene Day. The theme for this year’s MHD was making menstruation a normal fact of life by 2030. Honestly, speaking I would have expected that by now menstruation has been normalized, come on, it’s a biological process and over half of the world’s population will undergo menstruation one day in their lives.\n\nI feel like to older generation of women thought that by the year 2022, a lot will have changed in menstrual health. I think by now we would be expecting safe sanitary pads to be readily available for all women, come on I think the government should have ensured that sanitary pads are tax free or better we are given them for free. Sadly, that is not the case.\n\nAs a country I don’t think we are anywhere close to making menstruation a normal fact of life. I don’t know why our leaders are comfortable with us paying monthly for a biological body process that we have no control over. The fact that when women buy their sanitary pads they can’t just walk with it in the supermarket aisles without getting weird stares from random strangers says a lot about how menstruation is yet to be normalized in our country.\n\nIt is about time we stopped PERIOD SHAMING WOMEN. Growing up, one of my biggest fears was staining myself when I was on my period. The thought of people pointing and laughing at me was scary. In short staining myself would mean that I have embarrassed the entire female generation, come one, I am expected to be perfect and ensure that nobody is aware that am on my periods. So, no mistakes are allowed. People should know that staining yourself during your periods is PERFECTLY NORMAL.\n\nWe need to change the conversation around menstruation. We have young girls believing that menstruation is dirty and they should be embarrassed of themselves for experiencing periods. Institutions should take up to themselves to educate people on what menstruation is all about so that we can break all the taboos surrounding menstruation and menstrual health.	Recently, that’s on 28th of May we celebrated the Menstrual Hygiene Day. The theme for this year’s MHD was making menstruation a normal fact of life by 2030.	Gloria Micheni	\N	2022-06-03 00:00:00	[]
6	The promise on gender equality by Kenya Kwanza: How has Tharaka Nithi County integrated thispromise in the new government?	Only two MCAs have been elected out of 15 in Tharaka Nithi County. This is despite the country’s affirmation to support women’s inclusion in positions of leadership after the county launched the gender mainstreaming policy during this year’s International Women’s Day.During the event, cultural, political and socio-economic achievements of women were highlighted, anchored on the theme, Gender Equality Today for a Sustainable Tomorrow. However, these gains remain a mirage for women in Tharaka Nithi as women’s representation on the political front continue to be underrepresented. Sadly, no woman vied for a senatorial nor gubernatorial seat in the county. Only one woman vied for the Member of Parliament seat.Patriarchy remains deeply entrenched disproportionately edging women out of political spaces.\n\nCulture, financial ability and lack of information has disadvantaged many women who would be interested in getting into politics. All is not lost. In its manifesto, the Kenya Kwanza administration made several promises on Gender Equality which included: placing women at the center of every decision-making process and prioritizing them in planning and execution of decisions, provide financial and capacity building support for women through the hustler fund.\n\nThe fund will fully focus on how this money is distributed to women led cooperative societies, chamas, merry go rounds and table banking initiatives as they are protected from predatory interest rates charged by unscrupulous money lenders.\n\nEducate A Rural Girl is a community- based organization that works in rural areas of Tharaka Nithi to ensure issues of gender equality are well understood and adopted at rural household level. Specifically, they empower women self-help groups to achieve economic justice, and improved their sources of income. This in turn increases participation of women at community level in issues that affect them economically.\n\nTo ensure that women are fully represented, the government pledged to ensure the of the 2\\3rd gender rule, to be done through the elective and appointive positions in the public sector within 12 months of the election. This will go a long way in ensuring that more women toss themselves in the political field to ensure inclusivity in leadership is progressively achieved.\n\nArticle by: Jiljane MakenaIntern at Educate A Rural Girl\n\nSupported by : JHR media Production	Only two MCAs have been elected out of 15 in Tharaka Nithi County. This is despite the country’s affirmation to support women’s inclusion in positions of leadership after the county launched the gende...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg	2022-11-16 10:06:34	[]
7	Gender Equality Issues: Context of rural communities	“Hii malinda tumevaa imefunika mambo mengi ya kijamii. Ukifunua utaona wanawake wanapitia mashida mengi sana kwenye jamii,” said Nkatha an attendee of our Gender Champions training. During our recent gender champions training we invited women from various sub-counties in Tharaka Nithi County, we trained the women and the one gentleman in attendance about the various social inequalities that women and young girls in our communities go through. We focused mostly on the women and girls since they are the minority gender, however, this does not disqualify the fact that men too face various social inequalities.\n\nWe highlighted various forms of gender-based inequalities against women, the women in attendance had their own sad stories to tell which were very similar to the once I have read in some of my favorites reads this year; The girl with the louding voice, Pachinko and It ends with us.\n\nAdunni is the main character in the book, The Girl With The Louding Voice. She is a 14 year old girl growing up in a small village in Nigeria. She is a good student in school but she is forced to drop out of school after her mom passed away because her father could not afford to pay school fees for his children. In order for her father to be able to take care of the family he decides to marry off Adunni as a 3rd wife to a rich and old man from the neighboring village. Adunni is married off in a big traditional wedding and then she leaves her father’s house for the husband’s house who was her father’s age and had 2 other wives already. On the night of her wedding she is prepared by one of her co-wives so that she can spend the night with her new husband. Adunni who was too young to engage in sex leave alone see the naked body of a man is forced to have sex with her husband. “You are now a complete woman, tomorrow we do it again. We keep doing it until you are falling pregnant and you born a boy,” Says her husband after raping her. Adunni a young girl who had a dream a dream of becoming a teacher who drives big cars is now reduced to a child bride who will be raped frequently by her husband who is the chase for a son. This highlights some of gender based violence that we discussed during the training, that is; Harmful Traditional Practices and Sexual Violence. These two types of violence against women and girls are very common in rural areas. Young girls under go FGM, they are married off early, they are forced to drop out of school and women are also raped in their marriages by their husbands.\n\nIn the book Pachinko we meet two strong women characters. The two women are strong and hardworking women who would like to engage in work to earn some money to support their families but their husbands are very much against it because it is believed that the man is supposed to take care of the family and the woman is supposed to be cleaning and cooking for the family. Their husbands are caught in a financial crisis whereby they can no longer support their families but they are not willing to allow their wives to work and earn an extra income for the family. Eventually, things get out of hand financially and the men give in into the pressure of allowing their wives to work and earn some extra income for the family. However, their husbands are the ones to be handling the money that is once they get paid they gave the money to their husbands for them to manage the money for them. Financial violence against women is not a new occurrence in our society today especially in rural areas. Many are the times where women labor hard for their money only for their husbands to take the money from them once they get paid. The attendees highlighted instances where they could invest in agriculture only for them to get back home and find that their husbands have sold their goats or a sack of maize without their knowledge. It actually gets worse since they don’t get a single cent from the proceeds of the sale of their investments. Gone are the times where women were not allowed to earn a living, to invest for themselves and to manage their money.\n\nIt ends with us, a book that definitely broke my heart into small tiny pieces. Lily the main character in the book grows up witnessing her dad physically and emotionally abuse her mother. She swore that she would never find herself in a relationship like that one of her parents. But as fate would have it Lilly meets the man of her dreams, she is head of heels for him but the man is an abuser. He physically, sexually and emotionally abuses her. The worst part of it all, Lilly does not have the strength to leave the relationship in the hope that he might change one day but the man does not change. The good news is eventually she mastered the courage to leave the relationship. Lilly is among the few women who eventually master the courage to leave their abusive relationships, many women stay in the marriage hoping that one day their partners will change but by the time they decide to leave it’s too late some leave the relationships only after they inevitable (death) has happened.  The society is partly to be blamed for it glorifies the institution of marriage so much even if the marriage is abusive, it encourages the victims to stop annoying their husbands and that way the husbands will stop abusing them. Dear women, kindly leave that abusive relationship as soon as possible. In as much as we have highlighted these forms of gender based violence using women examples, it does not mean that men do not undergo any form of gender based violence in our society. Therefore, it is important we fight for gender equality and advocate for human rights of every person irrespective of their gender.\n\nARTICLE BY: GLORIA KINYA MICHENI\n\nEARG COMMUNICATIONS AND SOCIAL MEDIA OFFICER	“Hii malinda tumevaa imefunika mambo mengi ya kijamii. Ukifunua utaona wanawake wanapitia mashida mengi sana kwenye jamii,” said Nkatha an attendee of our Gender Champions training. During our recent ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg	2022-10-19 09:50:06	[]
8	PERIOD!!	HAPPY NEW MONTH! Where is time actually running to? It was just yesterday when we were setting our New Year’s resolutions.Recently, that’s on 28th of May we celebrated the Menstrual Hygiene Day. The theme for this year’s MHD was making menstruation a normal fact of life by 2030. Honestly, speaking I would have expected that by now menstruation has been normalized, come on, it’s a biological process and over half of the world’s population will undergo menstruation one day in their lives. I feel like to older generation of women thought that by the year 2022, a lot will have changed in menstrual health. I think by now we would be expecting safe sanitary pads to be readily available for all women, come on I think the government should have ensured that sanitary pads are tax free or better we are given them for free. Sadly, that is not the case, we have unsafe sanitary pads in the market that are affecting our bodies but nothing has been done about that, we still pay tax whenever we buy our pads and the free sanitary towels the government was giving out to school going children have been reduced and in no time they might as well as stop. As a country I don’t think we are anywhere close to making menstruation a normal fact of life. I don’t know why our leaders are comfortable with us paying monthly for a biological body process that we have no control over.The fact that when women buy their sanitary pads they can’t just walk with it in the supermarket aisles without getting weird stares from random strangers says a lot about how menstruation is yet to be normalized in our country. Let’s not even talk about how supermarket attendants wrap sanitary pads in 50 gazettes, what happened using paper sparingly so that we can protect the planet? Women working in offices literally carry their handbags to the washroom during that time of the month to avoid making other office members uncomfortable. It’s about time we start carrying only our pad poach to the washroom or just the pad or maybe offices should start providing sanitary pads in the offices. God forbid that you drop your sanitary pad in a public place by mistake. It is about time we stopped PERIOD SHAMING WOMENGrowing up, one of my biggest fears was staining myself when I was on my period. The thought of people pointing and laughing at me was scary. In short staining myself would mean that I have embarrassed the entire female generation, come one, I am expected to be perfect and ensure that nobody is aware that am on my periods. So, no mistakes are allowed. People should know that staining yourself during your periods is PERFECTLY NORMAL.We need to change the conversation around menstruation. We have young girls believing that menstruation is dirty and they should be embarrassed of themselves for experiencing periods. Institutions should take up to themselves to educate people on what menstruation is all about so that we can break all the taboos surrounding menstruation and menstrual health.The only way we will able to make menstruation a normal fact of life before the year 2030, is by breaking all the taboos surrounding menstruation.\n\nAuthor: Gloria Micheni	HAPPY NEW MONTH! Where is time actually running to? It was just yesterday when we were setting our New Year’s resolutions.Recently, that’s on 28th of May we celebrated the Menstrual Hygiene Day. The t...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png	2022-06-03 08:51:19	[]
9	Basic Education is a right to every Kenyan Child!! But the struggles for some to acquire it!!!………..	A story of a 14 year old girl from Kirigi village, (“Leah”, not her real name), that is not unique but a common story for many girls living in rural areas in Kenya. She was brought up by her grandmother in a very humble home. Her mother was a victim of teenage marriage and as a result of it ended up dropping out of school. Unfortunately, her marriage didn’t work out so she had to walk out. Later she realized that she was pregnant and so she decided to go back home so that her parents could help her out with the maternity expenses. After giving birth, she left home to look for a job leaving Leah with her grandparents and promised to be sending them money to cater for their expenses. However, she did not live up to her words because she neither sent them money for their expenses, nor did she ever pay them a visit.\n\nHer childhood was not the easiest because her grandmother solely depended on the little money she got from her agriculture which was hardly enough for them. However, Leah was determined to make a difference in their lives and so she worked extremely hard in school. Her performance was great right from the word go hence both her grand parents and teachers had very high expectations for her to perform well.\n\nLeah did not have the luxury of being dropped to school by her parents or use the bus. She had to walk for almost 5 kilometers every morning and evening, which is very common for children in rural areas who are in pursuit for their right; EDUCATION. Leah had to go to a school far away from her home because it was what her grandparents could afford to pay for her. She didn’t have friends to walk with for company but had to adapt. She would leave her home at exactly 5.50am, take short cuts and go running so that she could be at school at exactly 6.30am.  The journey to school was one that was characterized with a lot of dangers for instance; she had to cross a river, climb several hills and pass through some bushy routes which were risky for any child but especially for the girl child. Hello! She could have been raped, the good thing is that it didn’t happen. During the rainy seasons she had to leave earlier and take a longer route bearing in mind that she couldn’t go running because it would be so slippery. Despite all those challenges, Leah never got to school late all through her schooling period. She was always on time or even earlier. In 2020 she did her indexing exams and was index 2 which was really great. Last year she did her Kenya Certificate Primary Examinations and scored 355 marks. At last Leah’s hard work and sacrifices had paid off.\n\nLeah’s joy was short-lived because her grandparents could not afford the school fees and other expenses needed for her to join secondary school. Leah was so frustrated and couldn’t imagine not joining secondary school after all the hard work and the sacrifices she had made. She went to the headteacher of her primary school cried her heart out. The head teacher and teachers were so overwhelmed and knew that they had to help her out. The headteacher helped her get a scholarship at Kiangua Secondary School to cover for her school fees and also with the help of the teachers raised funds and helped her buy some shopping. He also raised the issue in the alumni pupils WhatsApp group where one of the members happens to be one of the co-founders of Educate A Rural Girl Organization. The organization took up the task and mobilized for funds from well-wishers and paid for the remaining amount of money needed in school, helped the girl buy the remaining shopping, prepare for school, funded for her transportation and that of her grandmother and also gave her pocket money to be using in school. The organization also took it upon themselves to mentor her and see to it that she is able to go through her secondary school education smoothly.\n\nAs an organization we are hoping to make Leah’s dream of a better tomorrow a reality with the help of all of you who are willing to join us in this noble task. Leah is a representation of other rural girls whose dreams would have cut short because of lack of funds to pursue her education. However, she was lucky to get an opportunity to pursue her education, but the question is how many Leah’s are out there in our villages that have no one to hold their hands in their pursuit for education?\n\nHow many Leah’s have been lured into teenage marriages like Leah’s mom because of lack of school fees?\n\nLet’s join hands and Educate a  Rural Girl.\n\nAuthor: JilJane Makena, Earg Volunteer 2022	A story of a 14 year old girl from Kirigi village, (“Leah”, not her real name), that is not unique but a common story for many girls living in rural areas in Kenya. She was brought up by her grandmoth...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg	2022-05-20 08:04:41	[]
10	Because Menstruation is such an Enigma…	Introspection\n\nBecause menstruation is such an enigma, after 20 years of education, having graduated and learnt extensively about sexual reproductive health, having actually learnt about the importance of redressing retrogressive social norms…with all this knowledge and empowerment I am still struggling to discuss menstrual health with my old man even on the peripheries, because honestly vitu kwa ground ni different sana.\n\nBecause menstruation is such an enigma,\na girl in a community Daba, here in Kenya is considered so impure and dirty\nthat she is neither allowed to go near livestock, eat their meat nor drink\ntheir milk. Dare she drink camels’ milk, or even nears it, it is believed that\nshe automatically becomes barren and her health declines automatically. If god\nforbid, she goes visit a man, she is collects a curse. Even the mothers their\nattest that they are embarrassed to discuss this with their daughters. Yani?\n\nBecause menstruation is indeed an enigma,\nwe will not talk about “subtle’\nissues that come with menstruation such as mood swings, the unbearable pain,\nlet’s not talk about the tension that comes with staining your clothes. Let’s\nnot talk about the diarrhea or the nausea. Worse still let’s not discuss PMS\neven though it is a medical reality and denying its existence actually harms\nwomen. Let’s not talk about it although in reality we want to scream about it.\n\nBecause menstruation is veritably an enigma.\nLet’s highlight the challenges an average Kenyan school girl would experience\nduring menstruation.\n\nThe most basic would be lack of access of sanitary towels. And then lack of proper education or rather awareness about her menstrual health, this is the genesis of high female school drop outs, low quality education levels due to the 45 school days she will not be attending classes annually. The| low esteem when she stains her dress and the terror of seeing her body changing in ways, she can’t fathom, the helplessness, the fear to reach out due to the thought of being judged, the avalanche of negative  thoughts, the horror and just the crucifixion this girl faces because of  the natural phenomenon that  is JUST  menstruating.\n\nBecause menstruation is in fact an enigma,\n\nLet’s talk about what Educate a Rural Girl\norganization {EARG} is doing and we need our support.\n\nWe supply rural schools girls with sanitary towels, provide them with inner wears, we mentor both the girl and the boy, we actually educate both of them about menstrual health, we donate books, stationery and in less than a year we have made an impact on over,500 girls. Is that progress? You can support us buying a t-shirt at @ Ksh 1000. Thanks in advance!\n\nBecause menstruation is in point of fact an enigma, let us demystify it.\n\nArticle by: Dolly, EARG Volunteer	Introspection\n\n\n\nBecause menstruation is such an enigma, after 20 years of education, having graduated and learnt extensively about sexual reproductive health, having actually learnt about the importa...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg	2019-10-20 10:20:00	[]
11	Hello Mr.BodaBoda, Let me study!	For so many years I  always thought that issues of early pregnancy, early marriages and high rates of school drop outs was most common among people in the communities in arid areas I.e the pastoral communities. But I think that times have changed, I can’t really tell what happened but these three are among the major problems being faced in my home area I am trying not to generalize. The saddest part of it is that it has become so common to the extent of being overlooked by our very own leaders. I think it’s kind of clear that these problems are being experienced by the girl child.\n\nI think I am suffering from pregnancy anxiety because most of my childhood friends are mothers. Like it’s so serious to the point that you tend to think something is wrong with you. Personally I can’t really take care of myself so I am pretty sure I can’t take care of my own baby at this age but I can feel the pressure from my peers 😂😂😂. I blame this on the naivety of these girls. I was really privileged to come from a background where at least I got all basic needs and had some really strict parents. Anyone who knows my parents can testify.\n\nThere has been too  much of negative exposure for these rural girls to know how to handle it. For instance,  this is the Era of smartphones, make ups and clubbing. Not every girl can really afford a such, and when the boda boda guy comes in,  promising new phone, a pack of pads and probably a red lipstick, sex is nothing to the rural girl. She is more than willing to offer the service. Either way according to her it’s just sex nothing out of the ordinary. I believe lack of sex education for these young rural girls is a big mishap. The naivety among rural girls is underrated. We just lied to each other as we were growing up. The girl trading sex for a phone or a pack of pads is probably  in form 1 or even in primary and then boom! Pregnancy! End of school! The girl, the boda boda guy, the guardian and the society at large  are all to blame. There’s need for awareness in the rural areas. A rural girl has the right to complete her studies too.\n\nThe early marriage issue is so sad. Mainstream media report it as breaking news whereas  in my village it is just any other normal mushene. I don’t really understand how people get married at the age of 14. When I was 14 was still a young handsome boy with nothing to offer to a man. By the time this young girl is around 25 she will be looking double her age. But parents are also becoming so greedy with money, like how do you marry off your girl at the age of 14. When will she study? When will the rural girl finish her education? I thought she is the one who is supposed to take care of you when you are all old and tired but instead you end up raising your grandchildren. And these boda boda lads, why can’t you just let our girls study in peace? I mean some of these boda boda guys had an opportunity to study but instead dropped out to do them boda  rounds. It’s not like boda business is not important but really let a girl learn. Stop lying to her. Let her curve her own destiny. Stop dictating it with your meagre savings. Instead use that money for self development. Or rather get her a revision book and a packet of pads without demanding for sex if at all you have to. My point is, LET A RURAL GIRL STUDY!\n\nAuthor: Gloria Micheni\n\nEarg Volunteer	For so many years I  always thought that issues of early pregnancy, early marriages and high rates of school drop outs was most common among people in the communities in arid areas I.e the pastoral co...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg	2019-03-04 19:13:30	[]
21	Basic Education is a right to every Kenyan Child!! But the struggles for some to acquire it!!!………..	\n\t\t\n<p>A story of a 14 year old girl from Kirigi village, (“Leah”, not her real name), that is not unique but a common story for many girls living in rural areas in Kenya. She was brought up by her grandmother in a very humble home. Her mother was a victim of teenage marriage and as a result of it ended up dropping out of school. Unfortunately, her marriage didn’t work out so she had to walk out. Later she realized that she was pregnant and so she decided to go back home so that her parents could help her out with the maternity expenses. After giving birth, she left home to look for a job leaving Leah with her grandparents and promised to be sending them money to cater for their expenses. However, she did not live up to her words because she neither sent them money for their expenses, nor did she ever pay them a visit.</p>\n\n\n\n<p>Her childhood was not the easiest because her grandmother solely depended on the little money she got from her agriculture which was hardly enough for them. However, Leah was determined to make a difference in their lives and so she worked extremely hard in school. Her performance was great right from the word go hence both her grand parents and teachers had very high expectations for her to perform well.</p>\n\n\n\n<p>Leah did not have the luxury of being dropped to school by her parents or use the bus. She had to walk for almost 5 kilometers every morning and evening, which is very common for children in rural areas who are in pursuit for their right; EDUCATION. Leah had to go to a school far away from her home because it was what her grandparents could afford to pay for her. She didn’t have friends to walk with for company but had to adapt. She would leave her home at exactly 5.50am, take short cuts and go running so that she could be at school at exactly 6.30am.&nbsp; The journey to school was one that was characterized with a lot of dangers for instance; she had to cross a river, climb several hills and pass through some bushy routes which were risky for any child but especially for the girl child. Hello! She could have been raped, the good thing is that it didn’t happen. During the rainy seasons she had to leave earlier and take a longer route bearing in mind that she couldn’t go running because it would be so slippery. Despite all those challenges, Leah never got to school late all through her schooling period. She was always on time or even earlier. In 2020 she did her indexing exams and was index 2 which was really great. Last year she did her Kenya Certificate Primary Examinations and scored 355 marks. At last Leah’s hard work and sacrifices had paid off.</p>\n\n\n\n<p>Leah’s joy was short-lived because her grandparents could not afford the school fees and other expenses needed for her to join secondary school. Leah was so frustrated and couldn’t imagine not joining secondary school after all the hard work and the sacrifices she had made. She went to the headteacher of her primary school cried her heart out. The head teacher and teachers were so overwhelmed and knew that they had to help her out. The headteacher helped her get a scholarship at Kiangua Secondary School to cover for her school fees and also with the help of the teachers raised funds and helped her buy some shopping. He also raised the issue in the alumni pupils WhatsApp group where one of the members happens to be one of the co-founders of Educate A Rural Girl Organization. The organization took up the task and mobilized for funds from well-wishers and paid for the remaining amount of money needed in school, helped the girl buy the remaining shopping, prepare for school, funded for her transportation and that of her grandmother and also gave her pocket money to be using in school. The organization also took it upon themselves to mentor her and see to it that she is able to go through her secondary school education smoothly.</p>\n\n\n\n<p>As an organization we are hoping to make Leah’s dream of a better tomorrow a reality with the help of all of you who are willing to join us in this noble task. Leah is a representation of other rural girls whose dreams would have cut short because of lack of funds to pursue her education. However, she was lucky to get an opportunity to pursue her education, but the question is how many Leah’s are out there in our villages that have no one to hold their hands in their pursuit for education?</p>\n\n\n\n<p>How many Leah’s have been lured into teenage marriages like Leah’s mom because of lack of school fees?</p>\n\n\n\n<p>Let’s join hands and Educate a&nbsp; Rural Girl.</p>\n\n\n\n<p>Author: JilJane Makena, Earg Volunteer 2022</p>\n\n\n\n<figure class="wp-block-image size-large is-resized"><img data-attachment-id="151" data-permalink="https://educatearuralgirl.wordpress.com/2022/05/20/basic-education-is-a-right-to-every-kenyan-child-but-the-struggles-for-some-to-acquire-it/inkedimg-20220505-wa0013_li/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg" data-orig-size="750,1000" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1651755360&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="inkedimg-20220505-wa0013_li" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg?w=225" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg?w=710" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg?w=750" alt="" class="wp-image-151" width="232" height="308" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg?w=232 232w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg?w=113 113w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg?w=225 225w" sizes="(max-width: 232px) 100vw, 232px"><figcaption>EARG, staff members help Leah as she reports back to school.</figcaption></figure>\n\n\n\n<h1 class="wp-block-heading">EducationforGirls</h1>\n\n\n\n<h1 class="wp-block-heading">Equalityin education</h1>\n\n\n\n<h1 class="wp-block-heading">basicneed</h1>\n\n\n\n<h1 class="wp-block-heading">Humanrights</h1>\n<div id="atatags-370373-6970c7bd169dc">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	A story of a 14 year old girl from Kirigi village, (“Leah”, not her real name), that is not unique but a common story for many girls living in rural areas in Kenya. She was brought up by her grandmoth...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/05/inkedimg-20220505-wa0013_li.jpg	2022-05-20 08:04:41	[]
22	Because Menstruation is such an Enigma…	\n\t\t\n<p><strong>Introspection</strong></p>\n\n\n\n<p><strong>Because menstruation is such an enigma</strong>, after 20 years of education, having graduated and learnt extensively about sexual reproductive health, having actually learnt about the importance of redressing retrogressive social norms…with all this knowledge and empowerment I am still struggling to discuss menstrual health with my old man even on the peripheries, <em>because honestly vitu kwa ground ni different sana.</em></p>\n\n\n\n<p><strong>Because menstruation is such an enigma</strong>,\na girl in a community Daba, here in Kenya is considered so impure and dirty\nthat she is neither allowed to go near livestock, eat their meat nor drink\ntheir milk. Dare she drink camels’ milk, or even nears it, it is believed that\nshe automatically becomes barren and her health declines automatically. If god\nforbid, she goes visit a man, she is collects a curse. Even the mothers their\nattest that they are embarrassed to discuss this with their daughters<em>. Yani?</em></p>\n\n\n\n<p><strong>Because menstruation is indeed an enigma,</strong>\nwe will not talk about “subtle’\nissues that come with menstruation such as mood swings, the unbearable pain,\nlet’s not talk about the tension that comes with staining your clothes. Let’s\nnot talk about the diarrhea or the nausea. Worse still let’s not discuss PMS\neven though it is a medical reality and denying its existence actually harms\nwomen. Let’s not talk about it although in reality we want to scream about it.</p>\n\n\n\n<p><strong>Because menstruation is veritably an enigma.</strong>\nLet’s highlight the challenges an average Kenyan school girl would experience\nduring menstruation.</p>\n\n\n\n<p>The most basic would be lack of access of sanitary towels. And then lack of proper education or rather awareness about her menstrual health, this is the genesis of high female school drop outs, low quality education levels due to the 45 school days she will not be attending classes annually. The| low esteem when she stains her dress and the terror of seeing her body changing in ways, she can’t fathom, the helplessness, the fear to reach out due to the thought of being judged, the avalanche of negative&nbsp; thoughts, the horror and just the crucifixion this girl faces because of &nbsp;the natural phenomenon that&nbsp; is JUST &nbsp;menstruating.</p>\n\n\n\n<p><strong>Because menstruation is in fact an enigma,\n</strong></p>\n\n\n\n<p>Let’s talk about what Educate a Rural Girl\norganization {EARG} is doing and we need our support.</p>\n\n\n\n<p>We supply rural schools girls with sanitary towels, provide them with inner wears, we mentor both the girl and the boy, we actually educate both of them about menstrual health, we donate books, stationery and in less than a year we have made an impact on over,500 girls. Is that progress? You can support us buying a t-shirt at @ Ksh 1000. Thanks in advance!</p>\n\n\n\n<p><strong><em>Because menstruation is in point of fact an enigma, let us demystify it.</em></strong></p>\n\n\n\n<figure class="wp-block-image size-large is-resized"><img data-attachment-id="127" data-permalink="https://educatearuralgirl.wordpress.com/earg-enigma/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg" data-orig-size="1280,853" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="earg-enigma" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=710" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=1024" alt="" class="wp-image-127" width="585" height="389" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=1024 1024w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=585 585w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=1170 1170w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=150 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=300 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg?w=768 768w" sizes="(max-width: 585px) 100vw, 585px"></figure>\n\n\n\n<p>Article by: Dolly, <em>EARG Volunteer</em></p>\n\n\n\n<p></p>\n<div id="atatags-370373-6970c7bdc8388">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	Introspection\n\n\n\nBecause menstruation is such an enigma, after 20 years of education, having graduated and learnt extensively about sexual reproductive health, having actually learnt about the importa...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/10/earg-enigma.jpeg	2019-10-20 10:20:00	[]
12	The Induction	How can we talk about rural development without talking about rural women? I believe in the potential of a rural woman to drive the rural economy which is a main contributor of a nation’s overall economic growth and development. Research shows that rural women comprise the highest percentage of individuals involved in agricultural activities. However, they are the percentage that face the highest number of setbacks in terms of social norms, cultures and traditions.\n\nFirst of all, in most African communities, rural women lack the ownership of resources such as land and other complementary agricultural inputs. This limits them in a major way in terms of access to credit facilities. I believe through collective action and social cohesion, rural women can be economically empowered into developing the rural areas, ensuring food security and promoting the economic growth and development of African economies.\n\nEARG Organization is out to invest in African rural women and girls through education and empowerment programs. EARG is on the fore front in fighting rural poverty through economic empowerment of rural women. Our Induction trainings have begun. Like a bush fire.  Be part of this great life-changing initiative. Let your voice be heard. Be the change you want. Join us in transforming our economy. One rural woman at a time.\n\nAuthor: Sally Kimathi	EARG Trainers (Stella, Sally, Immaculate) with some Kaumo Mugirirwa Women group Members \n\n\n\n How can we talk about rural development without talking about rural women? I believe in the potential of a ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg	2019-02-08 15:20:07	[]
13	At The Expense of A Rural Girl!	Honestly where do people get the introduction of an article because I have spent like an entire day trying to think but nothing that makes sense has crossed my mind so just be kind enough and forgive me.\n\nPeople either live in urban areas or in rural areas and also you are either rich or poor for now let’s ignore the middle class this is because my definition of rich is a person who can get all the basic needs:food, shelter, clothing, love and security. According to my statistics the population that lives in rural areas makes up around 80% of Kenya’s population and the poor population is also way higher than the rich population. So I want to major on the life of a rural girl who is also from a poor background. Don’t get me wrong am not gender biased or a feminist but it is just that I feel that the life of a poor rural girl is kind of unique from the rest.\n\nFirst things first, I ain’t sure that statement makes sense but bear with me, so from an early age the girl, say Angie,is trained very well by the many aunts and neighbors how to behave like a girl i.e sitting with legs put together, not climbing trees, taking care of the family basically doing the roles of a mother that she will become one day. Angie grows into a grown up baby who is then taken to school like all her brothers but now the difference comes in, in the number of chores that Angie is expected to perform at home :cooking, fetching firewood, water, vegetables for supper and also taking care of you get siblings, actually it’s not wrong to help but sometimes the duties that the girl is given especially if she comes from an extremely poor back ground are overwhelming.\n\nAngie grows into teenage hood and many different biological and physical body changes occur, she gets some hips, ass and also breasts. Now at this age is where the main challenge of being a girl from a rural area and a also from a poor background comes in, nobody talks to you about some feminine body changes e.g experiencing menstrual flow and also sex. These two topics are considered a taboo according to the African culture and this is where we go wrong. Personally I learnt about sex from my fellow age mates so basically we just taught each other. So when Angie experiences a first menstrual flow she feels dirty and insecure and is bullied by her fellow classmates. The worst happens when she messes herself because it can be traumatizing, trust me.\n\nMenstrual education is something that is very underrated. By the way, I don’t know if it’s just me but buying sanitary towels from a normal kiosk is usually something very difficult, actually it’s made worse if the shopkeeper is a man. So for our girl Angie there are times she can’t afford to buy the sanitary towel, she is forced to wear one for two days and it’s very disgusting 🤢 or use a piece of cotton cloth which is also equally disgusting. We honestly need to create more menstrual education awareness not just donating sanitary towels, we need to teach our girls the necessary hygiene, how to take care of their bodies and also how embrace our feminity. Once a person accepts themselves from within, some success is guaranteed in other aspects of life; academic and social.\n\nSupport a rural girl’s dream to become a lawyer by buying a packet of sanitary towel for her.\n\nAuthor: Gloria Micheni, Earg Volunteer	Honestly where do people get the introduction of an article because I have spent like an entire day trying to think but nothing that makes sense has crossed my mind so just be kind enough and forgive ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg	2019-01-28 16:19:19	[]
14	The Girl Who Reads…	When we first stepped foot in Ntumbara Primary School in Tharaka Nithi County, I teared up. The zeal, the determination to acquire knowledge expressed by these girls brought in so many memories of my childhood. I remembered my late grandmother ( May her soul R.I.P), and her short educational ‘chorus’, ” My loved ones, if you can’t hold a panga, hold your book, that’s your shamba!” Oh grandma, Look at us now!\n\n“Ruth, if you may please…,” Mrs. Tom called out when EARG asked for the best class 8 pupil. Ruth stood. A little shy, a little scared, a little timid. Probably wondering what the ‘slayqueens’ could possibly tell this rural girl. Unaware the ‘slayqueens’ were once upon a time fitting in her shoes and then alakadabra , Education happened and the rest is history!\n\nFor just being the best girl, Ruth got herself a revision book (encyclopedia), and a small bahasha to clear the previous years’ fee balance from EARG, and together with her colleagues,enough sanitary towels to last the entire term. This is not to leave out the candid and blunt conversations on growing up as a rural girl and menstrual hygiene.\n\nIn short, as we celebrate the #InternationalDayOfEducation, we cannot emphasize enough on the power of a girl who reads. On the opportunities awaiting a girl who seeks knowledge with all might. A girl who pursues education like her first love. For education is the premise of progress in every society, in every family. — Kofi Annan.\n\nAuthor: Sally Kimathi	When we first stepped foot in Ntumbara Primary School in Tharaka Nithi County, I teared up. The zeal, the determination to acquire knowledge expressed by these girls brought in so many memories of my ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg	2019-01-25 21:00:25	[]
15	Great Brains behind EARG.	The three EARG founders were born and\nraised in Tharaka Nithi. Despite the challenges they all faced throughout their\nchildhood, they have managed to be the best version of themselves. Read their\nbios below;\n\nMISS KATHOMI\nMURITHI\n\nMiss Kathomi\nis a 24  year old from Tharaka Nithi\ncounty. She is currently pursuing Masters in Statistics. She has Bsc. Economics\nand statistics from the Egerton University. She is passionate about statistics\nand making the world a better place.\n\nMiss Kathomi\nwas born and raised in the rural arears of Chuka. She comes from a humble\nbackground and was raised by her grandparents. She completed both her primary\nand secondary school in her county. She managed to pass her national secondary\neducation and  joined Egerton University.\nHer interests and hobbies include charity, travelling, reading and cooking.\n\nShe draws\nher inspiration from her grandmother and her mother. She believes that each day\nis an opportunity given to us to change the world and find solutions to its\nunending problems.\n\nMISS SALLY KIMATHI\n\nMiss Kimathi is a 25 year old  from Tharaka Nithi County in Kenya. She is currently pursuing collaborative masters in Agriculture and Applied economics under African Economics Research Consortium (AERC) scholarship at Egerton University and University of Pretoria in South Africa. She is also a beneficiary of SCARA APPEAR project Research grant funded by Austrian Development Corporation through Egerton and Boku University in Austria. The project aims to strengthen capacities for Agricultural education,research and adoption in Kenya.  She has a Bsc. Economics and Statistics First class Honors from Egerton University and is also an Alumni of The Kenya High school.\n\nShe is passionate about agricultural research, Big data for Agriculture, International Economics  and empowerment of rural women through agripreneurship. Having been raised by a single mum, she dreams of a nation with a woman empowered enough to conquer her own timidity and fight for her own rights. She believes in education and in the power of literacy as the main ingredients of development in every society.\n\nMISS MURUGI MUTHUNGU\n\nStella is a\n24year old born and raised in Chuka. Miss Muthungu is currently pursuing Civil\nand Structural Engineering at the University of Eldoret. She chose engineering\nfield because she was more interested in being part of the problem solvers. She\nwas privileged to be part of the 2017 Womeng fellowship where she had a\ntransformative experience. This is where she was inspired to give back to girls\nin her community after which She co-founded Wahandisi La Femme that mentors\ngirls to join STEM. She envisions a world that has an equal number of women and\nmen in STEM.\n\nShe comes\nfrom a humble background and spent most of her school holidays in Tharaka. She\nwent to Materi girls, where she received Brother John’s Scholarship in form\ntwo. She studied hard to receive the scholarship in order to reduce the burden\nof paying school fees from her parents. Her dad passed away while she was in\nform 3 and her mum has raised her since then as a single mum.\n\nIn 2018 she was awarded another scholarship by Anita Borg to attend Grace Hopper Celebration for women in computing in September at Houston, Texas.	From left Stella Muthungu, Immaculate Murithi, EARG scholar, Sally Kimathi \n\n\n\nThe three EARG founders were born and\nraised in Tharaka Nithi. Despite the challenges they all faced throughout their\nchi...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg	2019-01-22 12:11:08	[]
16	Hello BeTTeR Menstrual Days….	Menstruation is the pride of any woman or girl. It is what makes us who we are and the unique feature that every woman identifies with.Why should such a precious moment be associated with shame?why should life’s most ordinary event be termed as a taboo?These are some of the questions that every adoscelent girl in our rural areas ask themselves.Faking sickness through the mestrual days gets them off the hook to attend schools.The rate at which girls during their menstrual periods miss school is alarming. some of them fail to attend schools due to lack of ability to access proper sanitary towels that make them comfortable during the day. Menstrual poverty is still a menace to our rural adolescent girls.Menstrual poverty does not only come with lack of accesibilty to sanitary towels but also there is limited awareness to menstrual hygiene.Awareness is limited because girls are not allowed to discuss this with their elders, they are shy and see it as a wrong doing. This is why EARG’s first objective is BETTER MENSTRUAL DAYS for our rural girls in the adolescent stage.We want to instill menstrual health awareness at the early stages of adolecsent for efffective passage of knowlegde to the youngones.	Menstruation is the pride of any woman or girl. It is what makes us who we are and the unique feature that every woman identifies with.Why should such a precious moment be associated with shame?why sh...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg	2019-01-18 07:20:36	[]
17	The Journey Begins	Thanks for joining me!\n\nGood company in a journey makes the way seem shorter. — Izaak Walton	Thanks for joining me! \nGood company in a journey makes the way seem shorter. — Izaak Walton...	earg_org	https://i0.wp.com/educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/fly.jpg?fit=1200%2C797&ssl=1	2019-01-05 08:29:11	[]
18	The promise on gender equality by Kenya Kwanza: How has Tharaka Nithi County integrated thispromise in the new government?	\n\t\t\n<p class="has-text-align-justify"><br>Only two MCAs have been elected out of 15 in Tharaka Nithi County. This is despite the country’s affirmation to support women’s inclusion in positions of leadership after the county launched the gender mainstreaming policy during this year’s International Women’s Day.<br>During the event, cultural, political and socio-economic achievements of women were highlighted, anchored on the theme, Gender Equality Today for a Sustainable Tomorrow. However, these gains remain a mirage for women in Tharaka Nithi as women’s representation on the political front continue to be underrepresented. Sadly, no woman vied for a senatorial nor gubernatorial seat in the county. Only one woman vied for the Member of Parliament seat.<br>Patriarchy remains deeply entrenched disproportionately edging women out of political spaces.</p>\n\n\n\n<p class="has-text-align-justify">Culture, financial ability and lack of information has disadvantaged many women who would be interested in getting into politics. All is not lost. In its manifesto, the Kenya Kwanza administration made several promises on Gender Equality which included: placing women at the center of every decision-making process and prioritizing them in planning and execution of decisions, provide financial and capacity building support for women through the hustler fund. </p>\n\n\n\n<p class="has-text-align-justify">The fund will fully focus on how this money is distributed to women led cooperative societies, chamas, merry go rounds and table banking initiatives as they are protected from predatory interest rates charged by unscrupulous money lenders.</p>\n\n\n\n<p class="has-text-align-justify"> Educate A Rural Girl is a community- based organization that works in rural areas of Tharaka Nithi to ensure issues of gender equality are well understood and adopted at rural household level. Specifically, they empower women self-help groups to achieve economic justice, and improved their sources of income. This in turn increases participation of women at community level in issues that affect them economically. </p>\n\n\n\n<p class="has-text-align-justify">To ensure that women are fully represented, the government pledged to ensure the of the 2\\3rd gender rule, to be done through the elective and appointive positions in the public sector within 12 months of the election. This will go a long way in ensuring that more women toss themselves in the political field to ensure inclusivity in leadership is progressively achieved.</p>\n\n\n\n<p>Article by: Jiljane Makena<br>Intern at Educate A Rural Girl</p>\n\n\n\n<p>Supported by : JHR media Production</p>\n\n\n\n<p></p>\n\n\n\n<figure data-carousel-extra="{&quot;blog_id&quot;:156455679,&quot;permalink&quot;:&quot;https://educatearuralgirl.wordpress.com/2022/11/16/the-promise-on-gender-equality-by-kenya-kwanza-how-has-tharaka-nithi-county-integrated-thispromise-in-the-new-government/&quot;}" class="wp-block-gallery has-nested-images columns-default is-cropped wp-block-gallery-1 is-layout-flex wp-block-gallery-is-layout-flex">\n<figure class="wp-block-image size-large"><img data-attachment-id="180" data-permalink="https://educatearuralgirl.wordpress.com/2022/11/16/the-promise-on-gender-equality-by-kenya-kwanza-how-has-tharaka-nithi-county-integrated-thispromise-in-the-new-government/20210410120435_img_6112/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg" data-orig-size="2592,1728" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;8&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 1500D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;55&quot;,&quot;iso&quot;:&quot;100&quot;,&quot;shutter_speed&quot;:&quot;0.00625&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="20210410120435_img_6112" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=710" width="1024" height="682" data-id="180" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=1024" alt="" class="wp-image-180" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=1024 1024w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=2048 2048w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=150 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=300 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=768 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg?w=1440 1440w" sizes="(max-width: 1024px) 100vw, 1024px"></figure>\n</figure>\n<div id="atatags-370373-6970c7ba99849">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	Only two MCAs have been elected out of 15 in Tharaka Nithi County. This is despite the country’s affirmation to support women’s inclusion in positions of leadership after the county launched the gende...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/11/20210410120435_img_6112.jpg	2022-11-16 10:06:34	[]
19	Gender Equality Issues: Context of rural communities	\n\t\t\n<p class="has-text-align-justify">“Hii malinda tumevaa imefunika mambo mengi ya kijamii. Ukifunua utaona wanawake wanapitia mashida mengi sana kwenye jamii,” said Nkatha an attendee of our Gender Champions training. During our recent gender champions training we invited women from various sub-counties in Tharaka Nithi County, we trained the women and the one gentleman in attendance about the various social inequalities that women and young girls in our communities go through. We focused mostly on the women and girls since they are the minority gender, however, this does not disqualify the fact that men too face various social inequalities.</p>\n\n\n\n<p class="has-text-align-justify">We highlighted various forms of gender-based inequalities against women, the women in attendance had their own sad stories to tell which were very similar to the once I have read in some of my favorites reads this year; The girl with the louding voice, Pachinko and It ends with us.</p>\n\n\n\n<p class="has-text-align-justify">&nbsp;Adunni is the main character in the book, The Girl With The Louding Voice. She is a 14 year old girl growing up in a small village in Nigeria. She is a good student in school but she is forced to drop out of school after her mom passed away because her father could not afford to pay school fees for his children. In order for her father to be able to take care of the family he decides to marry off Adunni as a 3<sup>rd</sup> wife to a rich and old man from the neighboring village. Adunni is married off in a big traditional wedding and then she leaves her father’s house for the husband’s house who was her father’s age and had 2 other wives already. On the night of her wedding she is prepared by one of her co-wives so that she can spend the night with her new husband. Adunni who was too young to engage in sex leave alone see the naked body of a man is forced to have sex with her husband. “You are now a complete woman, tomorrow we do it again. We keep doing it until you are falling pregnant and you born a boy,” Says her husband after raping her. Adunni a young girl who had a dream a dream of becoming a teacher who drives big cars is now reduced to a child bride who will be raped frequently by her husband who is the chase for a son. This highlights some of gender based violence that we discussed during the training, that is; Harmful Traditional Practices and Sexual Violence. These two types of violence against women and girls are very common in rural areas. Young girls under go FGM, they are married off early, they are forced to drop out of school and women are also raped in their marriages by their husbands.</p>\n\n\n\n<p class="has-text-align-justify">In the book Pachinko we meet two strong women characters. The two women are strong and hardworking women who would like to engage in work to earn some money to support their families but their husbands are very much against it because it is believed that the man is supposed to take care of the family and the woman is supposed to be cleaning and cooking for the family. Their husbands are caught in a financial crisis whereby they can no longer support their families but they are not willing to allow their wives to work and earn an extra income for the family. Eventually, things get out of hand financially and the men give in into the pressure of allowing their wives to work and earn some extra income for the family. However, their husbands are the ones to be handling the money that is once they get paid they gave the money to their husbands for them to manage the money for them. Financial violence against women is not a new occurrence in our society today especially in rural areas. Many are the times where women labor hard for their money only for their husbands to take the money from them once they get paid. The attendees highlighted instances where they could invest in agriculture only for them to get back home and find that their husbands have sold their goats or a sack of maize without their knowledge. It actually gets worse since they don’t get a single cent from the proceeds of the sale of their investments. Gone are the times where women were not allowed to earn a living, to invest for themselves and to manage their money.</p>\n\n\n\n<figure class="wp-block-image size-large"><img data-attachment-id="167" data-permalink="https://educatearuralgirl.wordpress.com/2022/10/19/gender-equality-issues-context-of-rural-communities/img_1691/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg" data-orig-size="6000,4000" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;5.6&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 2000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1658369942&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;49&quot;,&quot;iso&quot;:&quot;800&quot;,&quot;shutter_speed&quot;:&quot;0.016666666666667&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="img_1691" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=710" width="1024" height="682" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=1024" alt="" class="wp-image-167" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=1024 1024w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=2048 2048w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=150 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=300 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=768 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg?w=1440 1440w" sizes="(max-width: 1024px) 100vw, 1024px"><figcaption class="wp-element-caption">A gender champion presents solutions to some gender issues faced by women in rural areas at Gender champions training held by EARG supported by CREAW -KENYA under the WVL Project</figcaption></figure>\n\n\n\n<p class="has-text-align-justify">It ends with us, a book that definitely broke my heart into small tiny pieces. Lily the main character in the book grows up witnessing her dad physically and emotionally abuse her mother. She swore that she would never find herself in a relationship like that one of her parents. But as fate would have it Lilly meets the man of her dreams, she is head of heels for him but the man is an abuser. He physically, sexually and emotionally abuses her. The worst part of it all, Lilly does not have the strength to leave the relationship in the hope that he might change one day but the man does not change. The good news is eventually she mastered the courage to leave the relationship. Lilly is among the few women who eventually master the courage to leave their abusive relationships, many women stay in the marriage hoping that one day their partners will change but by the time they decide to leave it’s too late some leave the relationships only after they inevitable (death) has happened.&nbsp; The society is partly to be blamed for it glorifies the institution of marriage so much even if the marriage is abusive, it encourages the victims to stop annoying their husbands and that way the husbands will stop abusing them. Dear women, kindly leave that abusive relationship as soon as possible. In as much as we have highlighted these forms of gender based violence using women examples, it does not mean that men do not undergo any form of gender based violence in our society. Therefore, it is important we fight for gender equality and advocate for human rights of every person irrespective of their gender.</p>\n\n\n\n<figure class="wp-block-image size-large"><img data-attachment-id="171" data-permalink="https://educatearuralgirl.wordpress.com/2022/10/19/gender-equality-issues-context-of-rural-communities/img_1987/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg" data-orig-size="6000,4000" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;4&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;Canon EOS 2000D&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1658456374&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;18&quot;,&quot;iso&quot;:&quot;800&quot;,&quot;shutter_speed&quot;:&quot;0.016666666666667&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="img_1987" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=710" width="1024" height="682" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=1024" alt="" class="wp-image-171" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=1024 1024w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=2048 2048w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=150 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=300 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=768 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1987.jpg?w=1440 1440w" sizes="(max-width: 1024px) 100vw, 1024px"><figcaption class="wp-element-caption"> Group photo for EARG Gender Champions tackling and tracking gender issues in their rural communities</figcaption></figure>\n\n\n\n<p><strong><em>ARTICLE BY: GLORIA KINYA MICHENI</em></strong></p>\n\n\n\n<p><strong><em>EARG COMMUNICATIONS AND SOCIAL MEDIA OFFICER</em></strong></p>\n\n\n\n<p></p>\n<div id="atatags-370373-6970c7bb7b246">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	“Hii malinda tumevaa imefunika mambo mengi ya kijamii. Ukifunua utaona wanawake wanapitia mashida mengi sana kwenye jamii,” said Nkatha an attendee of our Gender Champions training. During our recent ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/10/img_1691.jpg	2022-10-19 09:50:06	[]
20	PERIOD!!	\n\t\t\n<figure class="wp-block-image size-large is-resized"><img data-attachment-id="159" data-permalink="https://educatearuralgirl.wordpress.com/2022/06/03/period/image/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png" data-orig-size="1007,884" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="image" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=710" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=1007" alt="" class="wp-image-159" width="386" height="338" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=386 386w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=772 772w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=150 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=300 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png?w=768 768w" sizes="(max-width: 386px) 100vw, 386px"></figure>\n\n\n\n<p>HAPPY NEW MONTH! Where is time actually running to? It was just yesterday when we were setting our New Year’s resolutions.<br>Recently, that’s on 28th of May we celebrated the Menstrual Hygiene Day. The theme for this year’s MHD was making menstruation a normal fact of life by 2030. Honestly, speaking I would have expected that by now menstruation has been normalized, come on, it’s a biological process and over half of the world’s population will undergo menstruation one day in their lives. I feel like to older generation of women thought that by the year 2022, a lot will have changed in menstrual health. I think by now we would be expecting safe sanitary pads to be readily available for all women, come on I think the government should have ensured that sanitary pads are tax free or better we are given them for free. Sadly, that is not the case, we have unsafe sanitary pads in the market that are affecting our bodies but nothing has been done about that, we still pay tax whenever we buy our pads and the free sanitary towels the government was giving out to school going children have been reduced and in no time they might as well as stop. As a country I don’t think we are anywhere close to making menstruation a normal fact of life. I don’t know why our leaders are comfortable with us paying monthly for a biological body process that we have no control over.<br>The fact that when women buy their sanitary pads they can’t just walk with it in the supermarket aisles without getting weird stares from random strangers says a lot about how menstruation is yet to be normalized in our country. Let’s not even talk about how supermarket attendants wrap sanitary pads in 50 gazettes, what happened using paper sparingly so that we can protect the planet? Women working in offices literally carry their handbags to the washroom during that time of the month to avoid making other office members uncomfortable. It’s about time we start carrying only our pad poach to the washroom or just the pad or maybe offices should start providing sanitary pads in the offices. God forbid that you drop your sanitary pad in a public place by mistake. It is about time we stopped PERIOD SHAMING WOMEN<br>Growing up, one of my biggest fears was staining myself when I was on my period. The thought of people pointing and laughing at me was scary. In short staining myself would mean that I have embarrassed the entire female generation, come one, I am expected to be perfect and ensure that nobody is aware that am on my periods. So, no mistakes are allowed. People should know that staining yourself during your periods is PERFECTLY NORMAL.<br>We need to change the conversation around menstruation. We have young girls believing that menstruation is dirty and they should be embarrassed of themselves for experiencing periods. Institutions should take up to themselves to educate people on what menstruation is all about so that we can break all the taboos surrounding menstruation and menstrual health.<br>The only way we will able to make menstruation a normal fact of life before the year 2030, is by breaking all the taboos surrounding menstruation.</p>\n\n\n\n<p><em><strong>Author: Gloria Micheni</strong></em></p>\n<div id="atatags-370373-6970c7bc270da">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	HAPPY NEW MONTH! Where is time actually running to? It was just yesterday when we were setting our New Year’s resolutions.Recently, that’s on 28th of May we celebrated the Menstrual Hygiene Day. The t...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2022/06/image.png	2022-06-03 08:51:19	[]
23	Hello Mr.BodaBoda, Let me study!	\n\t\t\n<figure class="wp-block-image"><img data-attachment-id="107" data-permalink="https://educatearuralgirl.wordpress.com/boda-1/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg" data-orig-size="1280,960" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="boda-1" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg?w=710" width="1280" height="960" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg" alt="" class="wp-image-107" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg 1280w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg?w=150&amp;h=113 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg?w=300&amp;h=225 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg?w=768&amp;h=576 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg?w=1024&amp;h=768 1024w" sizes="(max-width: 1280px) 100vw, 1280px"></figure>\n\n\n\n<p>For so many years I&nbsp; always thought that issues of early pregnancy, early marriages and high rates of school drop outs was most common among people in the communities in arid areas I.e the pastoral communities. But I think that times have changed, I can’t really tell what happened but these three are among the major problems being faced in my home area I am trying not to generalize. The saddest part of it is that it has become so common to the extent of being overlooked by our very own leaders. I think it’s kind of clear that these problems are being experienced by the girl child.</p>\n\n\n\n<p><br>I think I am suffering from pregnancy anxiety because most of my childhood friends are mothers. Like it’s so serious to the point that you tend to think something is wrong with you. Personally I can’t really take care of myself so I am pretty sure I can’t take care of my own baby at this age but I can feel the pressure from my peers 😂😂😂. I blame this on the naivety of these girls. I was really privileged to come from a background where at least I got all basic needs and had some really strict parents. Anyone who knows my parents can testify. </p>\n\n\n\n<p>There has been too&nbsp; much of negative exposure for these rural girls to know how to handle it. For instance,  this is the Era of smartphones, make ups and clubbing. Not every girl can really afford a such, and when the<em> boda boda</em> guy comes in,  promising new phone, a pack of pads and probably a red lipstick, sex is nothing to the rural girl. She is more than willing to offer the service. Either way according to her it’s just sex nothing out of the ordinary. I believe lack of sex education for these young rural girls is a big mishap. The naivety among rural girls is underrated. We just lied to each other as we were growing up. The girl trading sex for a phone or a pack of pads is probably  in form 1 or even in primary and then boom! Pregnancy! End of school! The girl, the boda boda guy, the guardian and the society at large  are all to blame. There’s need for awareness in the rural areas. A rural girl has the right to complete her studies too.</p>\n\n\n\n<p><br>The early marriage issue is so sad. Mainstream media report it as breaking news whereas  in my village it is just any other normal <em>mushene</em>. I don’t really understand how people get married at the age of 14. When I was 14 was still a young handsome boy with nothing to offer to a man. By the time this young girl is around 25 she will be looking double her age. But parents are also becoming so greedy with money, like how do you marry off your girl at the age of 14. When will she study? When will the rural girl finish her education? I thought she is the one who is supposed to take care of you when you are all old and tired but instead you end up raising your grandchildren. <br>And these <em>boda boda</em> lads, why can’t you just let our girls study in peace? I mean some of these <em>boda boda</em> guys had an opportunity to study but instead dropped out to do them <em>boda</em>  rounds. It’s not like <em>boda</em> business is not important but really let a girl learn. Stop lying to her. Let her curve her own destiny. Stop dictating it with your meagre savings. Instead use that money for self development. Or rather get her a revision book and a packet of pads without demanding for sex if at all you have to. My point is, LET A RURAL GIRL STUDY! </p>\n\n\n\n<figure class="wp-block-image"><img data-attachment-id="105" data-permalink="https://educatearuralgirl.wordpress.com/boda/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg" data-orig-size="1280,960" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="boda" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg?w=710" width="1280" height="960" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg" alt="" class="wp-image-105" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg 1280w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg?w=150&amp;h=113 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg?w=300&amp;h=225 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg?w=768&amp;h=576 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda.jpg?w=1024&amp;h=768 1024w" sizes="(max-width: 1280px) 100vw, 1280px"></figure>\n\n\n\n<p></p>\n\n\n\n<p>Author: Gloria Micheni</p>\n\n\n\n<p><em>Earg Volunteer</em></p>\n\n\n\n<p></p>\n<div id="atatags-370373-6970c7be736fc">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	For so many years I  always thought that issues of early pregnancy, early marriages and high rates of school drop outs was most common among people in the communities in arid areas I.e the pastoral co...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/03/boda-1.jpg	2019-03-04 19:13:30	[]
24	The Induction	\n\t\t\n<figure class="wp-block-image"><img data-attachment-id="51" data-permalink="https://educatearuralgirl.wordpress.com/induction/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg" data-orig-size="1280,960" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="induction" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg?w=710" width="1280" height="960" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg" alt="" class="wp-image-51" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg 1280w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg?w=150&amp;h=113 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg?w=300&amp;h=225 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg?w=768&amp;h=576 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg?w=1024&amp;h=768 1024w" sizes="(max-width: 1280px) 100vw, 1280px"><figcaption> <br><em>EARG Trainers (Stella, Sally, Immaculate) with some Kaumo Mugirirwa Women group Members </em></figcaption></figure>\n\n\n\n<p> How can we talk about rural development without talking about rural women? I believe in the potential of a rural woman to drive the rural economy which is a main contributor of a nation’s overall economic growth and development. Research shows that rural women comprise the highest percentage of individuals involved in agricultural activities. However, they are the percentage that face the highest number of setbacks in terms of social norms, cultures and traditions. </p>\n\n\n\n<p>First of all, in most African communities, rural women lack the ownership of resources such as land and other complementary agricultural inputs. This limits them in a major way in terms of access to credit facilities. I believe through collective action and social cohesion, rural women can be economically empowered into developing the rural areas, ensuring food security and promoting the economic growth and development of African economies. </p>\n\n\n\n<figure class="wp-block-image is-resized"><img data-attachment-id="52" data-permalink="https://educatearuralgirl.wordpress.com/stl-induction/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg" data-orig-size="1280,960" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="stl-induction" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg?w=710" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg" alt="" class="wp-image-52" width="449" height="337" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg?w=449&amp;h=337 449w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg?w=898&amp;h=674 898w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg?w=150&amp;h=113 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg?w=300&amp;h=225 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/stl-induction.jpg?w=768&amp;h=576 768w" sizes="(max-width: 449px) 100vw, 449px"><figcaption><em>EARG Trainers (Stella, Sally, Immaculate) with some Kaumo Mugirirwa Women group Members </em></figcaption></figure>\n\n\n\n<p>EARG Organization is out to invest in African rural women and girls through education and empowerment programs. EARG is on the fore front in fighting rural poverty through economic empowerment of rural women. Our Induction trainings have begun. Like a bush fire.  Be part of this great life-changing initiative. Let your voice be heard. Be the change you want. Join us in transforming our economy. One rural woman at a time.</p>\n\n\n\n<figure class="wp-block-image is-resized"><img data-attachment-id="53" data-permalink="https://educatearuralgirl.wordpress.com/induction-talk/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg" data-orig-size="1040,780" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="induction-talk" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg?w=710" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg" alt="" class="wp-image-53" width="492" height="369" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg?w=492&amp;h=369 492w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg?w=984&amp;h=738 984w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg?w=150&amp;h=112 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg?w=300&amp;h=225 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction-talk.jpg?w=768&amp;h=576 768w" sizes="(max-width: 492px) 100vw, 492px"><figcaption><em>EARG Trainers and the Queens</em></figcaption></figure>\n\n\n\n<p></p>\n\n\n\n<p></p>\n\n\n\n<p>Author: Sally Kimathi</p>\n<div id="atatags-370373-6970c7bfaecff">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	EARG Trainers (Stella, Sally, Immaculate) with some Kaumo Mugirirwa Women group Members \n\n\n\n How can we talk about rural development without talking about rural women? I believe in the potential of a ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/02/induction.jpg	2019-02-08 15:20:07	[]
25	At The Expense of A Rural Girl!	\n\t\t\n<p>Honestly where do people get the introduction of an article because I have spent like an entire day trying to think but nothing that makes sense has crossed my mind so just be kind enough and forgive me. </p>\n\n\n\n<p>People either live in urban areas or in rural areas and also you are either rich or poor for now let’s ignore the middle class this is because my definition of rich is a person who can get all the basic needs:food, shelter, clothing, love and security. According to my statistics the population that lives in rural areas makes up around 80% of Kenya’s population and the poor population is also way higher than the rich population. So I want to major on the life of a rural girl who is also from a poor background. Don’t get me wrong am not gender biased or a feminist but it is just that I feel that the life of a poor rural girl is kind of unique from the rest.</p>\n\n\n\n<p><br>First things first, I ain’t sure that statement makes sense but bear with me, so from an early age the girl, say Angie,is trained very well by the many aunts and neighbors how to behave like a girl i.e sitting with legs put together, not climbing trees, taking care of the family basically doing the roles of a mother that she will become one day. Angie grows into a grown up baby who is then taken to school like all her brothers but now the difference comes in, in the number of chores that Angie is expected to perform at home :cooking, fetching firewood, water, vegetables for supper and also taking care of you get siblings, actually it’s not wrong to help but sometimes the duties that the girl is given especially if she comes from an extremely poor back ground are overwhelming. </p>\n\n\n\n<p>Angie grows into teenage hood and many different biological and physical body changes occur, she gets some hips, ass and also breasts. Now at this age is where the main challenge of being a girl from a rural area and a also from a poor background comes in, nobody talks to you about some feminine body changes e.g experiencing menstrual flow and also sex. These two topics are considered a taboo according to the African culture and this is where we go wrong. Personally I learnt about sex from my fellow age mates so basically we just taught each other. So when Angie experiences a first menstrual flow she feels dirty and insecure and is bullied by her fellow classmates. The worst happens when she messes herself because it can be traumatizing, trust me. </p>\n\n\n\n<p>Menstrual education is something that is very underrated. By the way, I don’t know if it’s just me but buying sanitary towels from a normal kiosk is usually something very difficult, actually it’s made worse if the shopkeeper is a man. So for our girl Angie there are times she can’t afford to buy the sanitary towel, she is forced to wear one for two days and it’s very disgusting 🤢 or use a piece of cotton cloth which is also equally disgusting. We honestly need to create more menstrual education awareness not just donating sanitary towels, we need to teach our girls the necessary hygiene, how to take care of their bodies and also how embrace our feminity. Once a person accepts themselves from within, some success is guaranteed in other aspects of life; academic and social. </p>\n\n\n\n<p> Support a rural girl’s dream to become a lawyer by buying a packet of sanitary towel for her.</p>\n\n\n\n<p>  Author: Gloria Micheni, <em>Earg Volunteer</em></p>\n\n\n\n<figure class="wp-block-image"><img data-attachment-id="48" data-permalink="https://educatearuralgirl.wordpress.com/glo/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg" data-orig-size="960,1280" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="glo" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg?w=225" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg?w=710" width="960" height="1280" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg" alt="" class="wp-image-48" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg 960w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg?w=113&amp;h=150 113w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg?w=225&amp;h=300 225w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg?w=768&amp;h=1024 768w" sizes="(max-width: 960px) 100vw, 960px"></figure>\n\n\n\n<p></p>\n<div id="atatags-370373-6970c7c086412">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	Honestly where do people get the introduction of an article because I have spent like an entire day trying to think but nothing that makes sense has crossed my mind so just be kind enough and forgive ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/glo.jpg	2019-01-28 16:19:19	[]
26	The Girl Who Reads…	\n\t\t\n<p>When we first stepped foot in Ntumbara Primary School in Tharaka Nithi County, I teared up. The zeal, the determination to acquire knowledge expressed by these girls brought in so many memories of my childhood. I remembered my late grandmother ( May her soul R.I.P), and her short educational ‘chorus’, ” My loved ones, if you can’t hold a panga, hold your book, that’s your shamba!” Oh grandma, Look at us now!</p>\n\n\n\n<figure class="wp-block-image"><img data-attachment-id="38" data-permalink="https://educatearuralgirl.wordpress.com/girls-in-class/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg" data-orig-size="1232,816" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;1547238349&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;1&quot;}" data-image-title="girls-in-class" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg?w=710" width="1232" height="816" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg" alt="" class="wp-image-38" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg 1232w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg?w=150&amp;h=99 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg?w=300&amp;h=199 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg?w=768&amp;h=509 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/girls-in-class.jpg?w=1024&amp;h=678 1024w" sizes="(max-width: 1232px) 100vw, 1232px"><figcaption><em>Class 6,7,8 Ntumbara Pry Girls</em></figcaption></figure>\n\n\n\n<p>“Ruth, if you may please…,” Mrs. Tom called out when EARG asked for the best class 8 pupil. Ruth stood. A little shy, a little scared, a little timid. Probably wondering what the ‘slayqueens’ could possibly tell this rural girl. Unaware the ‘slayqueens’ were once upon a time fitting in her shoes and then <em>alakadabra</em> , Education happened and the rest is history!</p>\n\n\n\n<p></p>\n\n\n\n<ul data-carousel-extra="{&quot;blog_id&quot;:156455679,&quot;permalink&quot;:&quot;https://educatearuralgirl.wordpress.com/2019/01/25/the-girl-who-reads/&quot;}" class="wp-block-gallery columns-3 is-cropped wp-block-gallery-1 is-layout-flex wp-block-gallery-is-layout-flex"><li class="blocks-gallery-item"><figure><img data-attachment-id="39" data-permalink="https://educatearuralgirl.wordpress.com/ruth/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg" data-orig-size="1232,816" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="ruth" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg?w=710" width="1232" height="816" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg" alt="" data-id="39" data-link="https://educatearuralgirl.wordpress.com/ruth/" class="wp-image-39" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg 1232w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg?w=150&amp;h=99 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg?w=300&amp;h=199 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg?w=768&amp;h=509 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg?w=1024&amp;h=678 1024w" sizes="(max-width: 1232px) 100vw, 1232px"><figcaption><em>Ruth, Mrs.Tom and EARG team</em></figcaption></figure></li><li class="blocks-gallery-item"><figure><img data-attachment-id="40" data-permalink="https://educatearuralgirl.wordpress.com/ruth-2/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg" data-orig-size="1232,816" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="ruth-2" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg?w=710" width="1232" height="816" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg" alt="" data-id="40" data-link="https://educatearuralgirl.wordpress.com/ruth-2/" class="wp-image-40" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg 1232w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg?w=150&amp;h=99 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg?w=300&amp;h=199 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg?w=768&amp;h=509 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth-2.jpg?w=1024&amp;h=678 1024w" sizes="(max-width: 1232px) 100vw, 1232px"></figure></li><li class="blocks-gallery-item"><figure><img data-attachment-id="41" data-permalink="https://educatearuralgirl.wordpress.com/ruth3/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg" data-orig-size="1232,816" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="ruth3" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg?w=710" loading="lazy" width="1232" height="816" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg" alt="" data-id="41" data-link="https://educatearuralgirl.wordpress.com/ruth3/" class="wp-image-41" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg 1232w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg?w=150&amp;h=99 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg?w=300&amp;h=199 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg?w=768&amp;h=509 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth3.jpg?w=1024&amp;h=678 1024w" sizes="(max-width: 1232px) 100vw, 1232px"><figcaption><em>Ruth</em></figcaption></figure></li></ul>\n\n\n\n<p>For just being the best girl, Ruth got herself a revision book (encyclopedia), and a small <em>bahasha</em> to clear the previous years’ fee balance from EARG, and together with her colleagues,enough sanitary towels to last the entire term. This is not to leave out the candid and blunt conversations on growing up as a rural girl and menstrual hygiene.</p>\n\n\n\n<p>In short, as we celebrate the #InternationalDayOfEducation, we cannot emphasize enough on the power of a girl who reads. On the opportunities awaiting a girl who seeks knowledge with all might. A girl who pursues education like her first love. For education is the premise of progress in every society, in every family. — Kofi Annan.</p>\n\n\n\n<p></p>\n\n\n\n<p></p>\n\n\n\n<p></p>\n\n\n\n<p>Author: Sally Kimathi</p>\n<div id="atatags-370373-6970c7c13c978">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	When we first stepped foot in Ntumbara Primary School in Tharaka Nithi County, I teared up. The zeal, the determination to acquire knowledge expressed by these girls brought in so many memories of my ...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ruth.jpg	2019-01-25 21:00:25	[]
27	Great Brains behind EARG.	\n\t\t\n<figure class="wp-block-image"><img data-attachment-id="32" data-permalink="https://educatearuralgirl.wordpress.com/img-20190111-wa0126/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg" data-orig-size="1280,960" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="img-20190111-wa0126" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg?w=710" width="1280" height="960" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg" alt="" class="wp-image-32" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg 1280w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg?w=150&amp;h=113 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg?w=300&amp;h=225 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg?w=768&amp;h=576 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg?w=1024&amp;h=768 1024w" sizes="(max-width: 1280px) 100vw, 1280px"><figcaption> <br>From left Stella Muthungu, Immaculate Murithi, EARG scholar, Sally Kimathi </figcaption></figure>\n\n\n\n<p>The three EARG founders were born and\nraised in Tharaka Nithi. Despite the challenges they all faced throughout their\nchildhood, they have managed to be the best version of themselves. Read their\nbios below;</p>\n\n\n\n<p></p>\n\n\n\n<p>MISS KATHOMI\nMURITHI</p>\n\n\n\n<p>Miss Kathomi\nis a 24&nbsp; year old from Tharaka Nithi\ncounty. She is currently pursuing Masters in Statistics. She has Bsc. Economics\nand statistics from the Egerton University. She is passionate about statistics\nand making the world a better place.</p>\n\n\n\n<p>Miss Kathomi\nwas born and raised in the rural arears of Chuka. She comes from a humble\nbackground and was raised by her grandparents. She completed both her primary\nand secondary school in her county. She managed to pass her national secondary\neducation and &nbsp;joined Egerton University.\nHer interests and hobbies include charity, travelling, reading and cooking. </p>\n\n\n\n<p>She draws\nher inspiration from her grandmother and her mother. She believes that each day\nis an opportunity given to us to change the world and find solutions to its\nunending problems.</p>\n\n\n\n<figure class="wp-block-image"><img data-attachment-id="30" data-permalink="https://educatearuralgirl.wordpress.com/imm/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/imm.jpg" data-orig-size="720,756" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="imm" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/imm.jpg?w=286" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/imm.jpg?w=710" width="720" height="756" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/imm.jpg" alt="" class="wp-image-30" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/imm.jpg 720w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/imm.jpg?w=143&amp;h=150 143w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/imm.jpg?w=286&amp;h=300 286w" sizes="(max-width: 720px) 100vw, 720px"></figure>\n\n\n\n<p>MISS SALLY KIMATHI</p>\n\n\n\n<p>Miss Kimathi is a 25 year old  from Tharaka Nithi County in Kenya. She is currently pursuing collaborative masters in Agriculture and Applied economics under African Economics Research Consortium (AERC) scholarship at Egerton University and University of Pretoria in South Africa. She is also a beneficiary of SCARA APPEAR project Research grant funded by Austrian Development Corporation through Egerton and Boku University in Austria. The project aims to strengthen capacities for Agricultural education,research and adoption in Kenya.  She has a Bsc. Economics and Statistics First class Honors from Egerton University and is also an Alumni of The Kenya High school. </p>\n\n\n\n<p>She is passionate about agricultural research, Big data for Agriculture, International Economics  and empowerment of rural women through agripreneurship. Having been raised by a single mum, she dreams of a nation with a woman empowered enough to conquer her own timidity and fight for her own rights. She believes in education and in the power of literacy as the main ingredients of development in every society.</p>\n\n\n\n<p></p>\n\n\n\n<figure class="wp-block-image"><img data-attachment-id="31" data-permalink="https://educatearuralgirl.wordpress.com/sal/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/sal.jpg" data-orig-size="719,724" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="sal" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/sal.jpg?w=298" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/sal.jpg?w=710" width="719" height="724" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/sal.jpg" alt="" class="wp-image-31" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/sal.jpg 719w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/sal.jpg?w=150&amp;h=150 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/sal.jpg?w=298&amp;h=300 298w" sizes="(max-width: 719px) 100vw, 719px"></figure>\n\n\n\n<p>MISS MURUGI MUTHUNGU </p>\n\n\n\n<p>Stella is a\n24year old born and raised in Chuka. Miss Muthungu is currently pursuing Civil\nand Structural Engineering at the University of Eldoret. She chose engineering\nfield because she was more interested in being part of the problem solvers. She\nwas privileged to be part of the 2017 Womeng fellowship where she had a\ntransformative experience. This is where she was inspired to give back to girls\nin her community after which She co-founded Wahandisi La Femme that mentors\ngirls to join STEM. She envisions a world that has an equal number of women and\nmen in STEM.&nbsp;&nbsp; </p>\n\n\n\n<p>She comes\nfrom a humble background and spent most of her school holidays in Tharaka. She\nwent to Materi girls, where she received Brother John’s Scholarship in form\ntwo. She studied hard to receive the scholarship in order to reduce the burden\nof paying school fees from her parents. Her dad passed away while she was in\nform 3 and her mum has raised her since then as a single mum.&nbsp; </p>\n\n\n\n<p>In 2018 she was awarded another scholarship by Anita Borg to attend Grace Hopper Celebration for women in computing in September at Houston, Texas.</p>\n\n\n\n<figure class="wp-block-image"><img data-attachment-id="33" data-permalink="https://educatearuralgirl.wordpress.com/ste/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ste.jpg" data-orig-size="731,731" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="ste" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ste.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ste.jpg?w=710" loading="lazy" width="731" height="731" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ste.jpg" alt="" class="wp-image-33" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ste.jpg 731w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ste.jpg?w=150&amp;h=150 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/ste.jpg?w=300&amp;h=300 300w" sizes="(max-width: 731px) 100vw, 731px"></figure>\n<div id="atatags-370373-6970c7c2b88d9">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	From left Stella Muthungu, Immaculate Murithi, EARG scholar, Sally Kimathi \n\n\n\nThe three EARG founders were born and\nraised in Tharaka Nithi. Despite the challenges they all faced throughout their\nchi...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0126.jpg	2019-01-22 12:11:08	[]
28	Hello BeTTeR Menstrual Days….	\n\t\t\n<p style="text-align:left;">Menstruation is the pride of any woman or girl. It is what makes us who we are and the unique feature that every woman identifies with.Why should such a precious moment be associated with shame?why should life’s most ordinary event be termed as a taboo?These are some of the questions that every adoscelent girl in our rural areas ask themselves.Faking sickness through the mestrual days gets them off the hook to attend schools.The rate at which girls during their menstrual periods miss school is alarming. some of them fail to attend schools due to lack of ability to access proper sanitary towels that make them comfortable during the day. Menstrual poverty is still a menace to our rural adolescent girls.Menstrual poverty does not only come with lack of accesibilty to sanitary towels but also there is limited awareness to menstrual hygiene.Awareness is limited because girls are not allowed to discuss this with their elders, they are shy and see it as a wrong doing. This is why EARG’s first objective is BETTER MENSTRUAL DAYS for our rural girls in the adolescent stage.We want to instill menstrual health awareness at the early stages of adolecsent for efffective passage of knowlegde to the youngones. </p>\n\n\n\n<figure class="wp-block-image"><img data-attachment-id="23" data-permalink="https://educatearuralgirl.wordpress.com/img-20190111-wa0030-1/" data-orig-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg" data-orig-size="1280,960" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="img-20190111-wa0030-1" data-image-description="" data-image-caption="" data-medium-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg?w=300" data-large-file="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg?w=710" width="1280" height="960" src="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg" alt="" class="wp-image-23" srcset="https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg 1280w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg?w=150&amp;h=113 150w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg?w=300&amp;h=225 300w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg?w=768&amp;h=576 768w, https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg?w=1024&amp;h=768 1024w" sizes="(max-width: 1280px) 100vw, 1280px"><figcaption>EARG first donation#endmenstrualpoverty</figcaption></figure>\n\n\n<div id="atatags-370373-6970c7c3623da">\n\t\t\n\t</div><span id="wordads-inline-marker" style="display: none;"></span>\t	Menstruation is the pride of any woman or girl. It is what makes us who we are and the unique feature that every woman identifies with.Why should such a precious moment be associated with shame?why sh...	earg_org	https://educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/img-20190111-wa0030-1.jpg	2019-01-18 07:20:36	[]
29	The Journey Begins	\n\t\t<p>Thanks for joining me! </p>\n<blockquote><p>Good company in a journey makes the way seem shorter. — Izaak Walton</p></blockquote>\n<p><img class="wp-image-7 size-full" src="https://twentysixteendemo.files.wordpress.com/2015/11/post.png?w=710" alt="post"></p>\n<span id="wordads-inline-marker" style="display: none;"></span>\t	Thanks for joining me! \nGood company in a journey makes the way seem shorter. — Izaak Walton...	earg_org	https://i0.wp.com/educatearuralgirl.wordpress.com/wp-content/uploads/2019/01/fly.jpg?fit=1200%2C797&ssl=1	2019-01-05 08:29:11	[]
\.


--
-- Data for Name: gallery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gallery (id, url, caption) FROM stdin;
1	http://localhost:5000/uploads/image-1767525072848-322595305.png	New Image
2	http://localhost:5000/uploads/image-1767525078031-826098512.png	New Image
3	http://localhost:5000/uploads/image-1767525084172-356356246.png	New Image
4	http://localhost:5000/uploads/image-1767525092639-895332745.png	New Image
5	http://localhost:5000/uploads/image-1767525098714-297095173.png	New Image
7	https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771835150/educate_a_girl/j1g7rmmowmtbxy0twq5g.jpg	New Image
\.


--
-- Data for Name: journey; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.journey (id, year, title, description) FROM stdin;
1	2013	Started STEM mentorship sessions in schools	
2	2018	Formally registered as a Community Based organization in Tharaka Nithi County	
3	2019	Started education and economic empowerment activities in Tharaka Nithi County	
4	2020-2025	Implemented activities in Partnership with Akili Dada, KENDAT, CREAW, Swedish Embassy	
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.messages (id, name, email, message, date, read) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, items, total, status, customer_info, date) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, name, price, category, rating, reviews, description, material, dimensions, origin, impact, details, story, images, stock, offer_price) FROM stdin;
d1	Sanitary Pads - 6 Month Supply	15.00	Donation	\N	\N	Provide a girl with essential sanitary products for 6 months, ensuring she can attend school with dignity and confidence during her menstrual cycle.	\N	\N	\N	Keeps 1 girl in school for 6 months	{"icon": "health_and_safety", "duration": "6 months", "subCategory": "Hygiene", "beneficiaries": "1 girl"}	\N	["https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=800&q=80"]	999999	\N
d2	Complete School Supplies Kit	25.00	Donation	\N	\N	A comprehensive kit including notebooks, pens, pencils, erasers, rulers, and a geometry set. Everything a student needs for a full academic year.	\N	\N	\N	Equips 1 student for an entire school year	{"icon": "school_supplies", "duration": "1 year", "subCategory": "Education", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1606326608606-aa0b62935f2b?w=800&q=80"]	999999	\N
d3	School Uniform Set	35.00	Donation	\N	\N	A complete school uniform including shirt, skirt/trousers, and sweater. Helps students attend school with dignity and meet dress code requirements.	\N	\N	\N	Provides proper school attire for 1 student	{"icon": "checkroom", "duration": "1 year", "subCategory": "Education", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=800&q=80"]	999999	\N
d4	Textbook Set - Primary Level	45.00	Donation	\N	\N	Essential textbooks for primary school subjects including Mathematics, English, Science, and Social Studies.	\N	\N	\N	Provides learning materials for 1 student	{"icon": "menu_book", "duration": "1 year", "subCategory": "Education", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=800&q=80"]	999999	\N
d5	Hygiene Kit	20.00	Donation	\N	\N	Personal hygiene essentials including soap, toothbrush, toothpaste, towel, and basic first aid supplies.	\N	\N	\N	Promotes health and hygiene for 1 girl	{"icon": "soap", "duration": "3 months", "subCategory": "Hygiene", "beneficiaries": "1 girl"}	\N	["https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=800&q=80"]	999999	\N
d6	School Backpack	18.00	Donation	\N	\N	Durable, water-resistant backpack with multiple compartments for books, supplies, and personal items.	\N	\N	\N	Helps 1 student carry supplies safely	{"icon": "backpack", "duration": "2 years", "subCategory": "Education", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&q=80"]	999999	\N
d7	Sanitary Pads - 1 Year Supply	28.00	Donation	\N	\N	A full year's supply of sanitary pads, ensuring uninterrupted school attendance throughout the academic year.	\N	\N	\N	Keeps 1 girl in school for 1 full year	{"icon": "health_and_safety", "duration": "1 year", "subCategory": "Hygiene", "beneficiaries": "1 girl"}	\N	["https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=800&q=80"]	999999	\N
d8	Scientific Calculator	22.00	Donation	\N	\N	Essential scientific calculator for mathematics and science subjects at secondary school level.	\N	\N	\N	Enables advanced learning for 1 student	{"icon": "calculate", "duration": "4 years", "subCategory": "Education", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=800&q=80"]	999999	\N
d9	Art Supplies Bundle	30.00	Donation	\N	\N	Encourage creativity with colored pencils, crayons, paint sets, brushes, and drawing paper.	\N	\N	\N	Nurtures creativity for 1 student	{"icon": "palette", "duration": "1 year", "subCategory": "Education", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=800&q=80"]	999999	\N
d10	Sports Equipment Kit	40.00	Donation	\N	\N	Promote physical health with sports equipment including a soccer ball, jump rope, and athletic shoes.	\N	\N	\N	Encourages physical activity for 1 student	{"icon": "sports_soccer", "duration": "1 year", "subCategory": "Wellness", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=800&q=80"]	999999	\N
d11	Reusable Water Bottle & Lunch Box	12.00	Donation	\N	\N	Eco-friendly water bottle and lunch box to ensure proper nutrition and hydration during school hours.	\N	\N	\N	Supports daily nutrition for 1 student	{"icon": "lunch_dining", "duration": "2 years", "subCategory": "Wellness", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=800&q=80"]	999999	\N
d12	Reading Books Collection	35.00	Donation	\N	\N	A curated collection of age-appropriate storybooks and educational readers to foster a love of reading.	\N	\N	\N	Builds literacy skills for 1 student	{"icon": "auto_stories", "duration": "Permanent", "subCategory": "Education", "beneficiaries": "1 student"}	\N	["https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800&q=80"]	999999	\N
prod_1771488897300	aa	23.00	General	5.0	0	111	11				[]	{}	[]	111	11.00
prod_1771489021621	aa	12.00	General	5.0	0						[]	{}	["https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771489013/educate_a_girl/y2lr0ry1tnpiwpbfd7db.jpg"]	12	\N
prod_1771489309855	ww	2.00	General	5.0	0	222	22				[]	{}	[]	19	\N
\.


--
-- Data for Name: programs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.programs (id, title, description, image, features, header, dropdown_title) FROM stdin;
198	Agribusiness & Economic Empowerment 	Building the capacity of women’s self-help groups in agribusiness and financial literacy.	https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771493857/educate_a_girl/z6e67gdrqw1vytpycrcb.jpg	["We strengthen the capacity of rural women and women’s self-help groups to engage in sustainable agribusiness and income-generating activities. Through practical training in agribusiness skills, entrepreneurship, and financial literacy, we support women to increase productivity, manage finances effectively, and build resilient livelihoods that improve household wellbeing and economic independence."]		Agribusiness & Economic Empowerment 
199	Advocacy on Gender Equality in Education	ngaging communities, schools, and media to promote gender equality.	https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771493927/educate_a_girl/yay2vi3di3s80tf3cpix.jpg	["We work with communities, schools, and media to challenge harmful norms and promote equal access to education for girls. Through advocacy and awareness, we amplify girls’ voices, influence positive attitudes, and create supportive environments where every child can learn and thrive equally."]		Advocacy on Gender Equality in Education
200	SRHR Awareness	Running school projects, menstrual health programs (#EndPeriodPoverty), and girl mentorship sessions.	https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771493991/educate_a_girl/skuyqffgp8uvtkskz2ej.jpg	["We promote sexual and reproductive health and rights through school-based programs, menstrual health initiatives under #EndPeriodPoverty, and girl mentorship sessions. By providing accurate information, safe spaces, and essential support, we empower girls to manage their health with dignity, confidence, and agency—ensuring they stay in school and thrive."]		SRHR Awareness
201	Climate Change Action	Promoting climate change awareness and adaptation through programs such as Unga Bora, Basket of Stories, and land restoration initiatives.	https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771494072/educate_a_girl/iq0vrtfq6v5gwo97m9kg.jpg	["We advance climate change awareness and adaptation through initiatives such as Unga Bora, Basket of Stories, and land restoration programs. By promoting climate-smart practices and environmental stewardship, we strengthen food security, protect livelihoods, and build resilient rural communities in the face of climate change."]		Climate Change Action
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews (id, product_id, rating, comment, author, status, date) FROM stdin;
1	prod_1771489021621	5	testing	stella	approved	2026-03-27 18:49:33.340835
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.settings (key, value) FROM stdin;
vision	"A society where empowered rural women lead positive and sustainable change."
mission	"To educate, mentor and inspire the community to create an ecosystem that supports the holistic development of girls enabling the to realize their full potential"
values	[{"desc": "Embracing new ideas to solve challenges.", "icon": "lightbulb", "title": "Innovative"}, {"desc": "Operating with honesty and transparency.", "icon": "verified_user", "title": "Integrity"}, {"desc": "Focusing on tangible, lasting results.", "icon": "ads_click", "title": "Impact"}, {"desc": "Ensuring no one is left behind.", "icon": "diversity_3", "title": "Inclusion"}, {"desc": "Empowering others to dream big.", "icon": "auto_awesome", "title": "Inspiration"}]
impact_stats	[]
home_products	["prod_1771488897300"]
categories	["General", "Donation", "22"]
contact_info	{"email": "earg.org@gmail.com", "phone": "+254 719 681 844", "address": "Tharaka Nithi County, Kenya", "twitter": "https://x.com/Earg13", "facebook": "https://web.facebook.com/100067539421860/posts/educate-a-rural-girl-seeks-to-procure-the-services-of-a-strategic-planner-to-co-/736125118648796/?_rdc=1&_rdr#", "instagram": ""}
home_hero	{"image": "https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771494313/educate_a_girl/pn1kfj9fo105usnh3pde.jpg", "title": "Empowering Rural Girls", "subtitle": "Building a sustainable future through education and leadership."}
programs_images	{"hero_bg": "https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771836357/educate_a_girl/tnqhyafean3ok5ozrebn.jpg"}
about_images	{"hero_bg": "", "shop_bg": "https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771836389/educate_a_girl/apdue5vncjryh4qrloo3.jpg"}
about_hero	{"image": "https://res.cloudinary.com/dr3qyfxs7/image/upload/v1771494639/educate_a_girl/pidibgtn7y7wjkb1b7cm.jpg", "title": "About EARG", "subtitle": "Educate A Rural Girl Organization (EARG) is a community-based organization that exists to empower women and girls from rural areas of Tharaka Nithi County to be agents of change in their communities while advocating for equality, inclusion, and sustainable development."}
\.


--
-- Data for Name: stories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stories (id, name, role, image, quote, featured) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.team (id, name, role, image) FROM stdin;
1	Sally Kimathi 	Finance Director	http://localhost:5000/uploads/image-1767525148356-352510089.png
3	Stella Muthungu 	Programs Director	http://localhost:5000/uploads/image-1767525203415-155748019.png
2	Immaculate Kathomi 	Executive Director	http://localhost:5000/uploads/image-1767525175488-409771263.png
4	Kelvin Muthomi	 Programs Officer	http://localhost:5000/uploads/image-1767525236396-759932465.png
\.


--
-- Data for Name: wishlist; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wishlist (id, session_id, product_id, created_at) FROM stdin;
\.


--
-- Name: awards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.awards_id_seq', 3, true);


--
-- Name: basket_donations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.basket_donations_id_seq', 1, false);


--
-- Name: basket_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.basket_items_id_seq', 6, true);


--
-- Name: blog_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_posts_id_seq', 4, true);


--
-- Name: blogs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blogs_id_seq', 29, true);


--
-- Name: gallery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gallery_id_seq', 7, true);


--
-- Name: journey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.journey_id_seq', 4, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.programs_id_seq', 201, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, true);


--
-- Name: stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stories_id_seq', 1, false);


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.team_id_seq', 4, true);


--
-- Name: wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wishlist_id_seq', 1, false);


--
-- Name: awards awards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.awards
    ADD CONSTRAINT awards_pkey PRIMARY KEY (id);


--
-- Name: basket_donations basket_donations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_donations
    ADD CONSTRAINT basket_donations_pkey PRIMARY KEY (id);


--
-- Name: basket_items basket_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_items
    ADD CONSTRAINT basket_items_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_slug_key UNIQUE (slug);


--
-- Name: blogs blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT blogs_pkey PRIMARY KEY (id);


--
-- Name: gallery gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gallery
    ADD CONSTRAINT gallery_pkey PRIMARY KEY (id);


--
-- Name: journey journey_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journey
    ADD CONSTRAINT journey_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: programs programs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: stories stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: wishlist wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_pkey PRIMARY KEY (id);


--
-- Name: wishlist wishlist_session_id_product_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_session_id_product_id_key UNIQUE (session_id, product_id);


--
-- Name: basket_donations basket_donations_basket_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_donations
    ADD CONSTRAINT basket_donations_basket_item_id_fkey FOREIGN KEY (basket_item_id) REFERENCES public.basket_items(id) ON DELETE CASCADE;


--
-- Name: wishlist wishlist_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

