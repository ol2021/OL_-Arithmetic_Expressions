require './app/tree_node'

describe TreeNode do
    context "When a tree node is created with certain instantiation" do
        it "returns true" do
            root = described_class.new(3)
            expect(root.value).to eql(3)
            expect(root).to have_attributes(:left => be_nil)
            expect(root).to have_attributes(:right => be_nil)
        end
    end
end
