# Drone CI example for Common Lisp
We demonstrate (and eventually troubleshoot) the use of continuous integration
and code coverage for Common Lisp. A simple Common Lisp system is implemented
along with a test. It is then built and tested by a CI and the coverage report
is sent to Coveralls.

## Software components
### Pre-requisites
You must:
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

## Adding badges
[![Build Status](https://drone.git-or-miss.com/api/badges/thomashoullier/cl-drone-example/status.svg?ref=refs/heads/master)](https://drone.git-or-miss.com/thomashoullier/cl-drone-example)

[![Coverage Status](https://coveralls.io/repos/github/thomashoullier/cl-drone-example/badge.svg?branch=master)](https://coveralls.io/github/thomashoullier/cl-drone-example?branch=master)

## Creating your own Docker images
`TODO`

## Caveats
* `cl-coveralls` is made to work by tricking it into thinking we are
  running on CircleCI. I don't know whether this will break anything,
  but it is an ugly hack anyway.

## See also
* [jsonrpc](https://github.com/cxxxr/jsonrpc/blob/master/.travis.yml): CL
  Travis example.
* [cl-kraken](https://github.com/jonatack/cl-kraken/blob/master/.travis.yml):
  much more complete Travis example with Coveralls integration.

## References
1. [Drone documentation](https://docs.drone.io/)
2. [Coveralls](https://coveralls.io)
3. [Drone documentation: per repository secret](https://docs.drone.io/secret/repository/)
