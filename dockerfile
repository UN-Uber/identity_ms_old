FROM ruby:slim-buster

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3005
CMD ["ruby" ,"./app.rb"]