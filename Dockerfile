FROM jruby:1.7.18-onbuild
ADD test/ /tmp/test
RUN ruby /tmp/test/tc_word_count.rb && rm -rf test