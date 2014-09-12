{% set cfg = opts.ms_project %}
{% set data = cfg.data %}
{% set pkgssettings = salt['mc_pkgs.settings']() %}
{% if grains['os_family'] in ['Debian'] %}
{% set dist = pkgssettings.udist %}
{% endif %}
{% if grains['os'] in ['Debian'] %}
{% set dist = pkgssettings.ubuntu_lts %}
{% endif %}
{{cfg.name}}-prereqs:
  pkgrepo.managed:
    - humanname: mapbox ppa
    - name: deb http://ppa.launchpad.net/developmentseed/mapbox/ubuntu {{dist}} main
    - dist: {{dist}}
    - file: {{ salt['mc_locations.settings']().conf_dir }}/apt/sources.list.d/mapbox.list
    - keyid: 0FB81AF3
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - pkgs:
      - tilemill
      - libmapnik
      - nodejs
      - apache2-utils
      - postgresql-client-common
      - gdal-bin
      - postgresql-client-9.3
