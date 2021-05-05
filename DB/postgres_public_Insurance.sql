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

INSERT INTO public."Insurance" (insurance_name, provider, type, premium_type_cost) VALUES ('open-choice ppo', 'aetna', 'family', 50);
INSERT INTO public."Insurance" (insurance_name, provider, type, premium_type_cost) VALUES ('open-choice ppof', 'aetna', 'individual', 30);