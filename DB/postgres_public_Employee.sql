create table "Employee"
(
    ssn                 varchar(11)                             not null
        constraint employee_pk
            primary key,
    name                varchar,
    job_title           varchar                                 not null,
    salary_type         varchar                                 not null
        constraint salary_type_labels
            check (((salary_type)::text = 'hourly'::text) OR ((salary_type)::text = 'salaried'::text)),
    performance         varchar default 'ok'::character varying not null
        constraint performance_check
            check (((performance)::text = 'bad'::text) OR ((performance)::text = 'ok'::text) OR
                   ((performance)::text = 'good'::text) OR ((performance)::text = 'super-performer'::text)),
    "401k_contribution" numeric default 0.00                    not null,
    state               varchar                                 not null
        constraint state
            references "State",
    employer_id         integer                                 not null
        constraint employer_id
            references "Employer",
    is_manager          boolean default false                   not null,
    address             varchar                                 not null,
    email_address       varchar                                 not null,
    base_salary         integer                                 not null,
    federal_taxbracket  integer default 1                       not null
);

alter table "Employee"
    owner to postgres;

create unique index employee_ssn_uindex
    on "Employee" (ssn);

create unique index employee_employer_id_uindex
    on "Employee" (employer_id);

create unique index employee_state_uindex
    on "Employee" (state);

create unique index employee_email_address_uindex
    on "Employee" (email_address);

