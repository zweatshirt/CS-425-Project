create table bonus
(
    employer_id integer not null,
    bonus_perc  numeric not null,
    year        integer not null
);

alter table bonus
    owner to postgres;

INSERT INTO public.bonus (employer_id, bonus_perc, year) VALUES (1, 0.15, 2021);