module CrawlStation
  class ParseProxy < Array
    { host: 0, port: 1, username: 2, password: 3 }.each do |k, v|
      define_method(k) { size >= v ? self[v] : nil }
    end

    def inspect
      "<CrawilStation::ParseProxy #{self.to_s}>"
    end
  end
end
