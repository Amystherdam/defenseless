# arquivo Dockerfile
FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y sudo && apt-get install -y nodejs postgresql-client


RUN useradd -m postgres

RUN echo "postgres:<secret>" | chpasswd

RUN usermod -aG sudo postgres

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle config set --local with 'development test'
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
