class Block
  attr_accessor :paragraphs, :heading

  attr_writer :extra
  def extra?
    @extra
  end

  def has_heading?
    !heading.nil?
  end

  def has_content?
    !paragraphs.empty?
  end

  def initialize(paras = [], extra: false, heading: nil)
    @extra = extra
    @heading = heading
    @paragraphs = paras
  end
end