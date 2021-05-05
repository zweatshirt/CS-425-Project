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

INSERT INTO public."Benefits_Insurance_AT" (benefit_id, insurance_name) VALUES (1, 'open-choice ppof');
INSERT INTO public."Benefits_Insurance_AT" (benefit_id, insurance_name) VALUES (2, 'open-choice ppo');