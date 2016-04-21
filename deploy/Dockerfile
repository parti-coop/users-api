FROM partixyz/docker-ruby

RUN mkdir -p /parti/users-api
WORKDIR /parti/users-api

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --without development test --deployment --jobs 20 --retry 5

COPY . ./

EXPOSE 3030
CMD ["deploy/docker-cmd.sh"]
