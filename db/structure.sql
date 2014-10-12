--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: A_Plus_firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "A_Plus_firm";


--
-- Name: A_Plus_firm_1; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "A_Plus_firm_1";


--
-- Name: Chuckster_Assoc; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Chuckster_Assoc";


--
-- Name: Chuckster_Assoc_2; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Chuckster_Assoc_2";


--
-- Name: Jacks_firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Jacks_firm";


--
-- Name: KK_Attorneys; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "KK_Attorneys";


--
-- Name: Latest_Firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Latest_Firm";


--
-- Name: New_Company_Firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "New_Company_Firm";


--
-- Name: Rav_Firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Rav_Firm";


--
-- Name: dashboard_firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA dashboard_firm;


--
-- Name: gas_3_firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA gas_3_firm;


--
-- Name: s_firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA s_firm;


--
-- Name: u_firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA u_firm;


--
-- Name: v_firm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA v_firm;


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


SET search_path = "A_Plus_firm", pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: attorneys; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: case_documents; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE case_documents (
    id integer NOT NULL,
    case_id integer,
    document_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_documents_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE case_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE case_documents_id_seq OWNED BY case_documents.id;


--
-- Name: case_events; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE case_events (
    id integer NOT NULL,
    case_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_events_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE case_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_events_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE case_events_id_seq OWNED BY case_events.id;


--
-- Name: case_tasks; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE case_tasks (
    id integer NOT NULL,
    case_id integer,
    task_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_tasks_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE case_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE case_tasks_id_seq OWNED BY case_tasks.id;


--
-- Name: cases; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_events; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: firms; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: user_events; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE user_events (
    id integer NOT NULL,
    user_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_events_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE user_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_events_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE user_events_id_seq OWNED BY user_events.id;


--
-- Name: users; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: A_Plus_firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "A_Plus_firm_1", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: case_documents; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE case_documents (
    id integer NOT NULL,
    case_id integer,
    document_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_documents_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE case_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE case_documents_id_seq OWNED BY case_documents.id;


--
-- Name: case_events; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE case_events (
    id integer NOT NULL,
    case_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_events_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE case_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_events_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE case_events_id_seq OWNED BY case_events.id;


--
-- Name: case_tasks; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE case_tasks (
    id integer NOT NULL,
    case_id integer,
    task_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_tasks_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE case_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE case_tasks_id_seq OWNED BY case_tasks.id;


--
-- Name: cases; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_events; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: firms; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: user_events; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE user_events (
    id integer NOT NULL,
    user_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_events_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE user_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_events_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE user_events_id_seq OWNED BY user_events.id;


--
-- Name: users; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: A_Plus_firm_1; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: A_Plus_firm_1; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "Chuckster_Assoc", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "Chuckster_Assoc_2", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: Chuckster_Assoc_2; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "Jacks_firm", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: Jacks_firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: Jacks_firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "KK_Attorneys", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: case_documents; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE case_documents (
    id integer NOT NULL,
    case_id integer,
    document_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_documents_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE case_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE case_documents_id_seq OWNED BY case_documents.id;


--
-- Name: case_events; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE case_events (
    id integer NOT NULL,
    case_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_events_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE case_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_events_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE case_events_id_seq OWNED BY case_events.id;


--
-- Name: case_tasks; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE case_tasks (
    id integer NOT NULL,
    case_id integer,
    task_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_tasks_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE case_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE case_tasks_id_seq OWNED BY case_tasks.id;


--
-- Name: cases; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_events; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255),
    event_id integer
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: firms; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    insurance_provider character varying(255)
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    injury_type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    medical_id integer
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: user_events; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE user_events (
    id integer NOT NULL,
    user_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_events_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE user_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_events_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE user_events_id_seq OWNED BY user_events.id;


--
-- Name: users; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: KK_Attorneys; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: KK_Attorneys; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "Latest_Firm", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: Latest_Firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: Latest_Firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "New_Company_Firm", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: New_Company_Firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: New_Company_Firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "Rav_Firm", pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: Rav_Firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: Rav_Firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = dashboard_firm, pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: dashboard_firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: dashboard_firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = gas_3_firm, pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: gas_3_firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: gas_3_firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = public, pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: case_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE case_documents (
    id integer NOT NULL,
    case_id integer,
    document_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE case_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE case_documents_id_seq OWNED BY case_documents.id;


--
-- Name: case_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE case_events (
    id integer NOT NULL,
    case_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE case_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE case_events_id_seq OWNED BY case_events.id;


--
-- Name: case_tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE case_tasks (
    id integer NOT NULL,
    case_id integer,
    task_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: case_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE case_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE case_tasks_id_seq OWNED BY case_tasks.id;


--
-- Name: cases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255),
    firm_id integer,
    county character varying
);


--
-- Name: cases_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255),
    event_id integer,
    firm_id integer
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
-- Name: defendants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255),
    firm_id integer
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer,
    firm_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: firms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    insurance_provider character varying(255),
    firm_id integer,
    towed boolean
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying,
    region character varying,
    code character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    dominant_side boolean,
    joint_fracture boolean,
    displaced_fracture boolean,
    disfigurement boolean,
    impairment boolean,
    permanence boolean,
    disabled boolean,
    disabled_percent numeric,
    surgery boolean,
    surgery_count integer,
    surgery_type character varying,
    casted_fracture boolean,
    stitches boolean,
    future_surgery boolean,
    future_medicals numeric
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying,
    doctor_type text,
    treatment_type text,
    injury_summary text,
    medical_summary text,
    earnings_lost numeric,
    treatment_gap boolean,
    injections boolean,
    hospitalization boolean,
    hospital_stay_length integer,
    hospital_stay_length_unit character varying,
    firm_id integer,
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255),
    firm_id integer
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: resolutions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resolutions (
    id integer NOT NULL,
    case_id integer,
    firm_id integer,
    settlement_demand numeric,
    jury_demand numeric,
    resolution_amount numeric,
    resolution_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: resolutions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resolutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resolutions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE resolutions_id_seq OWNED BY resolutions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    firm_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: user_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_events (
    id integer NOT NULL,
    user_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_events_id_seq OWNED BY user_events.id;


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
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
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
-- Name: witnesses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = s_firm, pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: s_firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: s_firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = u_firm, pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: u_firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: u_firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = v_firm, pg_catalog;

--
-- Name: attorneys; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys (
    id integer NOT NULL,
    attorney_type character varying(255),
    firm character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attorneys_events; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE attorneys_events (
    attorney_id integer,
    event_id integer
);


--
-- Name: attorneys_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE attorneys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attorneys_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE attorneys_id_seq OWNED BY attorneys.id;


--
-- Name: cases; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases (
    id integer NOT NULL,
    name character varying(255),
    number character varying(255),
    description text,
    medical_bills numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    corporation boolean DEFAULT false,
    closing_date date,
    state character varying(2),
    status integer DEFAULT 0,
    court character varying(255)
);


--
-- Name: cases_documents; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_documents (
    case_id integer,
    document_id integer
);


--
-- Name: cases_events; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_events (
    case_id integer,
    event_id integer
);


--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE cases_id_seq OWNED BY cases.id;


--
-- Name: cases_tasks; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE cases_tasks (
    case_id integer,
    task_id integer
);


--
-- Name: clients; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: contacts; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    address character varying(255),
    city character varying(255),
    state character varying(255),
    country character varying(255),
    phone_number character varying(255),
    fax_number integer,
    email character varying(255),
    gender character varying(255),
    age integer,
    type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    contact_user_id integer,
    case_id integer,
    married boolean,
    employed boolean,
    job_description text,
    salary numeric,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    attorney_type character varying(255),
    staff_type character varying(255)
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: defendants; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE defendants (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defendants_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE defendants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defendants_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE defendants_id_seq OWNED BY defendants.id;


--
-- Name: documents; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE documents (
    id integer NOT NULL,
    author character varying(255),
    doc_type character varying(255),
    template character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    document character varying(255)
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE documents_id_seq OWNED BY documents.id;


--
-- Name: events; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    subject character varying(255),
    location character varying(255),
    date date,
    "time" time without time zone,
    all_day boolean,
    reminder boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    owner_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_users; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE events_users (
    event_id integer,
    user_id integer
);


--
-- Name: firms; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE firms (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    phone character varying(255),
    fax character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    zip character varying(255),
    tenant character varying(255)
);


--
-- Name: firms_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE firms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firms_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE firms_id_seq OWNED BY firms.id;


--
-- Name: incidents; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE incidents (
    id integer NOT NULL,
    incident_date date,
    statute_of_limitations date,
    defendant_liability integer,
    alcohol_involved boolean DEFAULT false,
    weather_factor boolean DEFAULT false,
    property_damage numeric(8,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report character varying(255),
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE incidents_id_seq OWNED BY incidents.id;


--
-- Name: injuries; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE injuries (
    id integer NOT NULL,
    type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: injuries_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE injuries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: injuries_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE injuries_id_seq OWNED BY injuries.id;


--
-- Name: medicals; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE medicals (
    id integer NOT NULL,
    total_med_bills numeric,
    subrogated_amount numeric,
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying(255),
    doctor_type character varying(255),
    treatment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: medicals_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE medicals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicals_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE medicals_id_seq OWNED BY medicals.id;


--
-- Name: notes; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_id integer,
    user_id integer,
    note_type character varying(255),
    author character varying(255)
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: plantiffs; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE plantiffs (
    id integer NOT NULL,
    married boolean,
    employed boolean,
    job_description text,
    salary double precision,
    parent boolean,
    felony_convictions boolean,
    last_ten_years boolean,
    jury_likeability integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plantiffs_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE plantiffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plantiffs_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE plantiffs_id_seq OWNED BY plantiffs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE staffs (
    id integer NOT NULL,
    staff_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE staffs_id_seq OWNED BY staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_date date,
    completed date,
    sms_reminder boolean,
    email_reminder boolean,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: users; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    role integer,
    show_onboarding boolean DEFAULT true,
    oauth_refresh_token character varying(255),
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    google_email character varying(255),
    firm_id integer,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: witnesses; Type: TABLE; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE TABLE witnesses (
    id integer NOT NULL,
    witness_type character varying(255),
    witness_subtype character varying(255),
    witness_doctype character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: witnesses_id_seq; Type: SEQUENCE; Schema: v_firm; Owner: -
--

CREATE SEQUENCE witnesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: witnesses_id_seq; Type: SEQUENCE OWNED BY; Schema: v_firm; Owner: -
--

ALTER SEQUENCE witnesses_id_seq OWNED BY witnesses.id;


SET search_path = "A_Plus_firm", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY case_documents ALTER COLUMN id SET DEFAULT nextval('case_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY case_events ALTER COLUMN id SET DEFAULT nextval('case_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY case_tasks ALTER COLUMN id SET DEFAULT nextval('case_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY user_events ALTER COLUMN id SET DEFAULT nextval('user_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "A_Plus_firm_1", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY case_documents ALTER COLUMN id SET DEFAULT nextval('case_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY case_events ALTER COLUMN id SET DEFAULT nextval('case_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY case_tasks ALTER COLUMN id SET DEFAULT nextval('case_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY user_events ALTER COLUMN id SET DEFAULT nextval('user_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: A_Plus_firm_1; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "Chuckster_Assoc", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "Chuckster_Assoc_2", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Chuckster_Assoc_2; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "Jacks_firm", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Jacks_firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "KK_Attorneys", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY case_documents ALTER COLUMN id SET DEFAULT nextval('case_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY case_events ALTER COLUMN id SET DEFAULT nextval('case_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY case_tasks ALTER COLUMN id SET DEFAULT nextval('case_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY user_events ALTER COLUMN id SET DEFAULT nextval('user_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: KK_Attorneys; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "Latest_Firm", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Latest_Firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "New_Company_Firm", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: New_Company_Firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "Rav_Firm", pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: Rav_Firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = dashboard_firm, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: dashboard_firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = gas_3_firm, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: gas_3_firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY case_documents ALTER COLUMN id SET DEFAULT nextval('case_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY case_events ALTER COLUMN id SET DEFAULT nextval('case_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY case_tasks ALTER COLUMN id SET DEFAULT nextval('case_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY resolutions ALTER COLUMN id SET DEFAULT nextval('resolutions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_events ALTER COLUMN id SET DEFAULT nextval('user_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = s_firm, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: s_firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = u_firm, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: u_firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = v_firm, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY attorneys ALTER COLUMN id SET DEFAULT nextval('attorneys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY cases ALTER COLUMN id SET DEFAULT nextval('cases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY defendants ALTER COLUMN id SET DEFAULT nextval('defendants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY documents ALTER COLUMN id SET DEFAULT nextval('documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY firms ALTER COLUMN id SET DEFAULT nextval('firms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY incidents ALTER COLUMN id SET DEFAULT nextval('incidents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY injuries ALTER COLUMN id SET DEFAULT nextval('injuries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY medicals ALTER COLUMN id SET DEFAULT nextval('medicals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY plantiffs ALTER COLUMN id SET DEFAULT nextval('plantiffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY staffs ALTER COLUMN id SET DEFAULT nextval('staffs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: v_firm; Owner: -
--

ALTER TABLE ONLY witnesses ALTER COLUMN id SET DEFAULT nextval('witnesses_id_seq'::regclass);


SET search_path = "A_Plus_firm", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: case_documents_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_documents
    ADD CONSTRAINT case_documents_pkey PRIMARY KEY (id);


--
-- Name: case_events_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_events
    ADD CONSTRAINT case_events_pkey PRIMARY KEY (id);


--
-- Name: case_tasks_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_tasks
    ADD CONSTRAINT case_tasks_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_events_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_events
    ADD CONSTRAINT user_events_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "A_Plus_firm_1", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: case_documents_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_documents
    ADD CONSTRAINT case_documents_pkey PRIMARY KEY (id);


--
-- Name: case_events_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_events
    ADD CONSTRAINT case_events_pkey PRIMARY KEY (id);


--
-- Name: case_tasks_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_tasks
    ADD CONSTRAINT case_tasks_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_events_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_events
    ADD CONSTRAINT user_events_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "Chuckster_Assoc", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "Chuckster_Assoc_2", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "Jacks_firm", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: Jacks_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "KK_Attorneys", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: case_documents_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_documents
    ADD CONSTRAINT case_documents_pkey PRIMARY KEY (id);


--
-- Name: case_events_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_events
    ADD CONSTRAINT case_events_pkey PRIMARY KEY (id);


--
-- Name: case_tasks_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_tasks
    ADD CONSTRAINT case_tasks_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_events_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_events
    ADD CONSTRAINT user_events_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "Latest_Firm", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: Latest_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "New_Company_Firm", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "Rav_Firm", pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: Rav_Firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = dashboard_firm, pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: dashboard_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = gas_3_firm, pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: gas_3_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: case_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_documents
    ADD CONSTRAINT case_documents_pkey PRIMARY KEY (id);


--
-- Name: case_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_events
    ADD CONSTRAINT case_events_pkey PRIMARY KEY (id);


--
-- Name: case_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY case_tasks
    ADD CONSTRAINT case_tasks_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: resolutions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resolutions
    ADD CONSTRAINT resolutions_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_events
    ADD CONSTRAINT user_events_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = s_firm, pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: s_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = u_firm, pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: u_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = v_firm, pg_catalog;

--
-- Name: attorneys_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attorneys
    ADD CONSTRAINT attorneys_pkey PRIMARY KEY (id);


--
-- Name: cases_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: defendants_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defendants
    ADD CONSTRAINT defendants_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: firms_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firms
    ADD CONSTRAINT firms_pkey PRIMARY KEY (id);


--
-- Name: incidents_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: injuries_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY injuries
    ADD CONSTRAINT injuries_pkey PRIMARY KEY (id);


--
-- Name: medicals_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY medicals
    ADD CONSTRAINT medicals_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: plantiffs_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plantiffs
    ADD CONSTRAINT plantiffs_pkey PRIMARY KEY (id);


--
-- Name: staffs_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: witnesses_pkey; Type: CONSTRAINT; Schema: v_firm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY witnesses
    ADD CONSTRAINT witnesses_pkey PRIMARY KEY (id);


SET search_path = "A_Plus_firm", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: A_Plus_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "A_Plus_firm_1", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: A_Plus_firm_1; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "Chuckster_Assoc", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: Chuckster_Assoc; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "Chuckster_Assoc_2", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: Chuckster_Assoc_2; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "Jacks_firm", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: Jacks_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "KK_Attorneys", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: KK_Attorneys; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "Latest_Firm", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: Latest_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "New_Company_Firm", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: New_Company_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = "Rav_Firm", pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: Rav_Firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = dashboard_firm, pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: dashboard_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = gas_3_firm, pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: gas_3_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = public, pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = s_firm, pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: s_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = u_firm, pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: u_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = v_firm, pg_catalog;

--
-- Name: index_users_on_email; Type: INDEX; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: v_firm; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140521081453');

INSERT INTO schema_migrations (version) VALUES ('20140521081455');

INSERT INTO schema_migrations (version) VALUES ('20140521081456');

INSERT INTO schema_migrations (version) VALUES ('20140521081459');

INSERT INTO schema_migrations (version) VALUES ('20140611071903');

INSERT INTO schema_migrations (version) VALUES ('20140611080015');

INSERT INTO schema_migrations (version) VALUES ('20140611080034');

INSERT INTO schema_migrations (version) VALUES ('20140613075034');

INSERT INTO schema_migrations (version) VALUES ('20140613075045');

INSERT INTO schema_migrations (version) VALUES ('20140708075151');

INSERT INTO schema_migrations (version) VALUES ('20140710073727');

INSERT INTO schema_migrations (version) VALUES ('20140710073830');

INSERT INTO schema_migrations (version) VALUES ('20140710074030');

INSERT INTO schema_migrations (version) VALUES ('20140710074047');

INSERT INTO schema_migrations (version) VALUES ('20140710074106');

INSERT INTO schema_migrations (version) VALUES ('20140713200700');

INSERT INTO schema_migrations (version) VALUES ('20140713223939');

INSERT INTO schema_migrations (version) VALUES ('20140713225935');

INSERT INTO schema_migrations (version) VALUES ('20140714001120');

INSERT INTO schema_migrations (version) VALUES ('20140714001359');

INSERT INTO schema_migrations (version) VALUES ('20140714001757');

INSERT INTO schema_migrations (version) VALUES ('20140714005237');

INSERT INTO schema_migrations (version) VALUES ('20140714013720');

INSERT INTO schema_migrations (version) VALUES ('20140715064718');

INSERT INTO schema_migrations (version) VALUES ('20140715070712');

INSERT INTO schema_migrations (version) VALUES ('20140718070835');

INSERT INTO schema_migrations (version) VALUES ('20140720014309');

INSERT INTO schema_migrations (version) VALUES ('20140720014652');

INSERT INTO schema_migrations (version) VALUES ('20140720015953');

INSERT INTO schema_migrations (version) VALUES ('20140722070945');

INSERT INTO schema_migrations (version) VALUES ('20140731182047');

INSERT INTO schema_migrations (version) VALUES ('20140731182058');

INSERT INTO schema_migrations (version) VALUES ('20140801074506');

INSERT INTO schema_migrations (version) VALUES ('20140810184420');

INSERT INTO schema_migrations (version) VALUES ('20140816024055');

INSERT INTO schema_migrations (version) VALUES ('20140816024648');

INSERT INTO schema_migrations (version) VALUES ('20140816031725');

INSERT INTO schema_migrations (version) VALUES ('20140816063727');

INSERT INTO schema_migrations (version) VALUES ('20140818204753');

INSERT INTO schema_migrations (version) VALUES ('20140819090020');

INSERT INTO schema_migrations (version) VALUES ('20140819095514');

INSERT INTO schema_migrations (version) VALUES ('20140819103114');

INSERT INTO schema_migrations (version) VALUES ('20140819103418');

INSERT INTO schema_migrations (version) VALUES ('20140819103425');

INSERT INTO schema_migrations (version) VALUES ('20140819103436');

INSERT INTO schema_migrations (version) VALUES ('20140819103447');

INSERT INTO schema_migrations (version) VALUES ('20140819220029');

INSERT INTO schema_migrations (version) VALUES ('20140819223709');

INSERT INTO schema_migrations (version) VALUES ('20140828093051');

INSERT INTO schema_migrations (version) VALUES ('20140828105423');

INSERT INTO schema_migrations (version) VALUES ('20140828145557');

INSERT INTO schema_migrations (version) VALUES ('20140828145905');

INSERT INTO schema_migrations (version) VALUES ('20140828221437');

INSERT INTO schema_migrations (version) VALUES ('20140829094827');

INSERT INTO schema_migrations (version) VALUES ('20140829100954');

INSERT INTO schema_migrations (version) VALUES ('20140829101013');

INSERT INTO schema_migrations (version) VALUES ('20140829101031');

INSERT INTO schema_migrations (version) VALUES ('20140829101320');

INSERT INTO schema_migrations (version) VALUES ('20140829145431');

INSERT INTO schema_migrations (version) VALUES ('20140831024619');

INSERT INTO schema_migrations (version) VALUES ('20140903070124');

INSERT INTO schema_migrations (version) VALUES ('20140909075145');

INSERT INTO schema_migrations (version) VALUES ('20140911064246');

INSERT INTO schema_migrations (version) VALUES ('20140911064453');

INSERT INTO schema_migrations (version) VALUES ('20140911072234');

INSERT INTO schema_migrations (version) VALUES ('20140912105832');

INSERT INTO schema_migrations (version) VALUES ('20140917072136');

INSERT INTO schema_migrations (version) VALUES ('20140917072157');

INSERT INTO schema_migrations (version) VALUES ('20140917072211');

INSERT INTO schema_migrations (version) VALUES ('20140917073841');

INSERT INTO schema_migrations (version) VALUES ('20140917075842');

INSERT INTO schema_migrations (version) VALUES ('20140923064416');

INSERT INTO schema_migrations (version) VALUES ('20140923064813');

INSERT INTO schema_migrations (version) VALUES ('20140923071425');

INSERT INTO schema_migrations (version) VALUES ('20141007061231');

INSERT INTO schema_migrations (version) VALUES ('20141007070508');

INSERT INTO schema_migrations (version) VALUES ('20141008070617');

INSERT INTO schema_migrations (version) VALUES ('20141008073759');

INSERT INTO schema_migrations (version) VALUES ('20141008074418');

INSERT INTO schema_migrations (version) VALUES ('20141008075402');

INSERT INTO schema_migrations (version) VALUES ('20141008075403');

