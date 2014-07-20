class Taxonomy < Node   
  extend ClassMethods
  include ChildCreation

  def initialize
    super 'Taxonomy'
  end

  def flatten

  end
end