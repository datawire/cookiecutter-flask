FROM alpine:3.4
MAINTAINER Datawire <dev@datawire.io>
EXPOSE 5000

LABEL PROJECT_REPO_URL         = "{{ cookiecutter.repo_url }}"
LABEL PROJECT_REPO_BROWSER_URL = "{{ cookiecutter.repo_browser_url }}"
LABEL DESCRIPTION              = "Datawire {{ cookiecutter.name }}"
LABEL VENDOR                   = "Datawire"
LABEL VENDOR_URL               = "https://datawire.io/"

# --------------------------------------------------------------------------------------------------
# Install OS packages
#
# * linux-headers and pcre-dev: required by uwsgi installation via pip
# * nginx will push traffic to uwsgi
# * bash is for convenient debugging
# 

RUN apk add --update \
    bash \
    build-base \
    linux-headers \
    musl \
    nginx \
    pcre-dev \
    python \
    python-dev \
    py-pip \
  && pip install --upgrade pip \
  && rm /var/cache/apk/*

# Ensure some useful symlinks exist
RUN cd /usr/bin \
  && ln -sf easy_install-2.7 easy_install \
  && ln -sf python2.7 python \
  && ln -sf python2.7-config python-config \
  && ln -sf pip2.7 pip    

# --------------------------------------------------------------------------------------------------
# Install app/service dependencies
#
# * Install Datawire Quark
# * Install any Python dependencies indicated in requirements.txt
# * Configure Nginx
  
ADD https://raw.githubusercontent.com/datawire/quark/master/install.sh /tmp
RUN bash -s /tmp/install.sh -- master

COPY requirements.txt /tmp/requirements.txt
RUN pip install -Ur /tmp/requirements.txt \
  && rm /tmp/requirements.txt
  
# TODO: We need a good way to share Quark requirements between the computer running Docker and the
# container being built. Perhaps a `Quarkfile` or a `quark-deps` that lists the dependencies.
# RUN quark install ...  

COPY service /opt/{{ cookiecutter.project_name }}/service
COPY config  /opt/{{ cookiecutter.project_name }}/config
COPY entrypoint.sh /opt/{{ cookiecutter.project_name }}

RUN mv /opt/{{ cookiecutter.project_name }}/config/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /opt/{{ cookiecutter.project_name }}/entrypoint.sh
ENTRYPOINT ["/opt/{{ cookiecutter.project_name }}/entrypoint.sh"]