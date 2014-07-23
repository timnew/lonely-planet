class Section
  attr_accessor :title
  attr_accessor :blocks

  def initialize(title, &block)
    @title = title

    @blocks = []

    instance_eval(&block)
  end

  def block(heading = nil, paras, limit: nil)
    return if paras.empty?

    blocks << Block.new(paras, heading: heading, limit: limit)
  end

  def extra_block(heading = nil, paras)
    block(heading, paras, limit: 0)
  end
end