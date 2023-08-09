ARG RUBY_VERSION=3.2.1
FROM ruby:$RUBY_VERSION

# Install libvips for Active Storage preview support
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development"
RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

RUN yarn install --check-files
# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN bundle exec rails assets:precompile
# RUN RAILS_ENV=production bundle exec rails javascript:install:esbuild
# RUN RAILS_ENV=production bundle exec rails css:install:bootstrap

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile
# RUN ./bin/rails cache:clear

RUN RAILS_ENV=production bundle exec rake assets:precompile
RUN RAILS_ENV=production bundle exec rake assets:clean



# Entrypoint prepares the database.
ENTRYPOINT ["./bin/docker-entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails","server"]
                                                                     