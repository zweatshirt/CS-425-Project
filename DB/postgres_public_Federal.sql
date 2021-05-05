create table "Federal"
(
    year            integer not null
        constraint federal_pk
            primary key,
    tax_bracket_1   numeric not null,
    tax_bracket_2   numeric,
    tax_bracket_3   numeric,
    social_security numeric not null,
    medicare        numeric not null
);

alter table "Federal"
    owner to postgres;

create unique index federal_year_uindex
    on "Federal" (year);

INSERT INTO public."Federal" (year, tax_bracket_1, tax_bracket_2, tax_bracket_3, social_security, medicare) VALUES (2021, 0.1, 0.28, 0.41, 0.062, 0.0145);