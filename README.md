OSM Bright
==========

![screenshot](https://raw.github.com/mapbox/osm-bright/master/preview.png)

OSM Bright is a sensible starting point for quickly making beautiful maps based
on an OpenStreetMap database. It is written in the [Carto][] styling language
and can be opened as a project in [TileMill][].

The style is still a work in progress and you are encouraged to use the
[issue tracker][] to note missing features or problems with the current
implementation. 

[Carto]: http://github.com/mapbox/carto/
[TileMill]: http://tilemill.com/
[issue tracker]: http://github.com/mapbox/osm-bright/issues/

Setup Instructions
------------------

### 1. Download shapefiles

OSM Bright depends on several large shapefiles. You should start downloading these
now so that they are ready later when you need them for rendering.

Download them to the `osm-bright` directory. You can do this with `wget` like:

    wget http://tilemill-data.s3.amazonaws.com/osm/coastline-good.zip
    wget http://tilemill-data.s3.amazonaws.com/osm/shoreline_300.zip
    wget http://mapbox-geodata.s3.amazonaws.com/natural-earth-1.3.0/physical/10m-land.zip

### 2. Set up PostgreSQL & PostGIS ###

If you don't already, you need to have [PostgreSQL][] installed & running with
a [PostGIS][] database setup within it. See the [PostGIS documentation][1] for
full information on how to do this

[PostgreSQL]: http://postgresql.org/
[PostGIS]: http://postgis.refractions.net/
[1]: http://postgis.net/documentation

### 2. Import OpenStreetMap data ###

You will need an OSM database extract in one of the following formats:

- .osm.pbf (binary; smallest & fastest)
- .osm.bz2 (compressed xml)
- .osm (xml)

You can find appropriate data extracts for a variety of regions at
<http://download.geofabrik.de> or <http://metro.teczno.com>. See
[the OSM wiki][2] for information about (very large) full-planet downloads.

You need to process this data and import it to your PostGIS database. You can
do this with either [Imposm][] or [osm2pgsql][]; see their respective websites
for installation instructions.

#### Using Imposm

If you are using Imposm, you should use the [included mapping configuration][4]
which includes a few important tags compared to the default. The Imposm import 
command looks like this:

    imposm -U <postgres_user> -d <postgis_database> \
      -m /path/to/osm-bright/imposm-mapping.py --read --write \
      --optimize --deploy-production-tables <data.osm.pbf>

See `imposm --help` or the [online documentation][3] for more details.

#### Using osm2pgsql

If you are using osm2pgsql the default style file should work well. The 
osm2pgsql import command looks like this:

    osm2pgsql -c -G -U <postgres_user> -d <postgis_database> <data.osm.pbf>

See `man osm2pgsql` or the [online documentation][5] for more details.

[2]: http://wiki.openstreetmap.org/wiki/Planet
[Imposm]: http://imposm.org/
[3]: http://imposm.org/
[4]: https://github.com/mapbox/osm-bright/blob/master/imposm-mapping.py
[osm2pgsql]: http://wiki.openstreetmap.org/wiki/Osm2pgsql
[5]: http://wiki.openstreetmap.org/wiki/Osm2pgsql

### 3. Edit the configuration ###

You'll need to adjust some settings for things like your PostgreSQL connection
information.

1. Make a copy of `configure.py.sample` and name it `configure.py`.

    cp configure.py.sample configure.py

2. Open `configure.py` in a text editor.
3. Make sure the "importer" option matches the program you used to import your 
   data (either "imposm" or "osm2pgsql").
4. Optionally change the name of your project from the default, 'OSM Bright'.
5. Adjust, if needed, the path to point to your MapBox project folder.
6. Make any adjustments to the PostgreSQL connection settings. Your database
   may be set up so that you require a password or different user name.
7. Optionally adjust the query extents or shapefile locations. (Refer to the 
   comments in the configuration file for more information.)
8. Save & close the file.

### 4. Run make.py ###

    ./make.py

This will create a new folder called "build" with your new project, customized
with the variables you set in `configure.py` and install a copy of this build
to your MapBox project folder. If you open up TileMill you should see your new
map in the project listing.

Click on the map to view it in the editing interface.

### IMPORTANT

Have patience: the first time the project opens it needs to download very large
shapefiles before the map can render. This can take 5-10 minutes on a fast
connection and longer on a slow connection. Keep TileMill open and feel free to
navigate back to the projects view then back to the project editor view to check
on its loading status. You can also check the TileMill logs to see the download
status of the remote files.

Once the map tiles show up, you're now ready to start editing the template in TileMill!

How to generate the tiles
=========================

read the doc https://www.mapbox.com/tilemill/docs/manual/exporting/

  cd /Applications/TileMill.app/Contents/Resources/
  ./index.js export osmnmd france.mbtiles --config=/Users/toutpt/makina/nmd/carteeco/osm-nmd/tilemill-export-args-france.json
  ./index.js export osmnmdnantes nantes.mbtiles --config=/Users/toutpt/makina/nmd/carteeco/osm-nmd/tilemill-export-args-nantes.json


  ./index.js export osmnmd pdl.mbtiles --bbox="-2.58728,46.24445,0.95581,48.58206 " --minzoom=11 --maxzoom=13 

--bbox="xmin,ymin,xmax,ymax"
--bbox="-131.4844,20.3034,-62.5781,51.3992"

Now we need to merge the mbtiles

  sqlite3 nantes.mbtiles

> SELECT * FROM metadata;

bounds|-1.7242,47.1496,-1.4069,47.3109
center|-1.5525,47.2121,11
minzoom|10
maxzoom|19
attribution|Data © OpenStreetMap (and) contributors, CC-BY-SA
description|
name|osmnmd-nantes
template|
version|1.0.0

sqlite> UPDATE metadata SET value = '7' WHERE name = 'minzoom';
sqlite> ATTACH 'france.mbtiles' AS france;
sqlite> INSERT OR REPLACE INTO images SELECT * from france.images;
sqlite> INSERT OR REPLACE INTO map SELECT * from france.map;


./index.js export osmnmd pdl.mbtiles --bbox="-2.58728,46.24445,0.95581,48.58206 " --minzoom=11 --maxzoom=13 

sqlite> ATTACH 'pdl.mbtiles' AS pdl;
sqlite> INSERT OR REPLACE INTO images SELECT * from pdl.images;
sqlite> INSERT OR REPLACE INTO map SELECT * from pdl.map;


