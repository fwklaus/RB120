=begin
# 1 
# We instantiate a new object of class Oracle
# We then call instance method `predict_the_future` on the oracle object referenced by local variable `oracle`. This returns a string where we concatenate string "You will" with a string returned from an invocation to instance method `choices`, which returns an array, with method `sample` called on it, which returns one of the string elements from the array




class Oracle
  def predict_the_future
    "You will " + choices.sample
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.predict_the_future

# 2

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
puts trip.predict_the_future

# We instantiate a new object of class Roadtrip
# We then call method `predict_the_future` on the `RoadTrip` object referenced by local variable `trip`. This  call returns a string concatenated with a string sampled from the array returned from method `choices` in class `Roadtrip`. The call outputs "You will <somethind>", which will be either "visit Vegas, "fly to Fiji", or "romp in Rome" 

# 3

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors
p HotSauce.ancestors

# To find an object's ancestors, we can call method `ancestors` on a class to display the method lookup chain

# The lookup chain for Orange is: Orange, Taste, Object, Kernel, BasicObject
# The lookup chain for HotSauce is: HotSauce, Taste, Object, Kernel, BasicObject

# 4

# replace the custom getter and setter methods with methods created by invoking `attr_accessor`

class BeesWax
  attr_accessor :type
  
  def initialize(type)
    @type = type
  end
  
  # def type
  #   @type
  # end
  
  # def type=(t)
  #   @type = t
  # end
  
  def describe_type
    puts "I am a #{type} type of Bees Wax"
  end
end

burt = BeesWax.new("yellow")
burt.describe_type

# 5

The first variable is a local variable. The second variable is an instance variable. The third variable is a class variable. The syntax tells us everthing we need to know. The local variable is named without an @ symbol prepended. The instance variable has one @ prepended. The class variable has two @ symbols prepended


excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"


# 6

class Television
  def self.manufacturer
    # method logic
  end
  
  def model
    # method logic
  end
end

# the method defined with the self invocation is the class method. To invoke it, call the method directly on the class

p Television.manufacturer

# 7

class Cat
  @@cats_count = 0
  
  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end
  
  def self.cats_count
    @@cats_count
  end
end

# The @@cats_count method is a class variable. We initialize it to integer value `0`. In the constructor method, we increment the value of the class variable by 1 each time we instantiate a new instance of class Cat. We can instantiate a few objects of type Cat, and then call the class method `self.cats_count` to output the value of the class variable, which records the number of cat instances that have been created

Cat.new("Tom")
Cat.new("Garfield")
Cat.new("Scratchy")

puts Cat.cats_count

# 8

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# We can add the inheritance symbol and the name of the class we'd like to inherit from 

puts Bingo.new.play

# 9 

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
  
  def play
    "The first number is..."
  end
end

# If we added a `play` method to the `Bingo` class, this method would overrided the inherited method from class `Game`

puts Bingo.new.play

# 10

OOP allows you to write programs that are the interaction of many small parts rather than a single large dependecy. Encapsulation allows you to write modular, reusable pieces of code that are only available for specific use cases to specific classes. Polymorphism allows you to not have to repeat yourself, using the implementation for inherited methods rather than having to provide your own for every particular behavior you'd like to model. Polymorphism also allows you to ovveride method names which allows for objects of different types to respond differently to the same method invocations. This allows for you to customize behavior and write reusable code without having to refer back to implementation details. Instance variables allow you tie data to objects that only pertains to specific objects. Class variables allow you to track class level details which can interact with the state of different objects. Overall, OOP allows for you to write complex problems in a manageable, modular, and concise way. 


=end