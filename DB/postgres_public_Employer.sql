create table "Employer"
(
    employer_id                    integer not null
        constraint employer_pk
            primary key,
    company_sale                   integer not null,
    insurance_premium_contribution numeric not null,
    "401k_company_match"           numeric not null
        constraint "401k_match"
            check (("401k_company_match" > 0.00) AND ("401k_company_match" < 0.07)),
    name                           varchar not null
);

alter table "Employer"
    owner to postgres;

create unique index employer_employer_id_uindex
    on "Employer" (employer_id);

INSERT INTO public."Employer" (employer_id, company_sale, insurance_premium_contribution, "401k_company_match", name) VALUES (1, 14000000, 0.25, 0.06, 'Google');