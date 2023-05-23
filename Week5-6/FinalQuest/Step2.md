# テーブル構築からデータを入れるまでの手順（Step2）

以下にStep1で設計したテーブルの構築とサンプルデータの格納の流れを説明します。

### 1. データベースの作成
最初にMySQLを起動し、新しいデータベースを作成します。以下のコマンドを使用してデータベースを作成してください。

```sql
CREATE DATABASE internet_tv;
```

### 2. テーブルの作成
次に、各テーブルを作成します。まずは、データベースに接続します。

```sql
USE internet_tv;
```

そして、各テーブルを作成します。以下に各テーブルの作成コマンド書いたので、コピーしてテーブルを作成してください。

```sql
CREATE TABLE channels (
  channel_id INT PRIMARY KEY AUTO_INCREMENT,
  channel_name VARCHAR(100) NOT NULL
);

CREATE TABLE programs (
  program_id INT PRIMARY KEY AUTO_INCREMENT,
  program_title VARCHAR(100) NOT NULL,
  program_detail TEXT,
  genre VARCHAR(50) NOT NULL,
  UNIQUE (program_title)
);

CREATE TABLE seasons (
  season_id INT PRIMARY KEY AUTO_INCREMENT,
  program_id INT NOT NULL,
  season_number INT NOT NULL,
  FOREIGN KEY (program_id) REFERENCES programs(program_id),
  UNIQUE (program_id, season_number)
);

CREATE TABLE episodes (
  episode_id INT PRIMARY KEY AUTO_INCREMENT,
  season_id INT,
  program_id INT NOT NULL,
  episode_number INT,
  episode_title VARCHAR(100) NOT NULL,
  episode_detail TEXT,
  duration TIME NOT NULL,
  air_date DATE NOT NULL,
  FOREIGN KEY (season_id) REFERENCES seasons(season_id),
  FOREIGN KEY (program_id) REFERENCES programs(program_id),
  UNIQUE (season_id, episode_number)
);

CREATE TABLE program_slots (
  slot_id INT PRIMARY KEY AUTO_INCREMENT,
  channel_id INT NOT NULL,
  episode_id INT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  FOREIGN KEY (channel_id) REFERENCES channels(channel_id),
  FOREIGN KEY (episode_id) REFERENCES episodes(episode_id),
  UNIQUE (channel_id, start_time, end_time)
);

CREATE TABLE views (
  view_id INT PRIMARY KEY AUTO_INCREMENT,
  slot_id INT NOT NULL,
  views INT NOT NULL DEFAULT 0,
  FOREIGN KEY (slot_id) REFERENCES program_slots(slot_id)
);
```

### 3. サンプルデータの挿入
最後に、各テーブルにサンプルデータを挿入します。以下に各テーブルに挿入するデータのSQLコマンドを書いたので、コピーしてデータを入れてください。

