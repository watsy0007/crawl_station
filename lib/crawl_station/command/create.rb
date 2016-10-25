require 'fileutils'
module CrawlStation
  module Command
    class Create < Thor
      desc 'create station', 'create crawl station'
      def create(args)
        dir_root = args.first
        FileUtils.mkdir_p(dir_root)
        dirs = %w(config/initializers lib/tasks module)
        dirs.each { |dir| FileUtils.mkdir_p("#{dir_root}/#{dir}") }
      end
    end
  end
end
