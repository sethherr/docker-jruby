# Docker - JRuby

A minimal ubuntu based [Docker](docker.io) container with [JRuby](jruby.org) installed.

Version tags are based off the installed [JRuby](jruby.org) version

## Usage

Edit the Dockerfile to use the version of JRuby you need. 

Build the container, and tag it with the JRuby version.

```
$ docker build -t='yourname/jruby:_version_'
```

Set up your Dockerfile to use this image

```
# in your Dockerfile
FROM yourname/jruby:_version_
...
```

Then build away!