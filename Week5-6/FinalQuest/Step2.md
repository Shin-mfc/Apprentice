## テーブル構築からデータを入れるまでの手順（Step2）

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
  title VARCHAR(100) NOT NULL,
  description TEXT,
  genre VARCHAR(50) NOT NULL,
  UNIQUE (title)
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
  title VARCHAR(100) NOT NULL,
  description TEXT,
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
-- channels テーブルのデータを挿入
INSERT INTO channels(channel_name) VALUES
('Anime'),
('Drama'),
('Sports'),
('Pets'),
('Movies'),
('Comedy');

-- programs テーブルのデータを挿入
INSERT INTO programs(program_title, program_detail) VALUES
('Pokemon', 'A popular anime about a young Pokemon Trainer and his journey.'),
('Friends', 'A story about six friends living in New York.'),
('Game of Thrones', 'A fantasy drama series based on the novels by George R. R. Martin.'),
('NARUTO', 'A popular anime about a young ninja named Naruto Uzumaki.'),
('Stranger Things', 'A sci-fi horror series set in the 1980s.'),
('Breaking Bad', 'A high school chemistry teacher turned methamphetamine manufacturing drug dealer.'),
('The Simpsons', 'An animated sitcom depicting the life of the Simpson family.');

-- seasons テーブルのデータを挿入
INSERT INTO seasons(program_id, season_number) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(3, 3),
(4, 1),
(4, 2),
(5, 1),
(5, 2),
(6, 1),
(6, 2),
(6, 3),
(7, 1),
(7, 2),
(7, 3);

-- episodes テーブルのデータを挿入
INSERT INTO episodes(season_id, episode_number, episode_title, episode_detail, duration, air_date, view_count) VALUES
(1, 1, 'Pokemon - Episode 1', 'The journey starts.', '20m', '2023-01-01 00:00:00', 100),
(1, 2, 'Pokemon - Episode 2', 'Ash catches his first Pokemon.', '20m', '2023-01-02 00:00:00', 120),
(2, 1, 'Friends - Episode 1', 'They all meet for the first time.', '30m', '2023-01-01 00:00:00', 200),
(2, 2, 'Friends - Episode 2', 'Ross learns about his ex-wife.', '30m', '2023-01-02 00:00:00', 210),
(3, 1, 'Game of Thrones - Episode 1', 'A Game of Thrones.', '50m', '2023-01-01 00:00:00', 300),
(3, 2, 'Game of Thrones - Episode 2', 'A Clash of Kings.', '50m', '2023-01-02 00:00:00', 350),
(4, 1, 'NARUTO - Episode 1', 'Naruto becomes a ninja.', '22m', '2023-01-01 00:00:00', 250),
(4, 2, 'NARUTO - Episode 2', 'Naruto meets his team.', '22m', '2023-01-02 00:00:00', 275),
(5, 1, 'Stranger Things - Episode 1', 'A boy goes missing.', '50m', '2023-01-01 00:00:00', 310),
(5, 2, 'Stranger Things - Episode 2', 'A mysterious girl appears.', '50m', '2023-01-02 00:00:00', 325),
(6, 1, 'Breaking Bad - Episode 1', 'Walter learns about his condition.', '60m', '2023-01-01 00:00:00', 420),
(6, 2, 'Breaking Bad - Episode 2', 'Walter starts his meth operation.', '60m', '2023-01-02 00:00:00', 450),
(7, 1, 'The Simpsons - Episode 1', 'The Simpsons get a new pet.', '30m', '2023-01-01 00:00:00', 380),
(7, 2, 'The Simpsons - Episode 2', 'Bart gets in trouble at school.', '30m', '2023-01-02 00:00:00', 390);

-- broadcasts テーブルのデータを挿入
INSERT INTO broadcasts(channel_id, episode_id, start_time, end_time) VALUES
(1, 1, '2023-05-18 08:00:00', '2023-05-18 08:20:00'),
(1, 2, '2023-05-18 09:00:00', '2023-05-18 09:20:00'),
(2, 3, '2023-05-18 10:00:00', '2023-05-18 10:30:00'),
(2, 4, '2023-05-18 11:00:00', '2023-05-18 11:30:00'),
(3, 5, '2023-05-18 12:00:00', '2023-05-18 12:50:00'),
(3, 6, '2023-05-18 13:00:00', '2023-05-18 13:50:00'),
(4, 7, '2023-05-18 14:00:00', '2023-05-18 14:22:00'),
(4, 8, '2023-05-18 15:00:00', '2023-05-18 15:22:00'),
(5, 9, '2023-05-18 16:00:00', '2023-05-18 16:50:00'),
(5, 10, '2023-05-18 17:00:00', '2023-05-18 17:50:00'),
(6, 11, '2023-05-18 18:00:00', '2023-05-18 19:00:00'),
(6, 12, '2023-05-18 20:00:00', '2023-05-18 21:00:00'),
(7, 13, '2023-05-18 22:00:00', '2023-05-18 22:30:00'),
(7, 14, '2023-05-19 23:00:00', '2023-05-19 23:30:00');

-- program_genres テーブルのデータを挿入
INSERT INTO program_genres(program_id, genre_id) VALUES
(1, 1),
(2, 6),
(3, 2),
(4, 1),
(5, 2),
(6, 2),
(7, 6);
```
