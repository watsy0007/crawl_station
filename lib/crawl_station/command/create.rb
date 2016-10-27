require 'fileutils'
module CrawlStation
  module Command
    class Create < Thor
      desc 'create station', 'station [create|new] hello'
      def create(args)
        dir_root = args.first
        puts "create project #{dir_root}"
        template_create_path = "#{CrawlStation::Utils.templates_path}/create/dirs"
        FileUtils.copy_entry template_create_path, dir_root
        render_database(dir_root)
        puts "cd #{dir_root}"
        path = "#{Dir.pwd}/#{dir_root}"
        Dir.chdir(path)
        puts 'bundle install'
        IO.popen('bundle install').each { |line| puts line.chomp }
        puts 'done'
      end

      private
      def render_database(dir_root)
        template_db_path = "#{CS::Utils.templates_path}/create/database.erb.yml"

        template = IO.read(path)
        opts = { project_name: dir_root }
        ERB.new(template).result(OpenStruct.new(opts).instance_eval { binding })
      end
    end
  end
end
