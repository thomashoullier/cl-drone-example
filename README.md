# Drone CI example for Common Lisp
![work in progress](https://raw.githubusercontent.com/thomashoullier/badges/6581abd9e6843d6ad0c8a6d0be04194b861980ec/status-work-in-progress.svg)

We demonstrate (and eventually troubleshoot) the use of continuous integration
and code coverage for Common Lisp. A simple Common Lisp system is implemented
along with a test. It is then built and tested by a CI and the coverage report
is sent to Coveralls.

## Software components
### Pre-requisites
* Setup a Drone instance (for example on a VPS). It is a piece of cake,
  simply follow the documentation [1]. We are using a docker runner.
* Connect your github account to Coveralls [2] and enable tracking for
  your repository.

### Used in the CI setup
There are many moving pieces which must work together. You can simply
run `cl-drone-example` without worrying about every piece, but this is
what we are using:

* [rove](https://github.com/fukamachi/rove): Test library for Common Lisp.
  Generates the test coverage report, which is a feature only working for
  SBCL.
* [cl-coveralls](https://github.com/fukamachi/cl-coveralls): Posting
  test coverage reports to Coveralls.
* [fukamachi/dockerfiles](https://github.com/fukamachi/dockerfiles):
  Docker images for the CI runner providing (mainly) SBCL and Roswell.

## Managing coveralls token
Coveralls provides a token for posting reports with respect to a given
repository. You can copy it into a Drone `secret` [3] and load it from the
CI yaml file as an environment variable.

```yaml
environment:
    COVERALLS_REPO_TOKEN:
      from_secret: coveralls_token
```

## Adding badges
Both Drone and Coveralls provide links to badges.

[![Build Status](https://drone.git-or-miss.com/api/badges/thomashoullier/cl-drone-example/status.svg?ref=refs/heads/master)](https://drone.git-or-miss.com/thomashoullier/cl-drone-example)

[![Coverage Status](https://coveralls.io/repos/github/thomashoullier/cl-drone-example/badge.svg?branch=master)](https://coveralls.io/github/thomashoullier/cl-drone-example?branch=master)

## Creating your own Docker images
It is a good idea to use a docker image to install dependencies once and for
all, otherwise the build process will be too long (3min instead of 15sec).

We use a `Dockerfile` with the bare minimum in order to test common lisp
systems. It is built on top of the Docker image `fukamachi/sbcl:latest-alpine`.
You can layer the system-specific dependencies using another `RUN` entry in
the Dockerfile.

This docker image is first built/updated by Drone, and then used to run
the tests.

For this to work, you need to be an admin of your Drone instance and mark your
repository as trusted.

Another useful feature of Drone is
[drone-cache](https://github.com/meltwater/drone-cache/blob/master/README.md),
which allows caching files from one build to the next.

## Caveats
* `cl-coveralls` is made to work by tricking it into thinking we are
  running on CircleCI. This hack is bound to break someday.

## See also
* [jsonrpc](https://github.com/cxxxr/jsonrpc/blob/master/.travis.yml): CL
  Travis example.
* [cl-kraken](https://github.com/jonatack/cl-kraken/blob/master/.travis.yml):
  much more complete Travis example with Coveralls integration.

## References
1. [Drone documentation](https://docs.drone.io/)
2. [Coveralls](https://coveralls.io)
3. [Drone documentation: per repository secret](https://docs.drone.io/secret/repository/)
4. [Drone: Build Docker image and re-use in the next step](https://discourse.drone.io/t/build-docker-image-and-re-use-in-the-next-step/6190)
