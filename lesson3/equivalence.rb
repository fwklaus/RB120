=begin
str1 = "something"
str2 = "something"
str1 == str2            # => true

int1 = 1
int2 = 1
int1 == int2            # => true

sym1 = :something
sym2 = :something
sym1 == sym2            # => true



str1 = "something"
str2 = "something"

str1.class              # => String
str2.class              # => String

str1 = str1 + " else"
str1                    # => "something else"

str1 == str2            # => false



#----------------------------------------------------------
str1 = "something"
str2 = "something"
str1_copy = str1

# comparing the string objects' values
str1 == str2            # => true
str1 == str1_copy       # => true
str2 == str1_copy       # => true

# comparing the actual objects
str1.equal? str2        # => false
str1.equal? str1_copy   # => true
str2.equal? str1_copy   # => false


# default implementation for ==
#       - same as equal?
class Person
  attr_accessor :name
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => false

bob_copy = bob
bob == bob_copy            # => true


# overriding == so we check the equivalency of the value assigned to local variables bob and bob2

class Person
  attr_accessor :name

  def ==(other)
    name == other.name     # relying on String#== here
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => true

=end

# object_id

str1 = "something"
str2 = "something"

str1.object_id            # => 70186013144280
str2.object_id            # => 70186013536580


arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => false

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => true

int1 = 5
int2 = 5
int1.object_id == int2.object_id      # => true



# ===

num = 25

case num
when 1..50
  puts "small number"
when 51..100
  puts "large number"
else
  puts "not in range"
end

# ------> implicit
num = 25

if (1..50) === num
  puts "small number"
elsif (51..100) === num
  puts "large number"
else
  puts "not in range"
end


String === "hello" # => true
String === 15      # => false