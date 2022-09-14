require "rspec"
require "./lib/library"
require "./lib/author"

RSpec.describe Library do 
  before(:each) do 
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  describe "#initialize" do 
    it "exists" do 
      expect(@dpl).to be_an_instance_of Library
    end

    it "has a readable name" do 
      expect(@dpl.name).to eq "Denver Public Library"
    end

    it "starts out with no books" do 
      expect(@dpl.books).to eq []
    end

    it "starts out with no authors" do 
      expect(@dpl.authors).to eq []
    end
  end

  describe "#add_author" do 
    it "adds author objects to the author attribute" do 
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)
      expect(@dpl.authors).to eq [@charlotte_bronte, @harper_lee]
    end

    it "adds the books from the authors to the books attribute" do 
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)
      expect(@dpl.books).to eq [@jane_eyre, @professor, @villette, @mockingbird]
    end
  end

  describe "#publication_time_frame_for" do 
    it "takes an argument author and returns a hash showing start and end publication dates" do 
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)
      expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
      expect(@dpl.publication_time_frame_for(@harper_lee)).to eq({:start=>"1960", :end=>"1960"})
    end
  end

  describe "checkout" do 
    it "takes a book argument and returns boolean depending on whether book exists in library" do 
      expect(@dpl.checkout(@mokcingbird)).to eq false
      expect(@dpl.checkout(@jane_eyre)).to eq false
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)
      expect(@dpl.checkout(@jane_eyre)).to eq true 
    end

    it "adds the checked-out book to a list of checked-out books" do 
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)
      @dpl.checkout(@jane_eyre)
      expect(@dpl.checked_out_books).to eq [@jane_eyre]
    end

    it "returns false if the requested book is already checked out" do 
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)
      @dpl.checkout(@jane_eyre)
      expect(@dpl.checkout(@jane_eyre)).to eq false
    end
  end

  describe "return" do 
    it "allows the book to be checked out again and removes it from the checked_out_books list" do 
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    @dpl.checkout(@mockingbird)
    @dpl.checkout(@jane_eyre)
    @dpl.checkout(@villette)
    expect(@dpl.checked_out_books).to eq [@mockingbird, @jane_eyre, @villette]
    expect(@dpl.checkout(@mockingbird)).to eq false
    @dpl.return(@mockingbird)
    expect(@dpl.checked_out_books).to eq [@jane_eyre, @villette]
    expect(@dpl.checkout(@mockingbird)).to eq true 
  end

  describe "#most_popular_book" do 
    it "should return the book that has been checked out most" do 
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)
      @dpl.checkout(@mockingbird)
      @dpl.checkout(@jane_eyre)
      @dpl.checkout(@villette)
      @dpl.return(@mockingbird)
      @dpl.checkout(@mockingbird)
      @dpl.return(@mockingbird)
      @dpl.checkout(@mockingbird)
      expect(@dpl.most_popular_book).to eq @mockingbird
    end
  end
end 