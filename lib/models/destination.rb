class Destination < DestinationNode
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

  def self.load(listener, file)
    visitor = Visitor.new listener

    parser = Nokogiri::XML::SAX::Parser.new visitor

    parser.parse File.open(file)
  end
end