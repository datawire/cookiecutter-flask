#!/usr/bin/env bash
set -euo pipefail

set +u
source /opt/{{ cookiecutter.project_name }}/venv/bin/activate
set -u

/usr/sbin/nginx && /usr/bin/uwsgi --ini /opt/{{ cookiecutter.project_name }}/config/uwsgi.ini