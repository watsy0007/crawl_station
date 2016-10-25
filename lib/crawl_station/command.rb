module CrawlStation
  module Command
    class CommandError < Exception
    end
    extend self
    ALIASES = { 'module' => 'new_module' }

    def invoke(command, args)
      klass = "CrawlStation::Command::#{command.capitalize}".camelize.constantize
      m_name = method_name(command, args)
      obj = klass.new
      return obj.send(m_name, args) if obj.respond_to?(m_name)
      true
    rescue NameError => e
      Logger.warn "#{command}: #{args} not exist"
    end

    def method_name(command, args)
      return 'create' if command.to_s == 'create'
      name = args.shift
      ALIASES[name] || name
    end
  end
end
