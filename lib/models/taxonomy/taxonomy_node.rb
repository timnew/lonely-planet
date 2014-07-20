class Taxonomy
  class TaxonomyNode < Node
    include SharedBehaviors

    attr_accessor :atlas_id

    def initialize(atlas_id)
      super ''
      @atlas_id = atlas_id
    end

    def get_path
      if parent.is_a?(Taxonomy)
        name
      else
        "#{parent.get_path}/#{name}"
      end
    end
  end
end