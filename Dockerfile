FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y build-essential bundler

RUN bundle config --global frozen 1
RUN gem install bundler:1.17.3

RUN export LANG=C.UTF-8
ENV PORT 3000

WORKDIR /app

ADD src/Gemfile /app/Gemfile
ADD src/Gemfile.lock /app/Gemfile.lock
ADD scripts/entrypoint /entrypoint

RUN bundle install

ADD src/ /app

EXPOSE ${PORT}

ENTRYPOINT [ "/entrypoint"]
HEALTHCHECK --interval=5s --timeout=5s --start-period=1s --retries=2 CMD [ "sh", "-c", "curl http://localhost:${PORT}/hello-world" ]