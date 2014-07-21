class Section
  class Builder < ViewModelBuilder
    def block(heading = nil, paras, extra: false)
      return if paras.empty?

      result.blocks << Block.new(paras, extra: extra, heading: heading)
    end

    def extra_block(heading = nil, paras)
      block(heading = nil, paras, extra: true)
    end
  end
end