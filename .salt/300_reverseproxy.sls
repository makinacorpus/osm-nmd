{% set cfg = opts.ms_project %}
{% set data = cfg.data %}
{% set scfg = salt['mc_utils.json_dump'](cfg) %}
{% import "makina-states/services/http/nginx/init.sls" as nginx %}
include:
  - makina-states.services.http.nginx
{% set vhost = 'salt://makina-projects/{0}/files/nginx.conf'.format(cfg.name) %}
{{ nginx.virtualhost(
    domain=data.ui_domain,
    active=True,
    doc_root=cfg.data.files,
    vh_content_source=vhost, vcfg=cfg) }}

{{cfg.name}}-htaccess:
  file.managed:
    - name: {{data.htaccess}}
    - source: ''
    - user: www-data
    - group: www-data
    - mode: 770

{% for userdata in data.users %}
{% for user, passwd in userdata.items() %}
{{cfg.name}}-{{user}}-htaccess:
  webutil.user_exists:
    - name: {{user}}
    - password: {{passwd}}
    - htpasswd_file: {{data.htaccess}}
    - options: m
    - force: true
    - watch:
      - file: {{cfg.name}}-htaccess
    - watch_in:
      - mc_proxy: nginx-pre-conf-hook
{% endfor%}
{% endfor%}
#    vh_top_source=data.nginx_ui_upstreams,
