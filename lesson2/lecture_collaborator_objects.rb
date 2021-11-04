# class Person
#   def initialize(name)
#     @name = name
#   end

#   def name
#     @name
#   end
# end

# joe = Person.new("Joe")
# joe.name

# class Person
#   def initialize
#     @heroes = ['Superman', 'Spiderman', 'Batman']
#     @cash = {'ones' => 12, 'fives' => 2, 'tens' => 0, 'twenties' => 2, 'hundreds' => 0}
#   end

#   def cash_on_hand
#     # this method will use @cash to calculate total cash value
#     # we'll skip the implementation
#   end

#   def heroes
#     @heroes.join(', ')
#   end
# end

# joe = Person.new
# joe.cash_on_hand            # => "$62.00"
# joe.heroes                  # => "Superman, Spiderman, Batman"


class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new  # assume Bulldog class from previous assignment

bob.pets << kitty
bob.pets << bud

bob.pets       # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]

# bob.pet    # => #<Bulldog:0x007fd8399eb920>
# bob.pet.class                 # => Bulldog

# bob.pet.speak                 # => "bark!"
# bob.pet.fetch                 # => "fetching!"