class Taxonomy
  class TaxonomyNode < Node
    include SharedBehaviors

    attr_accessor :atlas_id

    def initialize(atlas_id)
      super ''
      @atlas_id = atlas_id
    end
  end
end