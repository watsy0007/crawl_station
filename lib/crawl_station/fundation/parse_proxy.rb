module CrawlStation
  class ParseProxy < Array
    %w(host port username password).each_with_index do |k, i|
      define_method(k) { size >= i ? self[i] : nil }
    end

    def inspect
      "<CrawilStation::ParseProxy #{self.to_s}>"
    end
  end
end
