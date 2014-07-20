class Section
  attr_accessor :title
  attr_accessor :paragraphs, :extra_paragraphs

  def initialize(title, paragraphs = [], extra_paragraphs = [])
    @title = title
    @paragraphs = paragraphs
    @extra_paragraphs = extra_paragraphs
  end

end