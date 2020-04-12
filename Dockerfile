FROM ruby:2.6.0

ENV LANG C.UTF-8 

RUN apt-get update -qq &&  \
  apt-get -y install build-essential libpq-dev mysql-client imagemagick && \
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/* && \
  apt-get update && apt-get install -y vim

RUN mkdir /g_app
ENV APP_ROOT /g_app
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install -j4

COPY . $APP_ROOT

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids