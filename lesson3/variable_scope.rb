=begin
class Person
  def initialize(n)
    @name = n
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect              # => #<Person:0x007f9c830e5f70 @name="bob">
puts joe.inspect              # => #<Person:0x007f9c830e5f20 @name="joe">


class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name                     # is the @name instance variable accessible here?
  end
end

bob = Person.new('bob')
puts bob.get_name                  # => "bob"

# Trying to access an instance variable that is not yet initialized anyhwere 

class Person
  def get_name
    @name                     # the @name instance variable is not initialized anywhere
  end
end

bob = Person.new
p bob.get_name                  # => nil

# Class Variable Scope

class Person
  @@total_people = 0            # initialized at the class level
  
  def self.total_people
    @@total_people              # accessible from class method
  end
  
  def initialize
    @@total_people += 1         # mutable from instance method
  end
  
  def total_people
    @@total_people              # accessible from instance method
  end
end

Person.total_people             # => 0
Person.new
Person.new
Person.total_people             # => 2

bob = Person.new
bob.total_people                # => 3

joe = Person.new
joe.total_people                # => 4

Person.total_people             # => 4
=end


# Constant scope

class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  attr_reader :name

  def self.titles
    TITLES.join(', ')
  end

  def initialize(n)
    @name = "#{TITLES.sample} #{n}"
  end
end

Person.titles                   # => "Mr, Mrs, Ms, Dr"

bob = Person.new('bob')
bob.name                        # => "Ms bob"  (output may vary)