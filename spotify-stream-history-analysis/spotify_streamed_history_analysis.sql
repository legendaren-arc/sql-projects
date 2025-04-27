-- query to retrieve all records from the spotify_stream table before
SELECT *
FROM spotify_data.spotify_stream;

-- I. Data Cleaning: Handling Missing and Unnecessary Data
-- a. query for checking the completeness of data: Counting NULL and missing values in key columns
SELECT 
    COUNT(*) AS total_rows,
    COUNT(NULLIF(ts, 'None')) AS ts_filled,
    COUNT(NULLIF(platform, 'None')) AS platform_filled,
    COUNT(NULLIF(ms_played, 'None')) AS ms_played_filled,
    COUNT(NULLIF(conn_country, 'None')) AS conn_country_filled,
    COUNT(NULLIF(ip_addr, 'None')) AS ip_addr_filled,
    COUNT(NULLIF(master_metadata_track_name, 'None')) AS track_name_filled,
    COUNT(NULLIF(master_metadata_album_artist_name, 'None')) AS artist_filled,
    COUNT(NULLIF(master_metadata_album_album_name, 'None')) AS album_filled,
    COUNT(NULLIF(spotify_track_uri, 'None')) AS track_uri_filled,
    COUNT(NULLIF(episode_name, 'None')) AS episode_name_filled,
    COUNT(NULLIF(episode_show_name, 'None')) AS show_name_filled,
    COUNT(NULLIF(spotify_episode_uri, 'None')) AS episode_uri_filled,
    COUNT(NULLIF(audiobook_title, 'None')) AS audiobook_title_filled,
    COUNT(NULLIF(audiobook_uri, 'None')) AS audiobook_uri_filled,
    COUNT(NULLIF(audiobook_chapter_uri, 'None')) AS audiobook_chapter_filled,
    COUNT(NULLIF(audiobook_chapter_title, 'None')) AS audiobook_chapter_title_filled,
    COUNT(NULLIF(reason_start, 'None')) AS reason_start_filled,
    COUNT(NULLIF(reason_end, 'None')) AS reason_end_filled,
    COUNT(NULLIF(shuffle, 'None')) AS shuffle_filled,
    COUNT(NULLIF(skipped, 'None')) AS skipped_filled,
    COUNT(NULLIF(`offline`, 'None')) AS offline_filled,
    COUNT(NULLIF(offline_timestamp, 'None')) AS offline_timestamp_filled,
    COUNT(NULLIF(incognito_mode, 'None')) AS incognito_mode_filled
FROM spotify_stream;

-- b. query to remove unnecessary columns unrelated to music streaming analysis
ALTER TABLE spotify_stream 
DROP COLUMN ip_addr,
DROP COLUMN spotify_track_uri,
DROP COLUMN episode_name,
DROP COLUMN episode_show_name,
DROP COLUMN spotify_episode_uri, 
DROP COLUMN audiobook_title,
DROP COLUMN audiobook_uri, 
DROP COLUMN audiobook_chapter_uri,
DROP COLUMN audiobook_chapter_title, 
DROP COLUMN reason_start, 
DROP COLUMN reason_end,
DROP COLUMN shuffle,
DROP COLUMN `offline`,
DROP COLUMN offline_timestamp, 
DROP COLUMN incognito_mode;

-- c. query to remove entries where playback duration is zero (likely accidental plays or buffering)
DELETE FROM spotify_stream
WHERE ms_played = 0.00;

-- II. Data Transformation: Converting and Formatting Data
-- a. query to add new column to store the corrected timestamp in DATETIME format
 ALTER TABLE 
 spotify_stream 
 ADD COLUMN 
 track_timestamp DATETIME;
 
-- b. query to allow updates in MySQL without primary keys
SET SQL_SAFE_UPDATES = 0; 

-- c. query to convert the timestamp from UTC (default) to Philippine Standard Time (UTC+8)
UPDATE spotify_stream
SET track_timestamp = convert_tz(
	STR_TO_DATE(ts, '%Y-%m-%dT%H:%i:%sZ'), #Converts the stored string from ts into MySQL's DATETIME format.
    	'+00:00',
    	'+08:00' #Converts UTC (+00:00) to Philippine Time (+08:00).
);

-- d. query to verify successful timestamp conversion
SELECT ts, 
	track_timestamp 
        FROM spotify_stream; 
        
-- e. query to ensure all timestamps were updated correctly
SELECT 
	COUNT(ts) AS ts_filled,
    	COUNT(track_timestamp) AS track_timestamp_filled
FROM spotify_stream;
        
-- f. query to drop the original `ts` column since the formatted `track_timestamp` will be used
ALTER TABLE spotify_stream 
DROP COLUMN ts;

-- III. Feature Engineering: Extracting Useful Information from Timestamps
-- a. query to add a column to store the name of the month the track was played
ALTER TABLE spotify_stream
ADD COLUMN  month_played VARCHAR(20);

-- b. query to populate month column using the MONTHNAME function
UPDATE spotify_stream
SET month_played = MONTHNAME(track_timestamp); # Returns the full name of the month for date in MySQL

