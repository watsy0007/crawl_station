require 'fileutils'
module CrawlStation
  module Command
    class Create < Thor
      desc 'create station', 'create crawl station'
      def create(args)
        dir_root = args.first
        curr_path = File.expand_path('../../', __FILE__)
        FileUtils.copy_entry "#{curr_path}/templates/create", dir_root
      end
    end
  end
end
