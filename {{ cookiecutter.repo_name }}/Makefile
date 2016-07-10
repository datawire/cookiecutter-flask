# Makefile: hello

.PHONY: all

all: clean build

build:
	# Produces a language build artifact (e.g.: .jar, .whl, .gem). Alternatively a GZIP tarball
	# can be provided if more appropriate.

 
docker:
	# Produces a Docker image.
	docker build -t datawire/{{ cookiecutter.project_name }} .
 
deb:
	# Produces a Debian package.
	bin/build-deb.sh
 
clean:
	# Clean previous build outputs (e.g. class files) and temporary files.
 
compile:
	# Compile code (may do nothing for interpreted languages).


quark-compile: venv
	# Compiles Quark sources if there are any.
  
quark-install: venv
	# Compiles AND installs Quark language sources if there are any.
	
run-dev: venv
	# Run the service or application in development mode.
	venv/bin/python service/service.py

run-prod:
	# Run the service or application in production mode.
	docker run -d {{ cookiecutter.project_name }}
	
test: venv
	# Run the full test suite.

unit-test: venv
	# Run only the unit tests.
	
venv: venv/bin/activate

venv/bin/activate: requirements.txt
	test -d venv || virtualenv venv
	venv/bin/pip install -Ur requirements.txt
	touch venv/bin/activate

