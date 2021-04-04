create table "Employer"
(
    employer_id                    integer not null,
    company_sale                   integer not null,
    insurance_premium_contribution integer not null,
    "401k_company_match"           integer not null,
    insurance_name                 varchar not null
);

alter table "Employer"
    owner to postgres;

create unique index employer_employer_id_uindex
    on "Employer" (employer_id);

create table "State"
(
    state_name varchar not null
        constraint state_pk
            primary key,
    tax_rate   numeric default 0.00
);

alter table "State"
    owner to postgres;

create table "Employee"
(
    ssn                 varchar(11)          not null
        constraint employee_pk
            primary key,
    name                integer,
    federal_tax_bracket integer              not null,
    job_title           varchar              not null,
    salary_type         varchar              not null,
    performance         varchar              not null,
    "401k_contribution" numeric default 0.00 not null,
    state               varchar              not null
        constraint state
            references "State",
    employer_id         integer              not null
        constraint employer_id
            references "Employer" (employer_id)
);

alter table "Employee"
    owner to postgres;

create unique index employee_ssn_uindex
    on "Employee" (ssn);

create unique index employee_employer_id_uindex
    on "Employee" (employer_id);

create unique index employee_state_uindex
    on "Employee" (state);

create unique index state_state_name_uindex
    on "State" (state_name);

create table "Insurance"
(
    insurance_name    varchar not null
        constraint insurance_pk
            primary key,
    provider          varchar,
    type              varchar,
    premium_type_cost integer
);

alter table "Insurance"
    owner to postgres;

create unique index insurance_insurance_name_uindex
    on "Insurance" (insurance_name);

create table "401k_Plan"
(
    plan_name integer not null
        constraint "401k_plan_pk"
            primary key
);

alter table "401k_Plan"
    owner to postgres;

create table "Attorney_Plan"
(
    plan_name     varchar not null
        constraint attorney_plan_pk
            primary key,
    attorney_firm varchar not null,
    premium       numeric not null
);

alter table "Attorney_Plan"
    owner to postgres;

create table "Dependent"
(
    ssn           varchar(11) not null
        constraint ssn
            references "Employee",
    dependent_ssn varchar(11) not null,
    name          varchar     not null,
    relation      varchar     not null,
    constraint "Dependent_pkey"
        primary key (ssn, dependent_ssn)
);

alter table "Dependent"
    owner to postgres;

create table "Benefits"
(
    employer_id   integer not null
        constraint emyployer_id
            references "Employer" (employer_id),
    benefits_id   integer not null,
    insurance     varchar not null,
    "401k_plan"   varchar not null,
    attorney_plan varchar not null,
    constraint "Benefits_pkey"
        primary key (employer_id, benefits_id)
);

alter table "Benefits"
    owner to postgres;

create unique index benefits_employer_id_uindex
    on "Benefits" (employer_id);

create table "Federal"
(
    ssn             varchar(11) not null
        constraint ssn
            references "Employee",
    year            integer     not null,
    insurance_name  varchar,
    tax_bracket_1   numeric     not null,
    tax_bracket_2   numeric,
    tax_bracket_3   numeric,
    social_security numeric     not null,
    medicare        numeric     not null,
    w2              numeric     not null,
    constraint "Federal_pkey"
        primary key (ssn, year)
);

alter table "Federal"
    owner to postgres;

create unique index federal_ssn_uindex
    on "Federal" (ssn);

create unique index federal_year_uindex
    on "Federal" (year);

create table "Employer_State"
(
    employer_id integer not null
        constraint employer_id
            references "Employer" (employer_id),
    state_name  varchar not null
        constraint state_name
            references "State",
    constraint "Employer_State_pkey"
        primary key (employer_id, state_name)
);

alter table "Employer_State"
    owner to postgres;

create unique index employer_state_employer_id_uindex
    on "Employer_State" (employer_id);


