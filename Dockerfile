FROM ruby:3.0

RUN ln -s -f /proc/1/fd/1  /dev/stdout

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \

    curl -sL https://deb.nodesource.com/setup_14.x | bash -;

RUN apt-get update -qq && apt-get install -y \
  vim \
  yarn \
  nodejs \
  postgresql-client \
  chromium;

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler -v 2.2.15

RUN bundle install

COPY . /app
RUN chmod -R 755 $RAILS_ROOT/bin

COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
