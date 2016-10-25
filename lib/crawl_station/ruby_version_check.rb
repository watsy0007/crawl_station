if ENV['RUBY_VERSION'] < '2.3.0'
  abort <<-end_message
CrawlStation require ruby 2.3.0 or newer.
your are running
#{ENV['RUBY_VERSION']}

please upgrade to Ruby 2.3.0 or newer to continue.
  end_message
end
