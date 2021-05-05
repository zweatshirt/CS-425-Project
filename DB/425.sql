--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Ubuntu 13.2-1.pgdg20.04+1)
-- Dumped by pg_dump version 13.2 (Ubuntu 13.2-1.pgdg20.04+1)

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
-- Name: 401k_Plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."401k_Plan" (
    plan_name character varying NOT NULL,
    plan_percent numeric DEFAULT 0.00 NOT NULL,
    CONSTRAINT correct_percent CHECK (((plan_percent > 0.00) AND (plan_percent < 100.00)))
);


ALTER TABLE public."401k_Plan" OWNER TO postgres;

--
-- Name: Attorney_Plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Attorney_Plan" (
    plan_name character varying NOT NULL,
    attorney_firm character varying NOT NULL,
    premium numeric NOT NULL
);


ALTER TABLE public."Attorney_Plan" OWNER TO postgres;

--
-- Name: Benefits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Benefits" (
    benefits_id integer NOT NULL,
    "401k_plan" character varying NOT NULL,
    attorney_plan character varying NOT NULL,
    employer_id integer NOT NULL
);


ALTER TABLE public."Benefits" OWNER TO postgres;

--
-- Name: Benefits_Insurance_AT; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Benefits_Insurance_AT" (
    benefit_id integer NOT NULL,
    insurance_name character varying NOT NULL
);


ALTER TABLE public."Benefits_Insurance_AT" OWNER TO postgres;

--
-- Name: Dependent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Dependent" (
    ssn character varying(11) NOT NULL,
    dependent_ssn character varying(11) NOT NULL,
    name character varying NOT NULL,
    relation character varying NOT NULL
);


ALTER TABLE public."Dependent" OWNER TO postgres;

--
-- Name: Employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employee" (
    ssn character varying(11) NOT NULL,
    name character varying,
    job_title character varying NOT NULL,
    salary_type character varying NOT NULL,
    performance character varying NOT NULL,
    "401k_contribution" numeric DEFAULT 0.00 NOT NULL,
    state character varying NOT NULL,
    employer_id integer NOT NULL,
    base_salary integer NOT NULL
);


ALTER TABLE public."Employee" OWNER TO postgres;

--
-- Name: Employer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employer" (
    employer_id integer NOT NULL,
    company_sale integer NOT NULL,
    insurance_premium_contribution integer NOT NULL,
    "401k_company_match" integer NOT NULL,
    CONSTRAINT "401k_match" CHECK (((("401k_company_match")::numeric > 0.00) AND (("401k_company_match")::numeric < 0.07)))
);


ALTER TABLE public."Employer" OWNER TO postgres;

--
-- Name: Employer_State; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Employer_State" (
    employer_id integer NOT NULL,
    state_name character varying NOT NULL
);


ALTER TABLE public."Employer_State" OWNER TO postgres;

--
-- Name: Federal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Federal" (
    year integer NOT NULL,
    tax_bracket_1 numeric NOT NULL,
    tax_bracket_2 numeric,
    tax_bracket_3 numeric,
    social_security numeric NOT NULL,
    medicare numeric NOT NULL
);


ALTER TABLE public."Federal" OWNER TO postgres;

--
-- Name: Insurance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Insurance" (
    insurance_name character varying NOT NULL,
    provider character varying,
    type character varying,
    premium_type_cost integer
);


ALTER TABLE public."Insurance" OWNER TO postgres;

--
-- Name: State; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."State" (
    state_name character varying NOT NULL,
    tax_rate numeric DEFAULT 0.00
);


ALTER TABLE public."State" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    email character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: TABLE "User"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."User" IS 'user sign up and sign in table';


--
-- Data for Name: 401k_Plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."401k_Plan" (plan_name, plan_percent) FROM stdin;
\.


--
-- Data for Name: Attorney_Plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Attorney_Plan" (plan_name, attorney_firm, premium) FROM stdin;
\.


--
-- Data for Name: Benefits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Benefits" (benefits_id, "401k_plan", attorney_plan, employer_id) FROM stdin;
\.


--
-- Data for Name: Benefits_Insurance_AT; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Benefits_Insurance_AT" (benefit_id, insurance_name) FROM stdin;
\.


--
-- Data for Name: Dependent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Dependent" (ssn, dependent_ssn, name, relation) FROM stdin;
\.


--
-- Data for Name: Employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employee" (ssn, name, job_title, salary_type, performance, "401k_contribution", state, employer_id, base_salary) FROM stdin;
\.


--
-- Data for Name: Employer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employer" (employer_id, company_sale, insurance_premium_contribution, "401k_company_match") FROM stdin;
\.


--
-- Data for Name: Employer_State; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Employer_State" (employer_id, state_name) FROM stdin;
\.


--
-- Data for Name: Federal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Federal" (year, tax_bracket_1, tax_bracket_2, tax_bracket_3, social_security, medicare) FROM stdin;
\.


--
-- Data for Name: Insurance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Insurance" (insurance_name, provider, type, premium_type_cost) FROM stdin;
\.


--
-- Data for Name: State; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."State" (state_name, tax_rate) FROM stdin;
IL	0.33
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (email, password) FROM stdin;
\.


--
-- Name: 401k_Plan 401k_plan_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."401k_Plan"
    ADD CONSTRAINT "401k_plan_pk" PRIMARY KEY (plan_name);


