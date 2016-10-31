module CrawlStation
  class Producer
    include Celluloid

    attr_accessor :schedule, :cache, :proxies, :_proxy

    def initialize(schedule, cache, proxy = nil)
      @schedule = schedule
      @cache = cache
      @proxies = proxy
    end

    def start
      loop { break unless loop_parser }
      Logger.debug "#{self} done"
    end

    private

    def loop_parser
      return sleep(0.2) || true if @schedule.empty?
      item = @schedule.pop
      item = CS::ParseStruct.new(item) if item.is_a?(Hash)
      return sleep(0.2) || true if parsed?(item)
      Logger.debug "start parse #{item.link}"
      data = parse_item(item)
      return true if data.nil? || data.empty?
      data = parse_links(data, item.namespace)
      return true if data.empty?
      item.item_class.new.save(item.link, data)
      true
    end

    def parse_item(item)
      retry_times ||= 1
      opts = { proxy: http_proxy }
      puts opts
      data = cache(item) { item.parser_class.new.crawl(item.link, opts) }
      @schedule.done(item)
      data
    rescue Exception => e
      if (retry_times == 0)
        Logger.error("%s: %s\n%s" % [item.link, e.message, e.backtrace[0..10].join("\n")])
        @schedule.failed(item)
      else
        @_proxy = nil
        retry_times -= 1
        retry
      end
      nil
    end

    def parse_links(data, namespace)
      links = ->(data, namespace) do
        next if data['link'].blank? || parsed?(data)
        @schedule.push ParseStruct.new(parser: data['parser'], link: data['link'], namespace: namespace)
      end
      ['pages', 'details'].each do |field|
        data.delete(field)&.map { |page| links.call(page, namespace) }
      end
      data
    end

    def parsed?(data)
      data.nil? || @cache.include?(data['link'])
    end

    def cache(item, data = 'parsing')
      @cache[item['link']] = data
      data = yield if block_given?
      @cache[item['link']] = data
      data
    end

    def http_proxy
      @_proxy ||= @proxies.pop
    end
  end
end