```sql
INSERT INTO channels (channel_name)
VALUES ('Drama1'), 
       ('Drama2'), 
       ('Anime1'), 
       ('Anime2'), 
       ('Sports'), 
       ('Pets');

INSERT INTO programs (program_title, program_detail, genre)
VALUES ('Pokemon', 'Adventure of Pokemon trainers', 'Anime'),
       ('Friends', 'Story of 6 friends in New York', 'Drama'),
       ('Game of Thrones', 'A political drama in a fantasy setting', 'Drama'),
       ('NARUTO', 'Adventure of a ninja named Naruto', 'Anime'),
       ('Stranger Things', 'Mysterious events in a small town', 'Drama'),
       ('Breaking Bad', 'A high school chemistry teacher turned methamphetamine manufacturing drug dealer', 'Drama'),
       ('The Simpsons', 'Family life in a fictional American city', 'Anime');

INSERT INTO seasons (program_id, season_number)
VALUES (1, 1), 
       (1, 2),
       (1, 3),
       (1, 4),
       (2, 1), 
       (2, 2),
       (2, 3),
       (2, 4),
       (3, 1),
       (3, 2),
       (3, 3),
       (3, 4),
       (4, 1), 
       (4, 2),
       (4, 3),
       (4, 4),
       (5, 1), 
       (5, 2),
       (5, 3),
       (5, 4),
       (6, 1), 
       (6, 2),
       (6, 3),
       (6, 4),
       (7, 1), 
       (7, 2),
       (7, 3),
       (7, 4);


INSERT INTO episodes (season_id, program_id, episode_number, episode_title, episode_detail, duration, air_date)
VALUES (1, 1, 1, 'Pokemon S01E01', 'First episode of Pokemon season 1', '00:20:00', '2023-01-01'),
       (2, 1, 1, 'Pokemon S02E01', 'First episode of Pokemon season 2', '00:20:00', '2023-02-01'),
       (3, 2, 1, 'Friends S01E01', 'First episode of Friends season 1', '00:30:00', '2023-01-01'),
       (4, 2, 1, 'Friends S02E01', 'First episode of Friends season 2', '00:30:00', '2023-02-01'),
       (5, 3, 1, 'Game of Thrones S01E01', 'First episode of Game of Thrones season 1', '01:00:00', '2023-01-01'),
       (6, 3, 1, 'Game of Thrones S02E01', 'First episode of Game of Thrones season 2', '01:00:00', '2023-02-01'),
       (7, 4, 1, 'NARUTO S01E01', 'First episode of NARUTO season 1', '00:23:00', '2023-01-01'),
       (8, 4, 1, 'NARUTO S02E01', 'First episode of NARUTO season 2', '00:23:00', '2023-02-01'),
       (9, 5, 1, 'Stranger Things S01E01', 'First episode of Stranger Things season 1', '00:50:00', '2023-01-01'),
       (10, 5, 1, 'Stranger Things S02E01', 'First episode of Stranger Things season 2', '00:50:00', '2023-02-01'),
       (11, 6, 1, 'Breaking Bad S01E01', 'First episode of Breaking Bad season 1', '00:50:00', '2023-01-01'),
       (12, 6, 1, 'Breaking Bad S02E01', 'First episode of Breaking Bad season 2', '00:50:00', '2023-02-01'),
       (13, 7, 1, 'The Simpsons S01E01', 'First episode of The Simpsons season 1', '00:22:00', '2023-01-01'),
       (14, 7, 1, 'The Simpsons S02E01', 'First episode of The Simpsons season 2', '00:22:00', '2023-02-01'),
       (15, 1, 1, 'Pokemon S01E02', 'Second episode of Pokemon season 1', '00:21:00', '2023-01-02'),
       (16, 1, 1, 'Pokemon S02E02', 'Second episode of Pokemon season 2', '00:21:00', '2023-02-02'),
       (17, 2, 1, 'Friends S01E02', 'Second episode of Friends season 1', '00:22:00', '2023-01-02'),
       (18, 2, 1, 'Friends S02E02', 'Second episode of Friends season 2', '00:22:00', '2023-02-02'),
       (19, 3, 1, 'Game of Thrones S01E02', 'Second episode of Game of Thrones season 1', '00:56:00', '2023-01-02'),
       (20, 3, 1, 'Game of Thrones S02E02', 'Second episode of Game of Thrones season 2', '00:56:00', '2023-02-02'),
       (21, 4, 1, 'NARUTO S01E02', 'Second episode of NARUTO season 1', '00:23:00', '2023-01-02'),
       (22, 4, 1, 'NARUTO S02E02', 'Second episode of NARUTO season 2', '00:23:00', '2023-02-02'),
       (23, 5, 1, 'Stranger Things S01E02', 'Second episode of Stranger Things season 1', '00:48:00', '2023-01-02'),
       (24, 5, 1, 'Stranger Things S02E02', 'Second episode of Stranger Things season 2', '00:48:00', '2023-02-02'),
       (25, 6, 1, 'Breaking Bad S01E02', 'Second episode of Breaking Bad season 1', '00:47:00', '2023-01-02'),
       (26, 6, 1, 'Breaking Bad S02E02', 'Second episode of Breaking Bad season 2', '00:47:00', '2023-02-02'),
       (27, 7, 1, 'The Simpsons S01E02', 'Second episode of The Simpsons season 1', '00:23:00', '2023-01-02'),
       (28, 7, 1, 'The Simpsons S02E02', 'Second episode of The Simpsons season 2', '00:23:00', '2023-02-02');

INSERT INTO program_slots (channel_id, episode_id, start_time, end_time)
VALUES (1, 1, '2023-01-01 20:00:00', '2023-01-01 20:20:00'),
       (1, 2, '2023-02-01 20:00:00', '2023-02-01 20:20:00'),
       (2, 3, '2023-01-01 20:30:00', '2023-01-01 21:00:00'),
       (2, 4, '2023-02-01 20:30:00', '2023-02-01 21:00:00'),
       (3, 5, '2023-01-01 21:00:00', '2023-01-01 22:00:00'),
       (3, 6, '2023-02-01 21:00:00', '2023-02-01 22:00:00'),
       (4, 7, '2023-01-01 20:00:00', '2023-01-01 20:23:00'),
       (4, 8, '2023-02-01 20:00:00', '2023-02-01 20:23:00'),
       (5, 9, '2023-01-01 22:00:00', '2023-01-01 22:50:00'),
       (5, 10, '2023-02-01 22:00:00', '2023-02-01 22:50:00'),
       (6, 11, '2023-01-01 23:00:00', '2023-01-01 23:50:00'),
       (6, 12, '2023-02-01 23:00:00', '2023-02-01 23:50:00'),
       (1, 13, '2023-01-01 21:00:00', '2023-01-01 21:22:00'),
       (1, 14, '2023-02-01 21:00:00', '2023-02-01 21:22:00'),
       (2, 15, '2023-01-02 20:30:00', '2023-02-02 20:51:00'),
       (2, 16, '2023-02-02 20:30:00', '2023-02-02 20:51:00'),
       (3, 17, '2023-01-02 21:00:00', '2023-01-02 21:22:00'),
       (3, 18, '2023-02-02 21:00:00', '2023-02-02 21:22:00'),
       (4, 19, '2023-01-02 21:00:00', '2023-01-02 21:56:00'),
       (4, 20, '2023-02-02 21:00:00', '2023-02-02 21:56:00'),
       (5, 21, '2023-01-02 22:00:00', '2023-01-02 22:23:00'),
       (5, 22, '2023-02-02 22:00:00', '2023-02-02 22:23:00'),
       (6, 23, '2023-01-02 23:00:00', '2023-01-02 23:48:00'),
       (6, 24, '2023-02-02 23:00:00', '2023-02-02 23:48:00'),
       (1, 25, '2023-01-02 21:00:00', '2023-01-02 21:47:00'),
       (1, 26, '2023-02-02 21:00:00', '2023-02-02 21:47:00'),
       (1, 27, '2023-01-02 22:00:00', '2023-01-02 22:23:00'),
       (1, 28, '2023-02-02 22:00:00', '2023-02-02 22:23:00');

INSERT INTO views (slot_id, views)
VALUES (1, 1000),
       (2, 1500),
       (3, 2000),
       (4, 1800),
       (5, 2100),
       (6, 2700),
       (7, 3000),
       (8, 2800),
       (9, 2400),
       (10, 2600),
       (11, 2500),
       (12, 2700),
       (13, 2900),
       (14, 3000),
       (15, 2200),
       (16, 2400),
       (17, 2500),
       (18, 3000),
       (19, 2800),
       (20, 2600),
       (21, 2400),
       (22, 2500),
       (23, 2700),
       (24, 2900),
       (25, 3000),
       (26, 2600),
       (27, 2700);
```
