desc 'launch station system'
task :launch do
  CrawlStation::Launcher.new.start
end

task default: %w(launch)
