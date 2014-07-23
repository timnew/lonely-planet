# describe Page::SectionDSL do
#
#   extend Page::SectionDSL
#
#   let(:introductory) do
#     result = double
#
#     allow(result).to receive(:has_child?).with(:introduction) { true }
#     allow(result).to receive(:[]).with(:introduction) { introduction }
#
#     result
#   end
#
#   let(:introduction) {
#     double
#   }
#
#   let(:wildlife) do
#     result = double
#
#     allow(result).to receive(:has_child?).with(:animals) { true }
#     allow(result).to receive(:has_child?).with(:aliens) { false }
#     allow(result).to receive(:[]).with(:animals) { animals }
#
#     result
#   end
#
#   let(:animals) do
#     double
#   end
#
#   let(:destination) do
#     result = double
#
#     allow(result).to receive(:has_child?).with(:introductory) { true }
#     allow(result).to receive(:has_child?).with(:wildlife) { true }
#     allow(result).to receive(:[]).with(:introductory) { introductory }
#     allow(result).to receive(:[]).with(:introductory, :introduction) { introduction }
#     allow(result).to receive(:[]).with(:wildlife) { wildlife }
#     allow(result).to receive(:[]).with(:wildlife, :animals) { animals }
#     allow(result).to receive(:[]).with(:wildlife, :aliens) { nil }
#
#     result
#   end
#
#   let(:normal_method) do
#     double
#   end
#
#   declare_sections do
#
#     section :introductory, :introduction do |introduction|
#       introduction
#     end
#
#     section :wildlife, :animals
#
#     section :wildlife, :aliens do |aliens|
#       aliens
#     end
#
#     section :wildlife do |wildlife|
#       normal_method
#     end
#   end
#
#   section :wildlife, :animals do |animals|
#     animals
#   end
#
#   it 'should work as expected', :smoke do
#     sections.should contain_exactly introduction, animals, normal_method
#   end
# end