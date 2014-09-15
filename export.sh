node /usr/share/tilemill/index.js export osmnmd france.mbtiles --config=export.france.json
node /usr/share/tilemill/index.js export osmnmd pdl.mbtiles --config=export.nantes.json
node /usr/share/tilemill/index.js export osmnmd nantes.mbtiles --config=export.nantes.json
sqlite3 nantes.mbtiles < merge.sql
rm -rf france.* pdl.*