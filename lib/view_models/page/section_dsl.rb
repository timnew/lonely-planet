class Page
  module SectionDSL

    def self.extended(mod)
      mod.extend CachedAttrs # inject dependency module
    end

    def self.section_builder_name(*names)
      ['section', names].flatten!.join('_').to_sym
    end

    def declare_sections(&block)
      cached_attr :sections do
        SectionListBuilder
        .new(self)
        .execute(&block)
        .result
      end
    end

    def section(*names, &block)
      builder_name = SectionDSL.section_builder_name(*names)
      define_method builder_name do
        current = destination[*names]
        return nil if current.nil?
        block.call current
      end
    end
  end

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
      builder_method = SectionDSL.section_builder_name(*names)
      if block_given?
        current = destination[*names]

        if current.nil?
          section_result = nil
        else
          section_result = yield current
        end

      else
        section_result = @host.send builder_method
      end

      result << section_result unless section_result.nil?
      # rescue ex
      #   puts "ERROR: #{ex}" # Guard to avoid crash
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