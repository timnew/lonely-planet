class Page
  module SectionDSL

    def self.extended(mod)
      mod.extend CachedAttrs # inject dependency module
    end

    def self.section_builder_name(*names)
      ['section', names].flatten!.join('_').to_sym
    end

    def self.walk_through_path(destination, *names)
      current = destination

      names.each do |n|
        return nil unless current.has_child? n
        current = current[n.to_sym]
      end

      current
    end

    def declare_sections(&block)
      cached_attr :sections do
        SectionDSLRuntime
        .new(self)
        .execute(&block)
        .result
      end
    end

    def section_builder(*names, &block)
      builder_name = SectionDSL.section_builder_name(*names)
      define_method builder_name do
        current = SectionDSL.walk_through_path(destination, *names)
        return nil if current.nil?
        block.call current
      end
    end
  end

  class SectionDSLRuntime
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
        current = SectionDSL.walk_through_path(destination, *names)

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

    def method_missing(name, *args, &block)
      # delegate all unknown calls back to @host
      # make it allow host owned methods to be called in the section declaration block
      @host.send name, *args, &block
    end
  end
end