class Section
  class Builder < ViewModelBuilder
    def block(heading = nil, paras, limit: nil)
      return if paras.empty?

      result.blocks << Block.new(paras, heading: heading, limit: limit)
    end

    def extra_block(heading = nil, paras)
      block(heading, paras, limit: 0)
    end
  end
end