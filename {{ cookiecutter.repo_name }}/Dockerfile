FROM alpine:3.4
MAINTAINER Datawire <dev@datawire.io>
LABEL PROJECT_REPO_URL = "{{ cookiecutter.repo_url }}" \
      PROJECT_REPO_BROWSER_URL = "{{ cookiecutter.repo_browser_url }}" \
      DESCRIPTION = "Datawire {{ cookiecutter.name }}" \
      VENDOR = "Datawire" \
      VENDOR_URL = "https://datawire.io/"

# --------------------------------------------------------------------------------------------------
# Install OS packages
#
# - linux-headers and pcre-dev: required by uwsgi installation via pip
# - nginx will push traffic to uwsgi
# - bash is for convenient debugging
# 

RUN apk --no-cache add \
    bash \
    build-base \
    curl \
    linux-headers \
    make \
    musl \
    nginx \
    pcre-dev \
    python \
    python-dev \
    py-pip \
    py-virtualenv \
  && ln -snf /bin/bash /bin/sh \
  && pip install --upgrade pip

# --------------------------------------------------------------------------------------------------
# Install Datawire Quark
#
ADD https://raw.githubusercontent.com/datawire/quark/master/install.sh /tmp
RUN bash /tmp/install.sh -- master
ENV PATH /root/.quark/bin:$PATH

# --------------------------------------------------------------------------------------------------
# Install the service onto the image
#
COPY . /opt/{{ cookiecutter.project_name }}
RUN  cd /opt/{{ cookiecutter.project_name }} \
    && make venv \
    && bash -c "make quark-install"

# --------------------------------------------------------------------------------------------------
# Configure Nginx
#
RUN mv /opt/bar/config/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
ENTRYPOINT ["/opt/{{ cookiecutter.project_name }}/entrypoint.sh"]
