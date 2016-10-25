require 'crawl_station/ruby_version_check'
Signal.trap('INT') { puts; exit(1) }
require 'crawl_station'

puts ARGV
if ARGV.size > 0
  command = ARGV.shift

  aliases = {
    'new' => 'create',
    'g' => 'generate'
  }
  command = aliases[command] || command
  return CrawlStation::Command.invoke(command, ARGV)
end

%w(
  create
  generate
).each do |command|
  klass = "#{CrawlStation::Command}::#{command.capitalize}".camelize.constanize
  puts klass.methods
end
