require 'fileutils'
module CrawlStation
  module Command
    class Create < Thor
      desc 'create station', 'station [create|new] hello'
      def create(args)
        dir_root = args.first
        logs "create project #{dir_root}"
        template_create_path = "#{utils.templates_path}/create/dirs"
        FileUtils.copy_entry template_create_path, dir_root
        render_database(dir_root)
        logs "cd #{dir_root}"
        path = "#{Dir.pwd}/#{dir_root}"
        Dir.chdir(path)
        logs 'bundle install'
        IO.popen('bundle install').each { |line| logs line.chomp }
        logs 'done'
      end

      private
      def utils
        CS::Utils
      end

      def logs(msg)
        CS.logger.debug msg
      end

      def render_database(dir_root)
        template_db_path = "#{utils.templates_path}/create/database.erb.yml"
        opts = { project_name: dir_root }
        context = utils.render_context(template_db_path, opts)
        utils.render("#{CS.root}/#{dir_root}/config/database.yml", context)
      end
    end
  end
end
