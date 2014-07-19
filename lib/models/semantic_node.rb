class SemanticNode
  attr_reader :children

  attr_reader :max_occurrence
  attr_accessor :name

  def initialize(name = '<root>')
    @name = name

    @max_occurrence = 0
    @occurrence = 0

    @children = Hash.new do |hash, key|
      hash[key] = SemanticNode.new key
    end
  end

  def visit
    @occurrence += 1
    @max_occurrence = [@occurrence, @max_occurrence].max
  end

  def reset_occurrence
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
    puts "#{indent}#{name}[#{max_occurrence}]"
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