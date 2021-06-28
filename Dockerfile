FROM ruby:2.6.6-stretch as base

RUN apt-get update && apt-get install libjemalloc1 && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1

ENV APP=/usr/src/app/ \
  BUILD_PACKAGES="build-essential cmake pkg-config git-core"

WORKDIR ${APP}

RUN apt-get update && \
    apt-get -y upgrade

RUN apt-get -y install ${BUILD_PACKAGES}

COPY Gemfile* $APP/

ARG BUNDLE_GEMS__CONTRIBSYS__COM
RUN gem install bundler -v 2.0.2 && \
  bundle install && \
  rm -rf /usr/local/bundle/cache/*.gem && \
  find /usr/local/bundle/gems/ -name "*.c" -delete && \
  find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . $APP/
ENTRYPOINT ["irb", "app/main.rb"]