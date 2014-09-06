FROM ubuntu:14.04
MAINTAINER Albert Dixon <albert@timelinelabs.com>

ENV JRUBY_VERSION       jruby-1.7.15
ENV JRE_VERSION         jre1.7.0_67
ENV JAVA_URL            http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jre-7u67-linux-x64.tar.gz
ENV DEBIAN_FRONTEND     noninteractive
ENV RUBY_CONFIGURE_OPTS --disable-install-doc
ENV TMPDIR              /tmp
ENV PATH                /usr/local/jruby/bin:/usr/local/$JRE_VERSION/bin:$PATH


RUN apt-get update -qq &&\
    apt-get install -q -y --no-install-recommends git curl ca-certificates build-essential libssl-dev &&\
    curl -# -H "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"\
    -L $JAVA_URL | tar -xz -C /usr/local &&\
    git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build &&\
    mkdir -p /opt/rubybuild && PREFIX=/opt/rubybuild /tmp/ruby-build/install.sh &&\
    PATH=/opt/rubybuild/bin:$PATH ruby-build $JRUBY_VERSION /usr/local/jruby &&\
    gem install bundler --no-rdoc --no-ri &&\
    echo 'gem: --no-document' > /etc/gemrc && echo 'gem: --no-document' > /.gemrc &&\
    apt-get autoremove -y && apt-get autoclean -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/rubybuild

ADD test/ /tmp/test
RUN ruby /tmp/test/tc_word_count.rb && rm -rf test
