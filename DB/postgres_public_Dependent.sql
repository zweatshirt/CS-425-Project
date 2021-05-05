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

