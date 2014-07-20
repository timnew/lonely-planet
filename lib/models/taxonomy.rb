class Taxonomy < Node   
  extend ClassMethods
  include SharedBehaviors

  def initialize
    super 'Taxonomy'
  end

  def flatten
    result = {}

    flatten_children(result)

    result
  end
end