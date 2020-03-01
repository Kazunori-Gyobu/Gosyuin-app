FROM ruby:2.6.0

ENV LANG C.UTF-8 

RUN apt-get update -qq && apt-get -y install build-essential libpq-dev nodejs mysql-client imagemagick

RUN mkdir /g_app
ENV APP_ROOT /g_app
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install -j4

COPY . $APP_ROOT

RUN mkdir -p tmp/sockets