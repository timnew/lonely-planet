class SemanticNode
  attr_reader :children

  attr_reader :max_occurrence, :visited

  def min_occurrence
    @min_occurrence.nil? ? 0 : @min_occurrence
  end

  attr_accessor :name

  def initialize(name = '<root>')
    @name = name

    @visited = 0
    @min_occurrence = nil
    @max_occurrence = 0
    @occurrence = 0

    @children = Hash.new do |hash, key|
      hash[key] = SemanticNode.new key
    end
  end

  def visit
    @visited += 1
    @occurrence += 1
    @max_occurrence = @occurrence if @max_occurrence < @occurrence
  end

  def reset_occurrence
    @min_occurrence = @occurrence if @min_occurrence.nil? or @min_occurrence > @occurrence

    @occurrence = 0
  end

  def leave
    children.values.each do |child|
      child.reset_occurrence
    end
  end

  def [](key)
    children[key]
  end

  def print_tree(indent_level = 0)
    indent = '  ' * indent_level
    puts "#{indent}#{name}[#{min_occurrence}:#{max_occurrence}] (#{visited})"
    children.values.each do |child|
      child.print_tree(indent_level + 1)
    end
  end

  def self.analyze(file)
    visitor = Visitor.new

    parser = Nokogiri::XML::SAX::Parser.new(visitor)

    parser.parse_file(file)

    visitor.root_node
  end
end