require 'pry'
#1 Code the class definition
=begin
- we need a method getter and a method setter
- we need a constructor to initialize a class variable @name
    to the name passed to the new method
    
    class Person
      attr_accessor :name

      def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
puts bob.name                 # => 'bob'
bob.name = 'Robert'
puts bob.name                 # => 'Robert'

# 2 Modify the class definition from above to facilitate the following methods

- need to define a class Person
- need a constructor method to initialize instance variable @name
- need getter and setter methods for name, first name, and last name
- need a setter method for last_name



class Person
  attr_accessor :first_name, :last_name
  
  def initialize(first_name, last_name = '')
    @first_name = first_name
    @last_name = last_name
  end
  
  def name 
    (first_name + ' ' + last_name).strip
  end
end


bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'
=end
# 3 

# take a name
# split the name
# check if the name is size 1 or 2
#  - if size 1, set the first element to first name
#    - if size 2 set the first element to the first name, and the last name to the second element

class Person
  attr_accessor :first_name, :last_name, :name
  
  def initialize(name)
    @name, @first_name, @last_name = parse_name(name)
  end
  
  def last_name=(last_nm)
    @last_name = last_nm
    self.name = (first_name + ' ' + last_name).strip
  end
  
  def name=(name)
    parse_name(name)
  end

  def to_s
    name
  end

  private

  def parse_name(name)
    @name, @first_name, @last_name = '', '', ''
    name_arr = name.split
    
    if name_arr.size == 2
      @first_name = name_arr.first
      @last_name = name_arr.last
      @name = (name_arr.join(' ')).strip
    else
      @first_name = name_arr.first
      @last_name = ''
      @name = (name_arr.join(' ')).strip
    end
    [@name, @first_name, @last_name]
  end
end

# bob = Person.new('Robert')
# puts bob.name                  # => 'Robert'
# puts bob.first_name            # => 'Robert'
# puts bob.last_name             # => ''
# bob.last_name = 'Smith'
# puts bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# puts bob.first_name            # => 'John'
# puts bob.last_name             # => 'Adams'
# puts bob.name

# 4
# How can we compare two objects?
# ==

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')
# puts bob.name == rob.name

# 5 

# Will output the class name Person, and the number which represents its place in memory



bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
