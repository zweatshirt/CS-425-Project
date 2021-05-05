create table "Employer_State"
(
    employer_id integer not null
        constraint employer_id
            references "Employer",
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

INSERT INTO public."Employer_State" (employer_id, state_name) VALUES (1, 'IL');