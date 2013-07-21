--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    name character varying(255),
    title character varying(255),
    team character varying(255),
    ancestry character varying(255),
    contactable_id integer,
    contactable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider_id integer
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contracts (
    id integer NOT NULL,
    partner_id integer,
    customer_id integer,
    expiry_date date,
    start_date date,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider_id integer
);


--
-- Name: contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contracts_id_seq OWNED BY contracts.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE customers (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying(255),
    provider_id integer,
    temperature integer DEFAULT 0,
    auto_temp boolean DEFAULT true,
    current_heatmap hstore,
    short_name character varying(255)
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: heat_histories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE heat_histories (
    id integer NOT NULL,
    year integer,
    week integer,
    temperature hstore,
    entity_id integer,
    entity_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: heat_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE heat_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: heat_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE heat_histories_id_seq OWNED BY heat_histories.id;


--
-- Name: heat_logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE heat_logs (
    id integer NOT NULL,
    transaction_date date,
    entity_type character varying(255),
    entity_id integer,
    temperature integer,
    measure_id integer,
    provider_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: heat_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE heat_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: heat_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE heat_logs_id_seq OWNED BY heat_logs.id;


--
-- Name: invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE invites (
    id integer NOT NULL,
    user_id integer,
    provider_id integer,
    invitee_email character varying(255),
    access_code character varying(255),
    accepted boolean,
    valid_thru date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invites_id_seq OWNED BY invites.id;


--
-- Name: issue_histories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE issue_histories (
    id integer NOT NULL,
    close_date date,
    issue_id character varying(255),
    content character varying(255),
    measure character varying(255),
    temperature integer,
    issueable_id integer,
    issueable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider_id integer
);


--
-- Name: issue_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE issue_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issue_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE issue_histories_id_seq OWNED BY issue_histories.id;


--
-- Name: issues; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE issues (
    id integer NOT NULL,
    content text,
    issueable_id integer,
    issueable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    temperature integer DEFAULT 0,
    auto_temp boolean DEFAULT true,
    measure_id integer,
    provider_id integer
);


--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE issues_id_seq OWNED BY issues.id;


--
-- Name: measures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE measures (
    id integer NOT NULL,
    content character varying(255),
    display_order integer,
    weight integer,
    provider_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: measures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE measures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: measures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE measures_id_seq OWNED BY measures.id;


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE memberships (
    id integer NOT NULL,
    provider_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE memberships_id_seq OWNED BY memberships.id;


--
-- Name: partners; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE partners (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying(255),
    provider_id integer,
    temperature integer DEFAULT 0,
    auto_temp boolean DEFAULT true,
    current_heatmap hstore
);


--
-- Name: partners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE partners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE partners_id_seq OWNED BY partners.id;


--
-- Name: plans; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plans (
    id integer NOT NULL,
    content character varying(255),
    complete boolean DEFAULT false,
    contact_id integer,
    issue_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider_id integer
);


--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE plans_id_seq OWNED BY plans.id;


--
-- Name: providers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE providers (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    customers_count integer DEFAULT 0 NOT NULL,
    partners_count integer DEFAULT 0 NOT NULL,
    issues_count integer DEFAULT 0 NOT NULL,
    plans_count integer DEFAULT 0 NOT NULL,
    contracts_count integer DEFAULT 0 NOT NULL,
    creator_id integer
);


--
-- Name: providers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE providers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE providers_id_seq OWNED BY providers.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider_id integer,
    roles_mask integer,
    first_name character varying(255),
    last_name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE contracts ALTER COLUMN id SET DEFAULT nextval('contracts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE heat_histories ALTER COLUMN id SET DEFAULT nextval('heat_histories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE heat_logs ALTER COLUMN id SET DEFAULT nextval('heat_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE invites ALTER COLUMN id SET DEFAULT nextval('invites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE issue_histories ALTER COLUMN id SET DEFAULT nextval('issue_histories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE issues ALTER COLUMN id SET DEFAULT nextval('issues_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE measures ALTER COLUMN id SET DEFAULT nextval('measures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE memberships ALTER COLUMN id SET DEFAULT nextval('memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE partners ALTER COLUMN id SET DEFAULT nextval('partners_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE plans ALTER COLUMN id SET DEFAULT nextval('plans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE providers ALTER COLUMN id SET DEFAULT nextval('providers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: heat_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY heat_histories
    ADD CONSTRAINT heat_histories_pkey PRIMARY KEY (id);


--
-- Name: heat_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY heat_logs
    ADD CONSTRAINT heat_logs_pkey PRIMARY KEY (id);


--
-- Name: invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY invites
    ADD CONSTRAINT invites_pkey PRIMARY KEY (id);


--
-- Name: issue_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY issue_histories
    ADD CONSTRAINT issue_histories_pkey PRIMARY KEY (id);


--
-- Name: issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: measures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY measures
    ADD CONSTRAINT measures_pkey PRIMARY KEY (id);


--
-- Name: memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: partners_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: plans_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: customers_current_heatmap; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX customers_current_heatmap ON customers USING gin (current_heatmap);


--
-- Name: heat_histories_temperature; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX heat_histories_temperature ON heat_histories USING gin (temperature);


--
-- Name: index_contacts_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_ancestry ON contacts USING btree (ancestry);


--
-- Name: index_contacts_on_contactable_id_and_contactable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_contactable_id_and_contactable_type ON contacts USING btree (contactable_id, contactable_type);


--
-- Name: index_contacts_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_provider_id ON contacts USING btree (provider_id);


--
-- Name: index_contracts_on_customer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contracts_on_customer_id ON contracts USING btree (customer_id);


--
-- Name: index_contracts_on_partner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contracts_on_partner_id ON contracts USING btree (partner_id);


--
-- Name: index_contracts_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contracts_on_provider_id ON contracts USING btree (provider_id);


--
-- Name: index_customers_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_customers_on_ancestry ON customers USING btree (ancestry);


--
-- Name: index_customers_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_customers_on_provider_id ON customers USING btree (provider_id);


--
-- Name: index_heat_logs_on_entity_id_and_entity_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_heat_logs_on_entity_id_and_entity_type ON heat_logs USING btree (entity_id, entity_type);


--
-- Name: index_heat_logs_on_measure_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_heat_logs_on_measure_id ON heat_logs USING btree (measure_id);


--
-- Name: index_heat_logs_on_transaction_date; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_heat_logs_on_transaction_date ON heat_logs USING btree (transaction_date);


--
-- Name: index_issue_histories_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_issue_histories_on_provider_id ON issue_histories USING btree (provider_id);


--
-- Name: index_issues_on_issueable_id_and_issueable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_issues_on_issueable_id_and_issueable_type ON issues USING btree (issueable_id, issueable_type);


--
-- Name: index_issues_on_measure_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_issues_on_measure_id ON issues USING btree (measure_id);


--
-- Name: index_issues_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_issues_on_provider_id ON issues USING btree (provider_id);


--
-- Name: index_measures_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_measures_on_provider_id ON measures USING btree (provider_id);


--
-- Name: index_partners_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_partners_on_ancestry ON partners USING btree (ancestry);


--
-- Name: index_partners_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_partners_on_provider_id ON partners USING btree (provider_id);


--
-- Name: index_plans_on_issue_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plans_on_issue_id ON plans USING btree (issue_id);


--
-- Name: index_plans_on_provider_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_plans_on_provider_id ON plans USING btree (provider_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: partners_current_heatmap; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX partners_current_heatmap ON partners USING gin (current_heatmap);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130609013349');

INSERT INTO schema_migrations (version) VALUES ('20130609021735');

INSERT INTO schema_migrations (version) VALUES ('20130609022002');

INSERT INTO schema_migrations (version) VALUES ('20130609024437');

INSERT INTO schema_migrations (version) VALUES ('20130609024711');

INSERT INTO schema_migrations (version) VALUES ('20130610192241');

INSERT INTO schema_migrations (version) VALUES ('20130610192624');

INSERT INTO schema_migrations (version) VALUES ('20130611004233');

INSERT INTO schema_migrations (version) VALUES ('20130611004258');

INSERT INTO schema_migrations (version) VALUES ('20130613015220');

INSERT INTO schema_migrations (version) VALUES ('20130615010311');

INSERT INTO schema_migrations (version) VALUES ('20130617012849');

INSERT INTO schema_migrations (version) VALUES ('20130617012917');

INSERT INTO schema_migrations (version) VALUES ('20130622022422');

INSERT INTO schema_migrations (version) VALUES ('20130624005318');

INSERT INTO schema_migrations (version) VALUES ('20130624012345');

INSERT INTO schema_migrations (version) VALUES ('20130625005522');

INSERT INTO schema_migrations (version) VALUES ('20130625005715');

INSERT INTO schema_migrations (version) VALUES ('20130625005819');

INSERT INTO schema_migrations (version) VALUES ('20130628013658');

INSERT INTO schema_migrations (version) VALUES ('20130629164314');

INSERT INTO schema_migrations (version) VALUES ('20130630010458');

INSERT INTO schema_migrations (version) VALUES ('20130630143949');

INSERT INTO schema_migrations (version) VALUES ('20130630150326');

INSERT INTO schema_migrations (version) VALUES ('20130630150622');

INSERT INTO schema_migrations (version) VALUES ('20130630180632');

INSERT INTO schema_migrations (version) VALUES ('20130630180920');

INSERT INTO schema_migrations (version) VALUES ('20130702020132');

INSERT INTO schema_migrations (version) VALUES ('20130702020233');

INSERT INTO schema_migrations (version) VALUES ('20130703013137');

INSERT INTO schema_migrations (version) VALUES ('20130705162429');

INSERT INTO schema_migrations (version) VALUES ('20130705165907');

INSERT INTO schema_migrations (version) VALUES ('20130706004656');

INSERT INTO schema_migrations (version) VALUES ('20130710113452');

INSERT INTO schema_migrations (version) VALUES ('20130710121028');

INSERT INTO schema_migrations (version) VALUES ('20130716005126');

INSERT INTO schema_migrations (version) VALUES ('20130716011846');

INSERT INTO schema_migrations (version) VALUES ('20130716023054');

INSERT INTO schema_migrations (version) VALUES ('20130716204302');

INSERT INTO schema_migrations (version) VALUES ('20130719111929');

INSERT INTO schema_migrations (version) VALUES ('20130720022146');

INSERT INTO schema_migrations (version) VALUES ('20130720170145');