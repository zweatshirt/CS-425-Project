create table "401k_Plan"
(
    plan_name    varchar              not null
        constraint "401k_plan_pk"
            primary key,
    plan_percent numeric default 0.00 not null
        constraint correct_percent
            check ((plan_percent > 0.00) AND (plan_percent < 100.00))
);

alter table "401k_Plan"
    owner to postgres;

INSERT INTO public."401k_Plan" (plan_name, plan_percent) VALUES ('individual', 0.1);
INSERT INTO public."401k_Plan" (plan_name, plan_percent) VALUES ('family', 0.4);