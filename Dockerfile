FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir /myStarWarsBy
WORKDIR /myStarWarsBy
COPY Gemfile /myStarWarsBy/Gemfile
COPY Gemfile.lock /myStarWarsBy/Gemfile.lock
RUN bundle install
COPY . /myStarWarsBy

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]