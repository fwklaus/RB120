# Reviews: |

# 1
# Ben is right. We are using a getter method here on `line 9` when we reference `balance`. This is perfectly valid. Alyssa's solution is also valid. We can reference the instance variable directly, however, it is a good idea to use the getter method if one is available. In this case it would't make much of a difference. 

# 2 
# On `line 11`, we are  initializing local variable `quantity` if the value passed to the method is greater or equal to 0. We should make an explicit call to `self` here if we want to reference the setter method to update `@quanity`. We would also need to call `attr_accessor` and pass `:quantiy` as an argument since a setter method is not available to call. We currently only have getter methods created from our call to `attr_reader`.

# 3
# No there is nothing wrong with this fix, except we would also create a setter for product name which would then expose the instance variable to outside modifications from client code. It might be better if we create a seperate call to `attr_accessor` passing `:quantity` as an argument, leaving the `:product_name` as an argument in `attr_reader`. This also bypasses any functionality, checks, validation built into the `update_quantity` method by altering the public interface and allowing direct access to updates to the object's state via client code.

# 4

=begin
class Greeting
  def greet(str)
    puts str
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def goodbye
    greet("Goodbye")
  end
end

greeting1 = Hello.new
greeting2 = Goodbye.new

greeting1.hi
greeting2.goodbye
=end

# 5
=begin
require 'pry'
class KrispyKreme
  attr_reader :filling_type, :glazing

  def initialize(filling_type, glazing)
    @filling_type = set_type(filling_type)
    @glazing = glazing  
  end

  private

  def set_type(filling_type)
    filling_type.nil? ? "Plain" : filling_type
  end

  def to_s
    if glazing.nil?
      "#{filling_type}"
    else
      "#{filling_type} with #{glazing}" 
    end
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  # => "Plain"

puts donut2
  # => "Vanilla"

puts donut3
  # => "Plain with sugar"

puts donut4
  # => "Plain with chocolate sprinkles"

puts donut5
  # => "Custard with icing"

=end

# 6
# The difference between the two implementations is the way in which we reference instance variable `template`. In the first example we set the value of instance variable `@template` directly, while in the second we rely on our setter method to do this. In method `show_template`, we call getter method `template` to return the value of `@template`, while in the second example we make an explicit to self to return the value of `@template`. Both are valid ways to refernce our instance variable. 

# 7
# I would change the method name of `light_status` to `status`. `Light#light_status` is a bit redundant. `Light#status` is a bit more clear.  