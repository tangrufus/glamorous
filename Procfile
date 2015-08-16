web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -q critical -q high -q default -q mailers -q low -q crawler
