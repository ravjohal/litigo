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
    case_number integer,
    description text,
    medical_bills numeric(10,2),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    case_type character varying(255),
    subtype character varying(255),
    user_id integer,
    closing_date date,
    state character varying(2),
    status character varying DEFAULT 'open'::character varying,
    court character varying(255),
    firm_id integer,
    county character varying,
    docket_number character varying,
    total_hours integer
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
    firm_id integer,
    user_account_id integer,
    company character varying,
    corporation boolean
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
-- Name: event_attendees; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE event_attendees (
    id integer NOT NULL,
    event_id integer,
    display_name character varying,
    creator boolean,
    response_status character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    contact_id integer
);


--
-- Name: event_attendees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_attendees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_attendees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE event_attendees_id_seq OWNED BY event_attendees.id;


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
    firm_id integer,
    google_id character varying,
    etag character varying,
    status character varying,
    "htmlLink" character varying,
    summary character varying,
    start timestamp without time zone,
    "end" timestamp without time zone,
    "endTimeUnspecified" boolean,
    transparency character varying,
    visibility character varying,
    "iCalUID" character varying,
    sequence integer,
    google_calendar_id character varying
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
-- Name: google_calendars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE google_calendars (
    id integer NOT NULL,
    etag character varying,
    google_id character varying,
    summary character varying,
    description character varying,
    "timeZone" character varying,
    selected boolean,
    "primary" boolean,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    firm_id integer
);


