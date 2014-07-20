module CachedAttrs
  def cached_attr(attr_name, &block)
    cache_variable_name = :"@#{attr_name.to_s.gsub(/[\?!]/,'_')}"

    define_method attr_name do
      return instance_variable_get cache_variable_name if instance_variable_defined? cache_variable_name

      cached_value = instance_eval &block
      instance_variable_set cache_variable_name, cached_value
      cached_value
    end
  end
end