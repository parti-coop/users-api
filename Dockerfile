FROM ruby:2.3
RUN gem update --system 2.4.8

RUN mkdir -p /parti/auth-api 
WORKDIR /parti/auth-api

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries --disable-clean
RUN bundle install --without development test --deployment --jobs 20 --retry 5

COPY . ./

EXPOSE 3030

CMD (test -f /volume/shared/is_leader && bin/rake db:migrate); bin/rails server -p 3030 -b 0.0.0.0
