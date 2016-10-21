CREATE DATABASE lcot;

USE lcot;

CREATE  EXTERNAL TABLE IF NOT EXISTS prenoms(
prenom STRING, 
gender VARCHAR(3),
origin ARRAY<STRING>,
version DOUBLE)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\073'
COLLECTION ITEMS TERMINATED BY ','
STORED AS TEXTFILE LOCATION '/user/lcot/tp3';

SELECT split_origin, COUNT(prenom) 
FROM lcot.prenoms 
LATERAL VIEW explode(prenoms.origin) tabOrigin AS split_origin
GROUP BY split_origin;

SELECT size(origin), COUNT(prenom) 
FROM lcot.prenoms
GROUP BY size(origin);

SELECT gender_male.gender, gender_male.count/total.count*100
FROM (SELECT COUNT(prenom) AS count, gender
	FROM lcot.prenoms GROUP BY gender) gender_male
	(SELECT COUNT(prenom) AS count FROM lcot.prenoms) total;

