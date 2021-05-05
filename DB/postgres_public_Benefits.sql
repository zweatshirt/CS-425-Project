create table "Benefits"
(
    employer_id   integer not null
        constraint emyployer_id
            references "Employer",
    benefits_id   integer not null,
    "401k_plan"   varchar not null
        constraint benefits_401k_plan_plan_name_fk
            references "401k_Plan"
            on update cascade,
    attorney_plan varchar not null
        constraint benefits_attorney_plan_plan_name_fk
            references "Attorney_Plan"
            on update cascade,
    constraint "Benefits_pkey"
        primary key (employer_id, benefits_id)
);

alter table "Benefits"
    owner to postgres;

create unique index benefits_benefits_id_uindex
    on "Benefits" (benefits_id);

INSERT INTO public."Benefits" (employer_id, benefits_id, "401k_plan", attorney_plan) VALUES (1, 1, 'individual', 'basic');
INSERT INTO public."Benefits" (employer_id, benefits_id, "401k_plan", attorney_plan) VALUES (1, 2, 'family', 'basic');