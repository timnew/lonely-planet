# class HamlRender
#   def initialize(haml_path)
#     @haml = File.read(haml_path)
#     @engine = Haml::Engine.new(@haml)
#     @scope = Object.new
#   end
#
#   def render(page)
#     html = @engine.render(@scope, page)
#
#     file_path = page.file_path
#     ensure_folder(File.dirname(file_path))
#
#     File.write(file_path, html)
#   end
#
#   def ensure_folder(path)
#     return if File.exist? path
#
#     FileUtils.mkdir_p path
#   end
# end
# HamlRender is an actor.
# Actor is the class that glues models, view models together as an application
# Testing actor as a black box leads to expensive functional test. To prepare and maintain fixtures are usually painful.
# On the other hand, since the behavior of models, view models involved are covered by their relatively cheap unit tests.
# So it is not that necessary to recheck them here in an expensive way.
# Also, since actor is very close to user, user can verify the function by run the app easily.
# So I prefer to test actor in a relatively cheap way, test it as a white box, just make sure each model are invoked properly.
describe HamlRender do

  subject do
    HamlRender.new haml_path
  end

  let(:haml_path) { 'template.haml' }
  let(:haml) { double }
  let(:engine) { double }
  let(:html) { '' }

  let(:file_path) { 'output_directory/sample.html' }
  let(:page) do
    page = double

    allow(page).to receive(:file_path).and_return(file_path)

    page
  end

  it 'should render page' do
    expect(File).to receive(:read).with(haml_path).and_return(haml)
    expect(Haml::Engine).to receive(:new).with(haml).and_return(engine)

    expect(engine).to receive(:render).with(page).and_return(html)
    expect(FileUtils).to receive(:mkdir_p).with('output_directory')
    expect(File).to receive(:write).with(file_path, html)

    subject.render page
  end
end