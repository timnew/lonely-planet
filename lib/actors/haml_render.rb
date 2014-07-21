class HamlRender
  def initialize(haml_path)
    @haml = File.read(haml_path)
    @engine = Haml::Engine.new(@haml)
  end

  def render(page)
    page.extend ExtraAttrs

    html = @engine.render(locals = page)

    file_path = page.file_path
    ensure_folder(File.dirname(file_path))

    File.write(file_path, html)
  end

  def ensure_folder(path)
    return if File.exist? path

    FileUtils.mkdir_p path
  end
end