class Taxonomy
  class TaxonomyNode < Node
    include SharedBehaviors

    attr_accessor :atlas_id

    def initialize(atlas_id)
      super ''
      @atlas_id = atlas_id
    end

    def each_parent(&block)
      return if parent.is_a?(Taxonomy)

      yield parent

      parent.each_parent(&block)
    end

    def get_path
      parts = [name]

      each_parent do |parent|
        parts.unshift parent.name
      end

      parts.join('/')
    end
  end
end