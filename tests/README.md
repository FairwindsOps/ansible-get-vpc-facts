# Role Tests

This role includes integration tests that run in Docker containers.

## Requirements

### Docker

You will need a working Docker client installed and configured to execute tests. See [Docker Basics](DockerBasics.md) for details on getting setup.

Once you have a working Docker setup you will need to build an Ansible capable image from the included Dockerfile:

```
> cd tests
> make build
```

### Serverspec

Integration tests are [Serverspec](http://serverspec.org/) based which has Ruby gem requirements.

```
> cd tests
> bundle install --without=ci
```

## Executing tests

Use the included `Makefile` to execute tests.

```
> cd tests
> make
build                          Build Docker image from repo Dockerfile
clean                          Remove Docker image and container id file
help                           Halp!
run                            Run fresh Docker container
shell                          Drop into container shell
test-execute                   Execute Ansible playbook on running container
test-idempotent                Execute Ansible playbook with check for changes
test-serverspec                Excute serverspec specs on running container
test-syntax                    Ansible syntax check on running container
test                           Execute all tests
```

Tests mount the working directory on your laptop into the container. Changes you make on your laptop will be reflected on the target container without restarting it.

## CI

The repo contains a [CircleCI configuration](../circle.yml) for automated testing.
