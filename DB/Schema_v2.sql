create table "401k_Plan"
(
    plan_name    varchar              not null
        constraint "401k_plan_pk"
            primary key,
    plan_percent numeric default 0.00 not null
        constraint correct_percent
            check ((plan_percent > 0.00) AND (plan_percent < 100.00))
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


create table "Benefits"
(
    employer_id   integer not null
        constraint emyployer_id
            references "Employer" (employer_id),
    benefits_id   integer not null,
    "401k_plan"   varchar not null
        constraint benefits_401k_plan_plan_name_fk
            references "401k_Plan"
            on update cascade,
    attorney_plan varchar not null
        constraint benefits_attorney_plan_plan_name_fk
            references "Attorney_Plan"
            on update cascade,
    constraint "Benefits_pkey"
        primary key (employer_id, benefits_id)
);

alter table "Benefits"
    owner to postgres;

create unique index benefits_employer_id_uindex
    on "Benefits" (employer_id);

create unique index benefits_benefits_id_uindex
    on "Benefits" (benefits_id);


create table "Benefits_Insurance_AT"
(
    benefit_id     integer not null
        constraint benefits_insurance_at_benefits_benefits_id_fk
            references "Benefits" (benefits_id)
            on update cascade,
    insurance_name varchar not null
        constraint benefits_insurance_at_insurance_insurance_name_fk
            references "Insurance"
            on update cascade,
    constraint benefits_insurance_at_pk
        primary key (benefit_id, insurance_name)
);

alter table "Benefits_Insurance_AT"
    owner to postgres;

create unique index benefits_insurance_at_benefit_id_uindex
    on "Benefits_Insurance_AT" (benefit_id);

create unique index benefits_insurance_at_insurance_name_uindex
    on "Benefits_Insurance_AT" (insurance_name);


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


create table "Employee"
(
    ssn                 varchar(11)          not null
        constraint employee_pk
            primary key,
    name                varchar,
    base_salary         integer              not null
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


create table "Employer"
(
    employer_id                    integer not null,
    company_sale                   integer not null,
    insurance_premium_contribution integer not null,
    "401k_company_match"           integer not null
        constraint "401k_match"
            check ((("401k_company_match")::numeric > 0.00) AND (("401k_company_match")::numeric < 0.07)),
    
);

alter table "Employer"
    owner to postgres;

create unique index employer_employer_id_uindex
    on "Employer" (employer_id);




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


create table "Federal"
(
    year            integer     not null,
    tax_bracket_1   numeric     not null,
    tax_bracket_2   numeric,
    tax_bracket_3   numeric,
    social_security numeric     not null,
    medicare        numeric     not null,
    constraint "Federal_pkey"
        primary key (year)
);

alter table "Federal"
    owner to postgres;



create unique index federal_year_uindex
    on "Federal" (year);


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


create table "State"
(
    state_name varchar not null
        constraint state_pk
            primary key,
    tax_rate   numeric default 0.00
);

alter table "State"
    owner to postgres;

create unique index state_state_name_uindex
    on "State" (state_name);

