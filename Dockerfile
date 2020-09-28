FROM ruby:2.7.1
RUN mkdir /simple-rack-app
WORKDIR /simple-rack-app
COPY . /simple-rack-app
RUN gem install bundler && bundler install
