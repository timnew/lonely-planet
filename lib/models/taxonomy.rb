class Taxonomy < Node   
  extend ClassMethods

  def create_child
    add_child TaxonomyNode.new
  end
end