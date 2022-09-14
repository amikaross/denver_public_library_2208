require "rspec"
require "./lib/author"
require "./lib/book"

RSpec.describe Book do 
  before(:each) do 
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
  end

  describe "#initialize" do 
    it "exists" do 
      expect(@charlotte_bronte).to be_an_instance_of Author
    end

    it "has a readable name" do 
      expect(@charlotte_bronte.name).to eq "Charlotte Bronte"
    end

    it "starts with no books" do 
      expect(@charlotte_bronte.books).to eq []
    end
  end

  describe "#write" do 
    it "creates a Book object" do 
      jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
      expect(jane_eyre.class).to eq Book
      expect(jane_eyre.title).to eq "Jane Eyre"
    end

    it "adds the book object to the books attribute" do 
      jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
      villette = @charlotte_bronte.write("Villette", "1853")
      expect(@charlotte_bronte.books).to eq [jane_eyre, villette]
    end
  end
end