--
-- Name: Benefits Benefits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Benefits"
    ADD CONSTRAINT "Benefits_pkey" PRIMARY KEY (benefits_id, employer_id);


--
-- Name: Dependent Dependent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dependent"
    ADD CONSTRAINT "Dependent_pkey" PRIMARY KEY (ssn, dependent_ssn);


--
-- Name: Employer_State Employer_State_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employer_State"
    ADD CONSTRAINT "Employer_State_pkey" PRIMARY KEY (employer_id, state_name);


--
-- Name: Federal Federal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Federal"
    ADD CONSTRAINT "Federal_pkey" PRIMARY KEY (year);


--
-- Name: Attorney_Plan attorney_plan_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Attorney_Plan"
    ADD CONSTRAINT attorney_plan_pk PRIMARY KEY (plan_name);


--
-- Name: Benefits_Insurance_AT benefits_insurance_at_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Benefits_Insurance_AT"
    ADD CONSTRAINT benefits_insurance_at_pk PRIMARY KEY (benefit_id, insurance_name);


--
-- Name: Employee employee_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT employee_pk PRIMARY KEY (ssn);


--
-- Name: Employer employer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employer"
    ADD CONSTRAINT employer_pk PRIMARY KEY (employer_id);


--
-- Name: Insurance insurance_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Insurance"
    ADD CONSTRAINT insurance_pk PRIMARY KEY (insurance_name);


--
-- Name: State state_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."State"
    ADD CONSTRAINT state_pk PRIMARY KEY (state_name);


--
-- Name: User user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_pk PRIMARY KEY (email);


--
-- Name: benefits_benefits_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX benefits_benefits_id_uindex ON public."Benefits" USING btree (benefits_id);


--
-- Name: benefits_employer_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX benefits_employer_id_uindex ON public."Benefits" USING btree (employer_id);


--
-- Name: benefits_insurance_at_benefit_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX benefits_insurance_at_benefit_id_uindex ON public."Benefits_Insurance_AT" USING btree (benefit_id);


--
-- Name: benefits_insurance_at_insurance_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX benefits_insurance_at_insurance_name_uindex ON public."Benefits_Insurance_AT" USING btree (insurance_name);


--
-- Name: employee_employer_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX employee_employer_id_uindex ON public."Employee" USING btree (employer_id);


--
-- Name: employee_ssn_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX employee_ssn_uindex ON public."Employee" USING btree (ssn);


--
-- Name: employee_state_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX employee_state_uindex ON public."Employee" USING btree (state);


--
-- Name: employer_employer_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX employer_employer_id_uindex ON public."Employer" USING btree (employer_id);


--
-- Name: employer_state_employer_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX employer_state_employer_id_uindex ON public."Employer_State" USING btree (employer_id);


--
-- Name: federal_year_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX federal_year_uindex ON public."Federal" USING btree (year);


--
-- Name: insurance_insurance_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX insurance_insurance_name_uindex ON public."Insurance" USING btree (insurance_name);


--
-- Name: state_state_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX state_state_name_uindex ON public."State" USING btree (state_name);


--
-- Name: user_email_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_email_uindex ON public."User" USING btree (email);


--
-- Name: Benefits benefits_401k_plan_plan_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Benefits"
    ADD CONSTRAINT benefits_401k_plan_plan_name_fk FOREIGN KEY ("401k_plan") REFERENCES public."401k_Plan"(plan_name) ON UPDATE CASCADE;


--
-- Name: Benefits benefits_attorney_plan_plan_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Benefits"
    ADD CONSTRAINT benefits_attorney_plan_plan_name_fk FOREIGN KEY (attorney_plan) REFERENCES public."Attorney_Plan"(plan_name) ON UPDATE CASCADE;


--
-- Name: Benefits benefits_employer_employer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Benefits"
    ADD CONSTRAINT benefits_employer_employer_id_fk FOREIGN KEY (employer_id) REFERENCES public."Employer"(employer_id) ON UPDATE CASCADE;


--
-- Name: Benefits_Insurance_AT benefits_insurance_at_benefits_benefits_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Benefits_Insurance_AT"
    ADD CONSTRAINT benefits_insurance_at_benefits_benefits_id_fk FOREIGN KEY (benefit_id) REFERENCES public."Benefits"(benefits_id) ON UPDATE CASCADE;


--
-- Name: Benefits_Insurance_AT benefits_insurance_at_insurance_insurance_name_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Benefits_Insurance_AT"
    ADD CONSTRAINT benefits_insurance_at_insurance_insurance_name_fk FOREIGN KEY (insurance_name) REFERENCES public."Insurance"(insurance_name) ON UPDATE CASCADE;


--
-- Name: Employee employer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT employer_id FOREIGN KEY (employer_id) REFERENCES public."Employer"(employer_id);


--
-- Name: Employer_State employer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employer_State"
    ADD CONSTRAINT employer_id FOREIGN KEY (employer_id) REFERENCES public."Employer"(employer_id);


--
-- Name: Dependent ssn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Dependent"
    ADD CONSTRAINT ssn FOREIGN KEY (ssn) REFERENCES public."Employee"(ssn);


--
-- Name: Employee state; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT state FOREIGN KEY (state) REFERENCES public."State"(state_name);


--
-- Name: Employer_State state_name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Employer_State"
    ADD CONSTRAINT state_name FOREIGN KEY (state_name) REFERENCES public."State"(state_name);


--
-- PostgreSQL database dump complete
--

