# Step3のそれぞれの問題の回答

### 1. エピソード視聴数トップ3のエピソードタイトルと視聴数を取得
```sql
SELECT episodes.episode_title, SUM(views.views) AS total_views
FROM episodes
JOIN program_slots ON episodes.episode_id = program_slots.episode_id
JOIN views ON program_slots.slot_id = views.slot_id
GROUP BY episodes.episode_id
ORDER BY total_views DESC
LIMIT 3;
```

### 2. エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得
```sql
SELECT programs.program_title, seasons.season_number, episodes.episode_number, episodes.episode_title, SUM(views.views) AS total_views
FROM episodes
JOIN program_slots ON episodes.episode_id = program_slots.episode_id
JOIN views ON program_slots.slot_id = views.slot_id
JOIN programs ON episodes.program_id = programs.program_id
LEFT JOIN seasons ON episodes.season_id = seasons.season_id
GROUP BY episodes.episode_id
ORDER BY total_views DESC
LIMIT 3;
```

### 3. 本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得
```sql
SELECT channels.channel_name, program_slots.start_time, program_slots.end_time, seasons.season_number, episodes.episode_number, episodes.episode_title, episodes.episode_detail
FROM program_slots
JOIN channels ON program_slots.channel_id = channels.channel_id
JOIN episodes ON program_slots.episode_id = episodes.episode_id
LEFT JOIN seasons ON episodes.season_id = seasons.season_id
WHERE DATE(program_slots.start_time) = CURDATE()
ORDER BY program_slots.start_time;
```

### 4. ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分を取得
```sql
SELECT program_slots.start_time, program_slots.end_time, seasons.season_number, episodes.episode_number, episodes.episode_title, episodes.episode_detail
FROM program_slots
JOIN channels ON program_slots.channel_id = channels.channel_id
JOIN episodes ON program_slots.episode_id = episodes.episode_id
LEFT JOIN seasons ON episodes.season_id = seasons.season_id
WHERE channels.channel_name = 'ドラマ'
AND program_slots.start_time BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY program_slots.start_time;
```

### 5. 直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得
```sql
SELECT programs.program_title, SUM(views.views) AS total_views
FROM episodes
JOIN program_slots ON episodes.episode_id = program_slots.episode_id
JOIN views ON program_slots.slot_id = views.slot_id
JOIN programs ON episodes.program_id = programs.program_id
WHERE program_slots.start_time BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE()
GROUP BY programs.program_id
ORDER BY total_views DESC
LIMIT 2;
```

### 6. ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得
```sql
SELECT programs.genre, programs.program_title, AVG(views.views) AS average_views
FROM episodes
JOIN program_slots ON episodes.episode_id = program_slots.episode_id
JOIN views ON program_slots.slot_id = views.slot_id
JOIN programs ON episodes.program_id = programs.program_id
GROUP BY programs.program_id
ORDER BY programs.genre, average_views DESC;
```
