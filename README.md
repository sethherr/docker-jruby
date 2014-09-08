# Docker - JRuby

A minimal ubuntu based [Docker](http://www.docker.com) container with [JRuby](http://jruby.org) installed.

Version tags are based off the installed [JRuby](http://jruby.org) version

## Usage

**NOTE: Make sure you grab and build the [docker-java](https://github.com/timelinelabs/docker-java) base image or change the base image to one that includes java!**

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