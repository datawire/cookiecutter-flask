FROM alpine:3.4
MAINTAINER Datawire <dev@datawire.io>
LABEL PROJECT_REPO_URL = "{{ cookiecutter.repo_url }}" \
      PROJECT_REPO_BROWSER_URL = "{{ cookiecutter.repo_browser_url }}" \
      DESCRIPTION = "Datawire {{ cookiecutter.name }}" \
      VENDOR = "Datawire" \
      VENDOR_URL = "https://datawire.io/"

WORKDIR /opt/datawire/{{ cookiecutter.project_name }}/service
COPY service/ ./

WORKDIR /opt/datawire/{{ cookiecutter.project_name }}
COPY requirements.txt requirements-quark.txt entrypoint.sh ./

RUN apk --no-cache add \
    bash \
    ca-certificates \
    curl \
    ncurses \
    nginx \
    python \
    py-pip \
    py-virtualenv \
    uwsgi \
    wget \
  && ln -snf /bin/bash /bin/sh \
  && pip install -U  pip \
  && pip install -Ur requirements.txt \
  && rm requirements.txt

# Install Datawire MDK (used by Datawire Gateway)
ADD https://raw.githubusercontent.com/datawire/quark/master/install.sh .
ENV PATH $HOME/.quark/bin:$PATH
RUN bash install.sh

RUN ${HOME}/.quark/bin/quark install \
    --python $(sed -e '/^[[:space:]]*$$/d' -e '/^[[:space:]]*\#/d' requirements-quark.txt | tr '\n' ' ' )

RUN mv /opt/{{ cookiecutter.project_name }}/config/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]



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

WORKDIR /opt/{{ cookiecutter.project_name }}/
COPY

COPY . /opt/{{ cookiecutter.project_name }}
RUN  cd /opt/hellokube \
     && pip install -Ur requirements.txt \
     && make quark-install

# --------------------------------------------------------------------------------------------------
# Configure Nginx
#
RUN mv /opt/{{ cookiecutter.project_name }}/config/nginx.conf /etc/nginx/nginx.conf

EXPOSE 5000
ENTRYPOINT ["/opt/{{ cookiecutter.project_name }}/entrypoint.sh"]
