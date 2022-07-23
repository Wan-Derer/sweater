delete from message;

insert into message (id, user_id, text, tag)
values (1, 1, 'first', 'my-tag'),
       (2, 1, 'second', 'more'),
       (3, 1, 'third', 'my-tag'),
       (4, 1, 'fourth', 'another');

alter sequence hibernate_sequence restart with 10;

