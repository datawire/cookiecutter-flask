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
COPY config/ ./config
COPY requirements.txt requirements-quark.txt entrypoint.sh ./

RUN apk --no-cache add \
    bash \
    build-base \
    ca-certificates \
    curl \
    linux-headers \
    ncurses \
    nginx \
    python \
    py-pip \
    py-virtualenv \
    uwsgi \
    uwsgi-python \
    wget \
  && ln -snf /bin/bash /bin/sh \
  && pip install -Ur requirements.txt pip \
  && rm requirements.txt

# Install Datawire MDK (used by Datawire Gateway)
ADD https://raw.githubusercontent.com/datawire/quark/master/install.sh .
ENV PATH $HOME/.quark/bin:$PATH
RUN bash install.sh

RUN ${HOME}/.quark/bin/quark install \
    --python $(sed -e '/^[[:space:]]*$$/d' -e '/^[[:space:]]*\#/d' requirements-quark.txt | tr '\n' ' ' ) \
    && rm requirements-quark.txt \
    && mv /opt/{{ cookiecutter.project_name }}/config/nginx.conf /etc/nginx/nginx.conf

EXPOSE 5000
ENTRYPOINT ["./entrypoint.sh"]