class Node
  attr_accessor :parent, :children
  attr_accessor :name

  def initialize(name, children = {})
    @name = name
    @children = children
  end

  def create_child(name)
    add_child self.class.new(name)
  end

  def add_child(child, name = nil)
    name = child.name if name.nil?
    children[name.to_sym] = child
    child.parent = self

    child
  end

  def has_child?(*names)
    raise ArgumentError, 'wrong number of arguments (at least one)' if names.empty?

    return false unless children.has_key? names.first.to_sym
    return true if names.one?
    children[names.first.to_sym].has_child?(*names[1..-1])
  end

  def [](*names)
    raise ArgumentError, 'wrong number of arguments (at least one)' if names.empty?

    child = children[names.first.to_sym]

    return nil if child.nil?

    return child if names.one?

    child[*names[1..-1]]
  end

  delegate :[]=, :length, to: :children
end