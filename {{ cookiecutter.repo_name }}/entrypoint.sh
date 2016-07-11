#!/usr/bin/env bash
set -euo pipefail

/usr/sbin/nginx && /usr/bin/uwsgi --ini /opt/{{ cookiecutter.project_name }}/config/uwsgi.ini