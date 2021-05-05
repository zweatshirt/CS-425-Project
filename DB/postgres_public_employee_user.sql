create table employee_user
(
    user_email varchar not null
        constraint employee_user_pk
            primary key,
    password   varchar not null
);

alter table employee_user
    owner to postgres;

create unique index employee_user_user_email_uindex
    on employee_user (user_email);

