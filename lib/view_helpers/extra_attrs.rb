module ExtraAttrs
  def extra_attrs(extra)
    if extra
      {class: 'extra', style:'display: none;' }
    else
      {}
    end
  end
end