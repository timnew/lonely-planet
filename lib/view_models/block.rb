class Block
  attr_accessor :paragraphs, :heading, :limit

  def initialize(paras = [], limit: nil, heading: nil)
    @limit = limit.nil? ? paras.length : limit
    @heading = heading
    @paragraphs = paras
  end

  def has_heading?
    !heading.nil?
  end

  def has_content?
    !paragraphs.empty?
  end

  def has_extra?
    paragraphs.length > limit
  end

  def paragraph_attr(index)
    if index >= limit
      {class: 'extra', style: 'display: none;'}
    else
      {}
    end
  end

end