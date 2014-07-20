class NavigationItem

  attr_accessor :href, :text, :icon

  def initialize(href, text, icon)
    @href = href
    @text = text
    @icon = icon
  end

  def self.from_taxonomy_node(page, taxonomy_node, icon)
    new(page.path_for_node(page.root_path, taxonomy_node), taxonomy_node.name, icon)
  end
end