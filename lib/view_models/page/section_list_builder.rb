class Page
  class SectionListBuilder
    def initialize(host)
      @host = host
      @result = []
    end

    def execute(&block)
      instance_eval &block
      self
    end

    def destination
      @host.send :destination
    end

    def result
      @result
    end

    def section(*names)
      current = destination[*names]

      if current.nil?
        section_result = nil
      else
        section_result = yield current
      end

      result << section_result unless section_result.nil?
    rescue ex
      puts "ERROR: #{ex}" # Guard to avoid crash
    end

    def respond_to?(symbol, include_private = false)
      return true if super
      @host.respond_to?(symbol)
    end

    def method_missing(name, *args, &block)
      if @host.respond_to?(name)
        @host.send name, *args, &block
      else
        super
      end
    end
  end
end