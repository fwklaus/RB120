# Reviews: |

=begin
# 1
# Number 1 is a boolean 
# Number 2 is a string
# Number 3 is an array
# Number 4 is an integer
# We can call method class on the objects to find out

# 2
# We can create a super class Vehicle that sublcasses both classes. We can then mix in module Speed in the superclass making go_fast available to objects of either class. We would then instantiate objects for both classes and call the method on each to check if the object can go_fast

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Vehicle
  include Speed
end

class Car < Vehicle
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck < Vehicle
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

Car.new.go_fast
Truck.new.go_fast

# 3
# In the go_fast method we have a string with an interpolated value - a refernce to `self.class`. What this reference does changes depending on the context where the method is invoked. If the method is called by a Truck object, than self refers to the truck object, and class called on the struck object will return `Truck`. If we called the method from Car, it would return `Car`. String interpolation automatically calls to_s on the value passed to it, so the class names are converted to a string representation and the method returns the string. 

# 4
# To create a new instance of class `AngryCat`, we would need call method `new` on the class, which instantiates a new object of the class, and returns the new object. 

# 5
# The pizza class has an instance variable. We can tell by the syntax - the `@` symbol preceding the variable name tells us it's an instance variable. Alternatively, we can call method `instance_variables` on the object to return an array of the instance variables the object encapsulates. 


class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

p Pizza.new("Pepperoni").instance_variables
p Fruit.new("Banana").instance_variables
=end

# 6
# To access the instance variable `@volume`, we would need a getter method that returns the value `@volume` references. 

# 7
# The default implementation for `to_s` when we invoke the method on an object comes from Object#to_s. This outputs a string representation of the object with the class name, an encoding of its object id, and any any initialized instance variables all wrapped in the greater than, lesser than symbols. To be sure of this, we can check Ruby Docs to find out.  

# 8

# In this example, self refers to the calling object. This line disambiguates our reference to setter method age=() from local variable initialization

# 9
# In this context self refers to the class, `Cat`. Making an expicit call to self in a method definition is how we define a class method. Essentially, `self.cats_count` is saying `Cat.cats_count`.  

# 10
# To create a new instance of the class we would need to call method `new` on the class, passing in two arguments, which are then used to initialize instance variables `@color`, and `@material` in the `initialize` method. 