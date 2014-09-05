FROM ubuntu:14.04
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV JRUBY_VERSION       jruby-1.7.15
ENV DEBIAN_FRONTEND     noninteractive
ENV RUBY_CONFIGURE_OPTS --disable-install-doc
ENV TMPDIR              /tmp
ENV PATH                /usr/local/jruby:$PATH

WORKDIR /tmp
RUN apt-get update -qq &&\
    apt-get install -q -y --no-install-recommends git curl make build-essential libssl-dev &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    mkdir -p /opt/rubybuild && PREFIX=/opt/rubybuild ./ruby-build/install.sh &&\
    PATH=/opt/rubybuild:$PATH ruby-build $JRUBY_VERSION /usr/local/jruby &&\
    gem install bundler --no-rdoc --no-ri &&\
    echo 'gem: --no-document' > /etc/gemrc && echo 'gem: --no-document' > /.gemrc &&\
    apt-get autoremove -y && apt-get autoclean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/rubybuild

ADD test/ /tmp/test
RUN ruby /tmp/test/tc_word_count.rb && rm -rf test
