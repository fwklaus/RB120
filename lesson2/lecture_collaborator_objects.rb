=begin
# Objects of type String are technically, collaborator objects
class Person
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

joe = Person.new("Joe")
joe.name                    # => "Joe"


# A instance variable can be set to any object

class Person
  def initialize
    @heroes = ['Superman', 'Spiderman', 'Batman']
    @cash = {'ones' => 12, 'fives' => 2, 'tens' => 0, 'twenties' => 2, 'hundreds' => 0}
  end
  
  def cash_on_hand
    # this method will use @cash to calculate total cash value
    # we'll skip the implementation
  end
  
  def heroes
    @heroes.join(', ')
  end
end

joe = Person.new
joe.cash_on_hand            # => "$62.00"
joe.heroes                  # => "Superman, Spiderman, Batman"


# instance variables can likewise point to custom objects

class Person
  attr_accessor :name, :pet
  
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
bud = Bulldog.new             # assume Bulldog class from previous assignment

bob.pet = bud

bob.pet                       # => #<Bulldog:0x007fd8399eb920>
bob.pet.class                 # => Bulldog

bob.pet.speak                 # => "bark!"
bob.pet.fetch                 # => "fetching!"

=end

class Person
  attr_accessor :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets                      # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]

# Cannot call method `jump` on an array object
bob.pets.jump                  # NoMethodError: undefined method `jump' for [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]:Array

# must operate on the individual elements in the collection
bob.pets.each do |pet|
  pet.jump
end