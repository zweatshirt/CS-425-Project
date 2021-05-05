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

INSERT INTO public."State" (state_name, tax_rate) VALUES ('IL', 0.0495);