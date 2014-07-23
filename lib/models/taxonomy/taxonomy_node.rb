class Taxonomy
  class TaxonomyNode < Node
    include SharedBehaviors

    attr_accessor :atlas_id

    def initialize(parent, atlas_id)
      super ''
      self.parent = parent
      parent.children[atlas_id] = self unless parent.nil?
      @atlas_id = atlas_id
    end

    def each_parent(&block)
      return if parent.nil?

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