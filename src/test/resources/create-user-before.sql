delete from user_role;
delete from usr;

insert into usr(id, username, password, active)
values (1, 'dru', '$2a$08$NvmBtqrJ41heA/q.MLeBuebOlHGbMw.ME/Qkd47I9IWTPI/EQL7Za', true),    -- pwd
       (2, 'mike', '$2a$08$NvmBtqrJ41heA/q.MLeBuebOlHGbMw.ME/Qkd47I9IWTPI/EQL7Za', true);

insert into user_role(user_id, roles)
values (1, 'USER'),
       (1, 'ADMIN'),
       (2, 'USER');

