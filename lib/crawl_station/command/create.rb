require 'fileutils'
module CrawlStation
  module Command
    class Create < Thor
      desc 'create station', 'station create hello'
      def create(args)
        dir_root = args.first
        puts "create project #{dir_root}"
        template_create_path = "#{CrawlStation::Utils.templates_path}/create"
        FileUtils.copy_entry template_create_path, dir_root
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
