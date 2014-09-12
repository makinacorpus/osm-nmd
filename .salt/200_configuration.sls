{% import "makina-states/services/monitoring/circus/macros.jinja" as circus  with context %}
{% set cfg = opts.ms_project %}
{% set data = cfg.data %}
{% set scfg = salt['mc_utils.json_dump'](cfg) %}
include:
  - makina-states.services.monitoring.circus

tilemill-dir-{{cfg.name}}:
  file.directory:
    - name: {{cfg.data.files}}
    - makedirs: true
    - user: {{cfg.user}}
    - group: {{cfg.user}}
    - mode: 750
    - watch_in:
      - mc_proxy: circus-pre-restart

remove-svc-{{cfg.name}}:
  service.dead:
    - name: tilemill
  file.absent:
    - name: /etc/init/tilemill.conf
    - watch:
      - service: remove-svc-{{cfg.name}}

{% set circus_data = {
    "uid": cfg.user,
    "gid": cfg.group,
    "cmd": ("{0} index.js core"
            " --port {1} --files={2}"
            " --coreUrl={3}  --tileUrl={4}").format(
                cfg.data.node,
                cfg.data.ui_port,
                cfg.data.files,
                "{0}:{1}".format(cfg.data.ui_domain, cfg.data.port),
                "{0}:{1}".format(cfg.data.tiles_domain, cfg.data.port)
            ),
    "copy_env": True,
    "working_dir": '/usr/share/tilemill',
    "warmup_delay": "10",
    "environment": {"HOME": cfg.data.files},
    "max_age": 24*60*60 } %}
{{ circus.circusAddWatcher(cfg.name, **circus_data) }}
{% set circus_data = {
    "uid": cfg.user,
    "gid": cfg.group,
    "cmd": "{0} index.js tile --files={1} --port {2}".format(
      cfg.data.node, cfg.data.files, cfg.data.tiles_port),
    "copy_env": True,
    "working_dir": '/usr/share/tilemill',
    "warmup_delay": "10",
    "environment": {"HOME": cfg.data.files},
    "max_age": 24*60*60 } %}
{{ circus.circusAddWatcher(cfg.name+"-tiles", **circus_data) }}
