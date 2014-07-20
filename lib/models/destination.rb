class Destination < DestinationNode
  extend ClassMethods

  attr_accessor :atlas_id, :title, :title_ascii

  def initialize(attrs)
    super 'Destination'

    @atlas_id = attrs[:atlas_id]
    @title = attrs[:title]
    @title_ascii = attrs[:'title-ascii']
  end

  def create_child(name)
    add_child DestinationNode.new(name)
  end
end