-- c. query to add column for the day of the week (e.g., Monday, Tuesday, etc.)
ALTER TABLE spotify_stream
ADD COLUMN stream_day VARCHAR(20);

-- d. query to populate the day of the week column
UPDATE spotify_stream
SET stream_day = DAYNAME(track_timestamp);

-- e. query to add column for the exact time the track was streamed
ALTER TABLE spotify_stream
ADD COLUMN streamed_at TIME;
 
-- f. query to populate the time from the timestamp
UPDATE spotify_stream
SET streamed_at = TIME(track_timestamp);

-- g. query to ensure new features are correctly populated
SELECT track_timestamp,
	month_played,
	stream_day,
	streamed_at
FROM spotify_stream;

-- h. query to verify if the populated columns has no null values
SELECT
	COUNT(track_timestamp) AS track_timestamp_filled,
	COUNT(month_played) AS month_played_filled,
	COUNT(stream_day) AS stream_day_filled,
	COUNT(streamed_at) AS streamed_at_filled
FROM spotify_stream;

-- i. query to filter all columns (check new updated table)
SELECT *
FROM spotify_data.spotify_stream;


-- j. query to add column to store playback duration in minutes
ALTER TABLE spotify_stream 
ADD COLUMN stream_duration DECIMAL(10,2);

-- k. query to disables the sql safe update, since the data has no primary key
SET SQL_SAFE_UPDATES = 0; 

-- l. query to convert milliseconds to minutes (rounded to 2 decimal places)
UPDATE spotify_stream 
SET stream_duration = ROUND(ms_played / 60000, 2); 

-- m. query to check if the conversion was succesfull
SELECT ms_played, 
       stream_duration 
FROM spotify_stream;

-- n. query to verify if all rows have data
SELECT 
	COUNT(ms_played) AS ms_played_filled,
    	COUNT(stream_duration) AS stream_duration_filled
FROM spotify_stream;

-- IV. Standardizing Column Names and Data Types
-- a. Renaming columns for clarity and consistency
ALTER TABLE spotify_stream
CHANGE COLUMN ms_played ms_duration DECIMAL (10,2),
CHANGE COLUMN master_metadata_track_name music_title VARCHAR(255),
CHANGE COLUMN master_metadata_album_artist_name artist_name VARCHAR(255),
CHANGE COLUMN master_metadata_album_album_name album_name VARCHAR(255);

-- query to filter all columns
SELECT *
FROM spotify_data.spotify_stream;


-- V. Data Analysis Queries
-- A. Time-Based Listening Habits
-- a. query to determine peak listening hours
SELECT HOUR(streamed_at) AS peak_time, 
COUNT(*) AS total_streamed_tracks
FROM spotify_stream
GROUP BY peak_time
ORDER BY total_streamed_tracks DESC;

-- b. query to identify which day of the week has the highest number of streamed songs
SELECT stream_day,
COUNT(*) AS streamed_tracks_per_day
FROM spotify_stream
GROUP BY stream_day
ORDER BY streamed_tracks_per_day DESC; 

-- c. query to analyze listening trends by month
SELECT 
	YEAR(track_timestamp) AS stream_year,
	month_played,
	COUNT(*) AS total_streamed
FROM spotify_stream
WHERE YEAR(track_timestamp) IN (2023, 2024) 
GROUP BY stream_year, month_played
ORDER BY stream_year, total_streamed DESC;

-- d.  query to analyze what months has the most streamed songs  
SELECT month_played, 
COUNT(*) AS streamed_music
FROM spotify_stream
GROUP BY month_played 
ORDER BY streamed_musiC DESC;


-- B. Artist & Song Analysis
-- a. query to determine Top 10 artist based on the number of unique songs played
SELECT artist_name, 
COUNT(DISTINCT music_title) AS number_of_streamed_songs
FROM spotify_stream
WHERE stream_duration > 1.00
GROUP BY artist_name
ORDER BY number_of_streamed_songs DESC
LIMIT 10; 

-- b. query to filter Top 20 most played songs
SELECT music_title, COUNT(*) AS total_streams 
FROM spotify_stream
WHERE stream_duration > 1.00
GROUP BY music_title
ORDER BY total_streams DESC
LIMIT 20;


-- C. USER BEHAVIOR ANALYSIS 
-- a. query for Short-Stream & Skip Behavior Study
SELECT 
	COUNT(CASE WHEN skipped = 'True' THEN 1 END) AS skipped_cases,
	COUNT(CASE WHEN stream_duration < 1 THEN 1 END) AS short_stream_music
FROM spotify_stream;

SELECT 
	COUNT(CASE WHEN skipped = 'False' THEN 1 END) AS non_skipped_cases,
	COUNT(CASE WHEN stream_duration > 1 THEN 1 END) AS longer_stream_music
FROM spotify_stream;

-- b. query for Platform Usage Trends
SELECT DISTINCT(platform) AS platform_used,
COUNT(music_title) AS number_of_streamed_tracks
FROM spotify_stream
GROUP BY platform_used
ORDER BY number_of_streamed_tracks DESC;

-- query to retrieve the updated table
SELECT *
FROM spotify_data.spotify_stream;
