# arquivo Dockerfile
FROM ruby:3.1.2

# Instale as dependências
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Defina o diretório de trabalho
WORKDIR /app

# Copie o Gemfile e Gemfile.lock para o diretório de trabalho
COPY Gemfile Gemfile.lock ./

# Instale as gems
RUN gem install bundler && bundle install --with development test

# Copie o restante do código para o diretório de trabalho
COPY . .

# Defina as variáveis de ambiente
ENV RAILS_ENV=development
ENV DATABASE_URL=postgresql://postgres:secret@db/defenseless

# Defina a porta exposta
EXPOSE 3000

# Defina o comando para iniciar o servidor
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
