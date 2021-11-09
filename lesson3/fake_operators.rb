=begin

# comparison methods

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end 
end

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)

bob.name
kim.name


puts "bob is older" if bob > kim            # => "bob is older"
puts "bob is older" if bob.>(kim)           # => "bob is older"

puts "bob is younger" if bob < kim


# The shift methods

my_array = %w(hello world)
my_array << "!!"
puts my_array.inspect                       # => ["hello", "world", "!!"]

my_hash = {a: 1, b: 2, c: 3}
my_hash << {d: 4}                           # => NoMethodError: undefined method `<<' for Hash

class Person
  attr_accessor :name, :age
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def >(other_person)
    age > other_person.age
  end 
end

class Team
  attr_accessor :name, :members
  
  def initialize(name)
    @name = name
    @members = []
  end
  
  def <<(person)
    return if person.not_yet_18?              # suppose we had Person#not_yet_18?
    members.push person
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)     # suppose we're using the Person class from earlier

cowboys << emmitt                           # will this work?

puts cowboys.members                             # => [#<Person:0x007fe08c209530>]


# The plus method

class Person
  attr_accessor :name, :age
  
  def initialize(name, age)
    @name = name
    @age = age
  end

  # pushing the work to the Integer#> method
  
  def >(other_person)
    age > other_person.age
  end 
end

class Team
  attr_accessor :name, :members
  
  def initialize(name)
    @name = name
    @members = []
  end
  
  def <<(person)
    members.push person
  end
  
  # this implementation returns an array object
  # def +(other_team)
  #   members + other_team.members
  # end
  
  # this implementation returns a new object
  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)


niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

# p cowboys
# p niners

dream_team = cowboys + niners               # what is dream_team?
puts dream_team.inspect


# Element setter and getter methods

my_array = %w(first second third fourth)    # ["first", "second", "third", "fourth"]

# element reference
my_array[2]                                 # => "third"
my_array.[](2)                              # => "third"

# element assignment
my_array[4] = "fifth"
puts my_array.inspect                            # => ["first", "second", "third", "fourth", "fifth"]

my_array.[]=(5, "sixth")
puts my_array.inspect                            # => ["first", "second", "third", "fourth", "fifth", "sixth"]
=end



class Person
  attr_accessor :name, :age
  
  def initialize(name, age)
    @name = name
    @age = age
  end

  # pushing the work to the Integer#> method
  def >(other_person)
    age > other_person.age
  end 
end

class Team
  attr_accessor :name, :members
  
  def initialize(name)
    @name = name
    @members = []
  end
  
  def <<(person)
    members.push person
  end

# Pushing the work to the Array#[] and Array#[]= methods
  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
  
  # this implementation returns a new object
  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)


niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)


# assume set up from earlier
cowboys.members                           # => ... array of 3 Person objects

p cowboys[1]                                # => #<Person:0x007fae9295d830 @name="Emmitt Smith", @age=46>
cowboys[3] = Person.new("JJ", 72)
p cowboys[3]                                # => #<Person:0x007fae9220fa88 @name="JJ", @age=72>