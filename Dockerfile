FROM ruby:2.4-alpine3.6
LABEL maintainer="contato@leonardocouy.com"

RUN apk --update add nodejs netcat-openbsd postgresql-dev
RUN apk --update add --virtual build-dependencies make g++
RUN apk --update add --no-cache tzdata
ENV PATH=/root/.yarn/bin:$PATH
RUN apk add --virtual build-yarn curl && \
    curl -o- -L https://yarnpkg.com/install.sh | sh && \
    apk del build-yarn

RUN mkdir /app

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install
RUN apk del build-dependencies && rm -rf /var/cache/apk/*

ADD . /app

RUN yarn install

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
