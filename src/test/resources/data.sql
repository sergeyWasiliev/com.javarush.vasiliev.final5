--------- users ----------------------
DELETE FROM user_role;
DELETE FROM contact;
DELETE FROM profile;

DELETE FROM activity;
ALTER TABLE activity ALTER COLUMN id RESTART WITH 1;
DELETE FROM task;
ALTER TABLE task ALTER COLUMN id RESTART WITH 1;
DELETE FROM sprint;
ALTER TABLE sprint ALTER COLUMN id RESTART WITH 1;
DELETE FROM project;
ALTER TABLE project ALTER COLUMN id RESTART WITH 1;

DELETE FROM users;
ALTER TABLE users ALTER COLUMN id RESTART WITH 1;

INSERT INTO users (email, password, first_name, last_name, display_name)
VALUES ('user@gmail.com', '{noop}password', 'userFirstName', 'userLastName', 'userDisplayName'),
       ('admin@gmail.com', '{noop}admin', 'adminFirstName', 'adminLastName', 'adminDisplayName'),
       ('guest@gmail.com', '{noop}guest', 'guestFirstName', 'guestLastName', 'guestDisplayName'),
       ('manager@gmail.com', '{noop}manager', 'managerFirstName', 'managerLastName', 'managerDisplayName');

-- 0 DEV
-- 1 ADMIN
-- 2 MANAGER

INSERT INTO user_role (user_id, role)
VALUES (1, 0),
       (2, 0),
       (2, 1),
       (4, 2);

INSERT INTO profile (id, last_failed_login, last_login, mail_notifications)
VALUES (1, NULL, NULL, 49),
       (2, NULL, NULL, 14);

-- ИСПРАВЛЕНО: VALUE в кавычках для H2
INSERT INTO contact (id, code, "value")
VALUES (1, 'skype', 'userSkype'),
       (1, 'mobile', '+01234567890'),
       (1, 'website', 'user.com'),
       (2, 'github', 'adminGitHub'),
       (2, 'tg', 'adminTg');

INSERT INTO project (code, title, description, type_code, parent_id)
VALUES ('PR1', 'PROJECT-1', 'test project 1', 'task_tracker', NULL),
       ('PR2', 'PROJECT-2', 'test project 2', 'task_tracker', 1);

INSERT INTO sprint (status_code, startpoint, endpoint, code, project_id)
VALUES ('finished', '2023-05-01 08:05:10', '2023-05-07 17:10:01', 'SP-1.001', 1),
       ('active', '2023-05-01 08:06:00', NULL, 'SP-1.002', 1),
       ('active', '2023-05-01 08:07:00', NULL, 'SP-1.003', 1),
       ('planning', '2023-05-01 08:08:00', NULL, 'SP-1.004', 1),
       ('active', '2023-05-10 08:06:00', NULL, 'SP-2.001', 2),
       ('planning', '2023-05-10 08:07:00', NULL, 'SP-2.002', 2),
       ('planning', '2023-05-10 08:08:00', NULL, 'SP-2.003', 2);

INSERT INTO task (title, type_code, status_code, project_id, sprint_id, startpoint)
VALUES ('Data', 'epic', 'in_progress', 1, 1, '2023-05-15 09:05:10'),
       ('Trees', 'epic', 'in_progress', 1, 1, '2023-05-15 12:05:10'),
       ('task-3', 'task', 'ready_for_test', 2, 5, '2023-06-14 09:28:10'),
       ('task-4', 'task', 'ready_for_review', 2, 5, '2023-06-14 09:28:10'),
       ('task-5', 'task', 'todo', 2, 5, '2023-06-14 09:28:10'),
       ('task-6', 'task', 'done', 2, 5, '2023-06-14 09:28:10'),
       ('task-7', 'task', 'canceled', 2, 5, '2023-06-14 09:28:10');

INSERT INTO activity(author_id, task_id, updated, comment, title, description, estimate, type_code, status_code,
                     priority_code)
VALUES (1, 1, '2023-05-15 09:05:10', NULL, 'Data', NULL, 3, 'epic', 'in_progress', 'low'),
       (2, 1, '2023-05-15 12:25:10', NULL, 'Data', NULL, NULL, NULL, NULL, 'normal'),
       (1, 1, '2023-05-15 14:05:10', NULL, 'Data', NULL, 4, NULL, NULL, NULL),
       (1, 2, '2023-05-15 12:05:10', NULL, 'Trees', 'Trees desc', 4, 'epic', 'in_progress', 'normal');

INSERT INTO user_belong (object_id, object_type, user_id, user_type_code, startpoint, endpoint)
VALUES (1, 2, 2, 'task_developer', '2023-06-14 08:35:10', '2023-06-14 08:55:00'),
       (1, 2, 2, 'task_reviewer', '2023-06-14 09:35:10', NULL),
       (1, 2, 1, 'task_developer', '2023-06-12 11:40:00', '2023-06-12 12:35:00'),
       (1, 2, 1, 'task_developer', '2023-06-13 12:35:00', NULL),
       (1, 2, 1, 'task_tester', '2023-06-14 15:20:00', NULL),
       (2, 2, 2, 'task_developer', '2023-06-08 07:10:00', NULL),
       (2, 2, 1, 'task_developer', '2023-06-09 14:48:00', NULL),
       (2, 2, 1, 'task_tester', '2023-06-10 16:37:00', NULL);