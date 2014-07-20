class Taxonomy < Node   
  extend ClassMethods
  include ChildCreation

  def initialize
    super 'Taxonomy'
  end
end