FROM ruby:3.0

WORKDIR /lib

COPY Gemfile Gemfile ./
RUN bundle install

COPY . .

ENV PORT=4567
EXPOSE 4567

CMD ["ruby", "lib/app.rb", "-o", "0.0.0.0"]