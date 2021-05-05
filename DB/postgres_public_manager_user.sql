create table manager_user
(
    user_email varchar not null
        constraint manager_user_pk
            primary key,
    password   varchar not null
);

alter table manager_user
    owner to postgres;

create unique index manager_user_user_email_uindex
    on manager_user (user_email);

