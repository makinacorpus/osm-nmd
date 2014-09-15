UPDATE metadata SET value = '7' WHERE name = 'minzoom';
ATTACH 'france.mbtiles' AS france;
INSERT OR REPLACE INTO images SELECT * from france.images;
INSERT OR REPLACE INTO map SELECT * from france.map;
