class Taxonomy
  module ChildCreation
    def create_child(atlas_id)
      add_child TaxonomyNode.new atlas_id
    end

    def add_child(child)
      super(child, child.atlas_id)
    end
  end
end