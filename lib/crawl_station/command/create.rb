require 'fileutils'
module CrawlStation
  module Command
    class Create < Thor
      desc 'create station', 'create crawl station'
      def create(args)
        dir_root = args.first
        puts "create project #{dir_root}"
        curr_path = File.expand_path('../../', __FILE__)
        FileUtils.copy_entry "#{curr_path}/templates/create", dir_root
        puts "cd #{dir_root}"
        path = "#{Dir.pwd}/#{dir_root}"
        Dir.chdir(path)
        puts 'bundle install'
        IO.popen('bundle install').each { |line| puts line.chomp }
        puts 'done'
      end
    end
  end
end
