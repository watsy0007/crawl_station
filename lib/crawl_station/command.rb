module CrawlStation
  module Command
    extend self
    ALIASES = { 'module' => 'new_module' }

    def invoke(command, args)
      klass = "CrawlStation::Command::#{command.capitalize}".camelize.constantize
      m_name = method_name(command, args)
      obj = klass.new
      return obj.send(m_name, args) if obj.respond_to?(m_name)
      true
    rescue Errno::ENOENT, RuntimeError => e
      Logger.warn "#{e.message}\n#{e.backtrace[0..10].join("\n")}"
    end

    def method_name(command, args)
      return 'create' if command.to_s == 'create'
      name = args.shift
      ALIASES[name] || name
    end
  end
end
