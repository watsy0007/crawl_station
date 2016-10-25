require 'crawl_station/ruby_version_check'
Signal.trap('INT') { puts; exit(1) }
require 'crawl_station'

if ARGV.size > 0
  command = ARGV.shift

  aliases = {
    'new' => 'create',
    'g' => 'generate'
  }
  command = aliases[command] || command
  CrawlStation::Command.invoke(command, ARGV)
  exit(0)
end

puts "usage:\n"
%w(
  create
  generate
).each do |command|
  klass = "#{CrawlStation::Command}::#{command.capitalize}".camelize.constantize
  klass.tasks.each do |k, v|
    puts "#{k}: #{v.usage}\n\t#{v.description}\n"
  end
end
