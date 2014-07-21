class Section
  attr_accessor :title
  attr_accessor :paragraphs, :extra_paragraphs

  def initialize
    @title = ''
    @paragraphs = []
    @extra_paragraphs = []
  end
end