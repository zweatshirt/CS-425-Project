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

INSERT INTO public."Attorney_Plan" (plan_name, attorney_firm, premium) VALUES ('basic', 'Pearson Specter', 400000);