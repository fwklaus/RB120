require 'pry'
=begin
# 1

class BankAccount
  attr_reader :balance
  
  def initialize(starting_balance)
    @balance = starting_balance
  end
  
  def positive_balance?
    balance >= 0
  end
end

# Ben is right, although Alyssa's criticism is valid. Ben is using the getter method to return the value of the instance variable rather than directly referencing the instance variable like Alyssa suggests. Both implemntations would work the same here

# 2

class InvoiceEntry
  attr_reader :quantity, :product_name
  
  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end
  
  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# "This will fail when update_quantity is called"
#  We need to prepend `quantity` with `self` to call the setter method from the body of method `update_quantity`, and we need to change attr_reader to attr_accessor, or create a call to attr_writer passing quantity as an argument. As it is, this is local variable initialization. 


# 3

class InvoiceEntry
  # attr_reader :quantity, :product_name
  attr_accessor :quantity, :product_name
  
  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end
  
  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

# The only problem with this fix might be that we now have getter methods and a setter method that aren't in use. A more appropriate solution might be to just call attr_writer with :quantity passed as an argument

# Changing the public interface to allow clients to directly access instance variables, you need to be sure you aren't bypassing important protections or validation built into your methods 


# 4

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
  
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
goodbye = Goodbye.new

hello.hi
goodbye.bye

# 5

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
  
  def filling_type
    return 'Plain' if @filling_type.nil?
    @filling_type
  end
  
  def glazing
    return '' if @glazing.nil?
    @glazing
  end
  
  def to_s
    return "#{filling_type}" if glazing.empty?
    "#{filling_type} with #{glazing}"
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

# 6 
class Computer
  attr_accessor :template
  
  def create_template
    @template = "template 14231"
  end
  
  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end
  
  def show_template
    self.template
  end
end

cpu = Computer.new
cpu.create_template
puts cpu.show_template

# With the first implementation, we don't initialize instance variable @template until instance method create_template is called. We access the instance variable directly

# Wtih the second implementation, we access instance variable template through the use of a setter method once instance method create_template is called. In our show_template method, self is prefixed to a call to the template getter, which is a little redundant
=end

# 7

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def status
    "I have a brightness level of #{brightness} and a color of #{color}."
  end
end

light = Light.new("bright", 'blue')

puts light.status

