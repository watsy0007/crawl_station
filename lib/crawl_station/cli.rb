require 'crawl_station/ruby_version_check'
Signal.trap('INT') { puts; exit(1) }
require 'crawl_station'

if ARGV.first == 'create'
  CrawlStation::Command.invoke(ARGV.shift, ARGV)
end
