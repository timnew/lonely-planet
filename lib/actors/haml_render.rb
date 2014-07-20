class HamlRender
  def initialize(haml_path, output_path)
    @haml = File.read(haml_path)
    @engine = Haml::Engine.new(@haml)
    @output_path = output_path
  end

  def render(taxonomy_node, destination_node)
    html = @engine.render(locals = { taxonomy: taxonomy_node, destination: destination_node })

    file_path = File.join(@output_path,"#{taxonomy_node.get_path}.html")
    ensure_folder(File.dirname(file_path))

    File.write(file_path, html)
  end

  def ensure_folder(path)
    return if File.exist? path

    FileUtils.mkdir_p path
  end
end