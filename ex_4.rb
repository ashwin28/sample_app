=begin
Create three hashes called person1, person2, and person3, with first and last names
under the keys :first and :last. Then create a params hash so that 
params[:father] is person1, params[:mother] is person2, and params[:child] is person3.
Verify that, for example, params[:father][:first] has the right value.
=end

class Temp

	attr_accessor :person1, :person2, :person3, :paarams

	def initialize
		@person1 = { first: "Taraknath", last: "Dey" }
		@person2 = { first: "Deena", last: "Dey" }
		@person3 = { :first => "Abhijeet", :last => "Dey" }

		@params = { father: person1, mother: person2, :brother => person3 }
	end

	def mom
		@params[:mother][:first]
	end

	def dad
		@params[:father][:first]
	end

	def bro
		@params[:brother][:first]
	end
end

class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def ==(other)
    self.class === other and
      other.author == @author and
      other.title == @title
  end

  alias eql? ==

  def hash
    @author.hash ^ @title.hash # XOR
  end
end

class One
	def to_s
		"#{self.class.name} to_s was called"
	end
end

class Two
	def inspect
		"#{self.class.name} inspect was called"
	end
end

class Three
	def to_s
		"#{self.class.name} to_s was called"
	end
	def inspect
		"#{self.class.name} inspect was called"
	end
end

class Four
end