--
-- Name: google_calendars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE google_calendars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: google_calendars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE google_calendars_id_seq OWNED BY google_calendars.id;


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
    property_damage numeric(10,2),
    airbag_deployed boolean DEFAULT false,
    speed character varying(255),
    police_report boolean,
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    insurance_provider character varying(255),
    firm_id integer,
    towed boolean,
    complaint_at_scene boolean
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
    injury_type character varying(255),
    region character varying(255),
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    medical_id integer,
    firm_id integer,
    dominant_side boolean,
    joint_fracture boolean,
    displaced_fracture boolean,
    disfigurement boolean,
    impairment boolean,
    permanence boolean,
    disabled boolean,
    disabled_percent numeric(5,2),
    surgery boolean,
    surgery_count integer,
    surgery_type character varying,
    casted_fracture boolean,
    stitches boolean,
    future_surgery boolean,
    future_medicals numeric(10,2),
    prior_complaint boolean,
    "primary" boolean DEFAULT false,
    ongoing_pain boolean
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
    total_med_bills numeric(10,2),
    subrogated_amount numeric(10,2),
    injuries_within_three_days boolean,
    length_of_treatment integer,
    length_of_treatment_unit character varying,
    injury_summary text,
    medical_summary text,
    earnings_lost numeric(10,2),
    treatment_gap boolean,
    injections boolean,
    hospitalization boolean,
    hospital_stay_length integer,
    hospital_stay_length_unit character varying,
    firm_id integer,
    case_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    doctor_type character varying[] DEFAULT '{}'::character varying[],
    treatment_type character varying[] DEFAULT '{}'::character varying[]
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
    settlement_demand numeric(10,2),
    jury_demand numeric(10,2),
    resolution_amount numeric(10,2),
    resolution_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    note text
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
    version character varying NOT NULL
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
-- Name: treatments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE treatments (
    id integer NOT NULL,
    injury_id integer,
    firm_id integer,
    surgery boolean,
    surgery_count integer,
    surgery_type character varying,
    casted_fracture boolean,
    stitches boolean,
    future_surgery boolean,
    future_medicals numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: treatments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE treatments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: treatments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE treatments_id_seq OWNED BY treatments.id;


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
    encrypted_password character varying(255) DEFAULT ''::character varying,
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
    last_name character varying(255),
    time_zone character varying DEFAULT 'Pacific Time (US & Canada)'::character varying,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_id integer,
    invited_by_type character varying,
    invitations_count integer DEFAULT 0,
    invitation_role integer
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

ALTER TABLE ONLY event_attendees ALTER COLUMN id SET DEFAULT nextval('event_attendees_id_seq'::regclass);


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

ALTER TABLE ONLY google_calendars ALTER COLUMN id SET DEFAULT nextval('google_calendars_id_seq'::regclass);


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

ALTER TABLE ONLY treatments ALTER COLUMN id SET DEFAULT nextval('treatments_id_seq'::regclass);


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
-- Name: event_attendees_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY event_attendees
    ADD CONSTRAINT event_attendees_pkey PRIMARY KEY (id);


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
-- Name: google_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY google_calendars
    ADD CONSTRAINT google_calendars_pkey PRIMARY KEY (id);


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
-- Name: treatments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY treatments
    ADD CONSTRAINT treatments_pkey PRIMARY KEY (id);


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


--
-- Name: index_case_documents_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_case_documents_on_case_id ON case_documents USING btree (case_id);


--
-- Name: index_case_documents_on_document_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_case_documents_on_document_id ON case_documents USING btree (document_id);


--
-- Name: index_case_events_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_case_events_on_case_id ON case_events USING btree (case_id);


--
-- Name: index_case_events_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_case_events_on_event_id ON case_events USING btree (event_id);


--
-- Name: index_case_tasks_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_case_tasks_on_case_id ON case_tasks USING btree (case_id);


--
-- Name: index_case_tasks_on_task_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_case_tasks_on_task_id ON case_tasks USING btree (task_id);


--
-- Name: index_cases_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cases_on_firm_id ON cases USING btree (firm_id);


--
-- Name: index_cases_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cases_on_user_id ON cases USING btree (user_id);


--
-- Name: index_contacts_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_case_id ON contacts USING btree (case_id);


--
-- Name: index_contacts_on_contact_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_contact_user_id ON contacts USING btree (contact_user_id);


--
-- Name: index_contacts_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_event_id ON contacts USING btree (event_id);


--
-- Name: index_contacts_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_firm_id ON contacts USING btree (firm_id);


--
-- Name: index_contacts_on_user_account_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_user_account_id ON contacts USING btree (user_account_id);


--
-- Name: index_contacts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contacts_on_user_id ON contacts USING btree (user_id);


--
-- Name: index_documents_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_documents_on_firm_id ON documents USING btree (firm_id);


--
-- Name: index_documents_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_documents_on_user_id ON documents USING btree (user_id);


--
-- Name: index_event_attendees_on_contact_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_event_attendees_on_contact_id ON event_attendees USING btree (contact_id);


--
-- Name: index_event_attendees_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_event_attendees_on_event_id ON event_attendees USING btree (event_id);


--
-- Name: index_events_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_firm_id ON events USING btree (firm_id);


--
-- Name: index_events_on_google_calendar_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_google_calendar_id ON events USING btree (google_calendar_id);


--
-- Name: index_events_on_google_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_google_id ON events USING btree (google_id);


--
-- Name: index_events_on_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_owner_id ON events USING btree (owner_id);


--
-- Name: index_google_calendars_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_google_calendars_on_firm_id ON google_calendars USING btree (firm_id);


--
-- Name: index_google_calendars_on_google_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_google_calendars_on_google_id ON google_calendars USING btree (google_id);


--
-- Name: index_google_calendars_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_google_calendars_on_user_id ON google_calendars USING btree (user_id);


--
-- Name: index_incidents_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_incidents_on_case_id ON incidents USING btree (case_id);


--
-- Name: index_incidents_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_incidents_on_firm_id ON incidents USING btree (firm_id);


--
-- Name: index_injuries_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_injuries_on_firm_id ON injuries USING btree (firm_id);


--
-- Name: index_injuries_on_medical_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_injuries_on_medical_id ON injuries USING btree (medical_id);


--
-- Name: index_medicals_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_medicals_on_case_id ON medicals USING btree (case_id);


--
-- Name: index_medicals_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_medicals_on_firm_id ON medicals USING btree (firm_id);


--
-- Name: index_notes_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notes_on_case_id ON notes USING btree (case_id);


--
-- Name: index_notes_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notes_on_firm_id ON notes USING btree (firm_id);


--
-- Name: index_notes_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notes_on_user_id ON notes USING btree (user_id);


--
-- Name: index_resolutions_on_case_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_resolutions_on_case_id ON resolutions USING btree (case_id);


--
-- Name: index_resolutions_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_resolutions_on_firm_id ON resolutions USING btree (firm_id);


--
-- Name: index_tasks_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_firm_id ON tasks USING btree (firm_id);


--
-- Name: index_tasks_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_user_id ON tasks USING btree (user_id);


--
-- Name: index_user_events_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_events_on_event_id ON user_events USING btree (event_id);


--
-- Name: index_user_events_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_events_on_user_id ON user_events USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_firm_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_firm_id ON users USING btree (firm_id);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_invitations_count ON users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_invited_by_id ON users USING btree (invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
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

INSERT INTO schema_migrations (version) VALUES ('20140917072136');

INSERT INTO schema_migrations (version) VALUES ('20140917072157');

INSERT INTO schema_migrations (version) VALUES ('20140917072211');

INSERT INTO schema_migrations (version) VALUES ('20140917073841');

INSERT INTO schema_migrations (version) VALUES ('20140917075842');

INSERT INTO schema_migrations (version) VALUES ('20140923064813');

INSERT INTO schema_migrations (version) VALUES ('20141004162707');

INSERT INTO schema_migrations (version) VALUES ('20141004162905');

INSERT INTO schema_migrations (version) VALUES ('20141006073931');

INSERT INTO schema_migrations (version) VALUES ('20141007061231');

INSERT INTO schema_migrations (version) VALUES ('20141007070508');

INSERT INTO schema_migrations (version) VALUES ('20141008073759');

INSERT INTO schema_migrations (version) VALUES ('20141008074418');

INSERT INTO schema_migrations (version) VALUES ('20141008075402');

INSERT INTO schema_migrations (version) VALUES ('20141008075403');

INSERT INTO schema_migrations (version) VALUES ('20141014011714');

INSERT INTO schema_migrations (version) VALUES ('20141014160523');

INSERT INTO schema_migrations (version) VALUES ('20141016062301');

INSERT INTO schema_migrations (version) VALUES ('20141016082909');

INSERT INTO schema_migrations (version) VALUES ('20141017055815');

INSERT INTO schema_migrations (version) VALUES ('20141018051107');

INSERT INTO schema_migrations (version) VALUES ('20141018053108');

INSERT INTO schema_migrations (version) VALUES ('20141018213054');

INSERT INTO schema_migrations (version) VALUES ('20141018225207');

INSERT INTO schema_migrations (version) VALUES ('20141020033121');

INSERT INTO schema_migrations (version) VALUES ('20141020170925');

INSERT INTO schema_migrations (version) VALUES ('20141020211057');

INSERT INTO schema_migrations (version) VALUES ('20141021031734');

INSERT INTO schema_migrations (version) VALUES ('20141021074228');

INSERT INTO schema_migrations (version) VALUES ('20141022113157');

INSERT INTO schema_migrations (version) VALUES ('20141024080634');

INSERT INTO schema_migrations (version) VALUES ('20141024080722');

INSERT INTO schema_migrations (version) VALUES ('20141024081657');

INSERT INTO schema_migrations (version) VALUES ('20141028054933');

INSERT INTO schema_migrations (version) VALUES ('20141028055022');

INSERT INTO schema_migrations (version) VALUES ('20141028055032');

INSERT INTO schema_migrations (version) VALUES ('20141028055521');

INSERT INTO schema_migrations (version) VALUES ('20141028055643');

INSERT INTO schema_migrations (version) VALUES ('20141028055755');

INSERT INTO schema_migrations (version) VALUES ('20141028055922');

INSERT INTO schema_migrations (version) VALUES ('20141028055944');

INSERT INTO schema_migrations (version) VALUES ('20141028060029');

INSERT INTO schema_migrations (version) VALUES ('20141028060132');

INSERT INTO schema_migrations (version) VALUES ('20141028060246');

INSERT INTO schema_migrations (version) VALUES ('20141028060335');

INSERT INTO schema_migrations (version) VALUES ('20141028060421');

INSERT INTO schema_migrations (version) VALUES ('20141028060626');

INSERT INTO schema_migrations (version) VALUES ('20141028061241');

INSERT INTO schema_migrations (version) VALUES ('20141104174546');

INSERT INTO schema_migrations (version) VALUES ('20141109225218');

INSERT INTO schema_migrations (version) VALUES ('20141111080118');

INSERT INTO schema_migrations (version) VALUES ('20141113031247');

INSERT INTO schema_migrations (version) VALUES ('20141113083514');

INSERT INTO schema_migrations (version) VALUES ('20141113085804');

INSERT INTO schema_migrations (version) VALUES ('20141117033617');

INSERT INTO schema_migrations (version) VALUES ('20141118073552');

