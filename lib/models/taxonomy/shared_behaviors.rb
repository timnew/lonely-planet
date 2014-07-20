class Taxonomy
  module SharedBehaviors
    def create_child(atlas_id)
      add_child TaxonomyNode.new atlas_id
    end

    def add_child(child)
      super(child, child.atlas_id)
    end

    def flatten_children(container)
      children.each_value do |child|
        container[child.atlas_id] = child
        child.flatten_children(container)
      end
    end
  end
end