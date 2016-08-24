# Datawire Flask Microservice Cookiecutter

Provides the basic project structure for developing a microservice that uses Python's Flask framework.

# Usage

1. Ensure you have the `cookiecutter` program installed: `pip install cookiecutter`. Documentation for Cookiecutter can be found on the [Cookiecutter](https://pages.github.com/) repository.
2. Run `cookiecutter gh:datawire/cookiecutter-flask` and answer the prompts. Beyond changing `name` most default values should be sane if you're pushing an image to `us.gcr.io` (Google Container Registry).

## Modifying for Docker Hub Pushes

Sometimes it's desired to use Docker Hub rather than Google Container Registry, for example, because you're publishing a Docker image that is supposed to be public. In order to do this you need to select `docker.io` when prompted for the `docker_registry_host` and then set the `docker_organization` to one of two things.
    
- Use `datawire` if the image should go under the official `datawire` organization.
- Use your Docker Hub username / ID if publishing an image for your use only (e.g. demo purposes). 

## Authenticating for Google Container Registry

It is likely that publishing to Google Container Registry will require you to authenticate. Use the following command:

`gcloud docker -a`