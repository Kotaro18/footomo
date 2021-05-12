# FROM ruby:2.4.6
# RUN apt-get update -qq && apt-get install -y build-essential nodejs
# RUN mkdir /app
# WORKDIR /app
# COPY Gemfile /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock
# RUN bundle install
# COPY . /app

FROM ruby:2.7.2
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt install -y node.js

COPY ./ /var/www/footomo

WORKDIR /var/www/footomo

COPY Gemfile /var/www/footomo
COPY Gemfile.lock /var/www/footomo

RUN apt-get update
RUN apt-get upgrade -y
RUN gem update bundler 
RUN apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev -y
RUN bundle install 
# RUN rails secret

# ENV RAILS_ENV="production" pumactl start
ENV RAILS_ENV production 

EXPOSE 3000

# RUN docker ps
# RUN netstat -na | grep -i 3000
# RUN curl -G 'http://localhost:3000'
