create table admin_user
(
    user_email varchar not null
        constraint admin_user_pk
            primary key,
    password   varchar not null
);

alter table admin_user
    owner to postgres;

create unique index admin_user_user_email_uindex
    on admin_user (user_email);

INSERT INTO public.admin_user (user_email, password) VALUES ('root@iit.com', 'root');