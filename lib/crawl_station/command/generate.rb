require 'erb'
require 'fileutils'
module CrawlStation
  module Command
    class Generate < Thor
      desc 'generation migration', ''
      def migration(args)
        raise "generate #{args} error" unless args.is_a?(Array) || args.size < 2
        module_name, file_name = args.shift, args.shift

        file_path = dest_path(module_name, file_name)
        template_path = CS::Utils.template_filepath('generate/migration.erb')
        render(file_path, template_path, class_name: file_name.camelize)
        logs "generate migration #{module_name}:#{file_name} done"
      rescue Errno::ENOENT => e
        logs "#{e.message}\n#{e.bnacktrace[0..10].join("\n")}"
      end

      desc 'create parser module', ''
      def new_module(args)
        raise "create module #{args} error" unless args.is_a?(Array) || args.empty?
        module_name = args.shift
        m_path = CS::Utils.module_path(module_name)
        return logs("#{module_name} module exist!") if File.exist?(m_path)
        logs "create new module #{module_name}"
        template_m_path = "#{CS::Utils.templates_path}/generate/module"
        FileUtils.copy_entry template_m_path, m_path
        logs "create #{module_name} done"
      end

      desc 'create parser', ''
      def parser(args)
        raise "generate parser #{args} error" unless args.is_a?(Array) || args.size < 2
        module_name, parser = args.shift, args.shift
        logs "create #{module_name} parser #{parser}"
        template_path = CS::Utils.template_filepath('generate/parser.erb')
        opts = {
          module_class_name: module_name.camelize,
          class_name: parser.camelize
        }
        render(parser_path(module_name, file_name), template_path, opts)
      end

      private

      def render(file_path, template_path, opts = {})
        File.open(file_path, 'w') do |f|
          logs "create file #{file_path}"
          f.write render_context(template_path, opts)
        end
      end

      def render_context(path, opts = {})
        template = IO.read(path)
        ERB.new(template).result(OpenStruct.new(opts).instance_eval { binding })
      end

      def logs(msg)
        CrawlStation.logger.debug msg
      end

      def dest_path(module_name, file_name)
        m_path = CrawlStation::Utils.module_path(module_name)
        raise "module: #{module_name} not exist" unless Dir.exist?(m_path)
        migrate_path = "#{m_path}/db/migrate"
        raise "module: migration path #{migrate_path} not exist" unless Dir.exist?(migrate_path)
        ms = Time.now.to_f.to_s.delete '.'
        "#{migrate_path}/#{ms}_#{file_name}.rb"
      end

      def parser_path(module_name, file_name)
        m_path = CrawlStation::Utils.module_path(module_name)
        raise "module: #{module_name} not exist" unless Dir.exist?(m_path)
        "#{m_path}/parser/#{file_name}.rb"
      end
    end
  end
end
