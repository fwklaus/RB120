=begin
# 1

1. `true` is a boolean object ---> TrueClass object
2.`'hello` is a string object
3. `[1,2,3, 'happy days]` is an array object
4. `142` is an integer object

-To check the class of any particular object, call `class`` on the object


# 2

We can include the module Speed in the car and truck classes seperately using the `include` method to mixin the module, or we mixin the module in class `Car`, and have class `Truck` inherit from `Car`. Either option gives us the ability to call method `go_fast`. 

I can check if the car or truck can now go fast by instantiating a new object of either type, and calling `go_fast` on the object 



module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

Truck.new.go_fast
Car.new.go_fast

# 3

When we call method `go_fast` on the new instance of a class where module
 `Speed` was mixed in, go_fast is available to call on the object. Method `go_fast` is defined to output a string with a reference to `self.class` interpolated in the string. The `self` invocation in this instance refers to the class where the module was mixed in. Method `self` returns `Car`, and method `class` returns the class of the caller, which is class `Car`. This is reflected in the output: 

 "I am a Car and going super fast"

 
 # 4 

 class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# We would create a new instance of class AngryCat by instatiating a new instance:

AngryCat.new.hiss

# 5

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

# class `Pizza` has an instance variable initialized in its constructor method. The syntax for an instance variable is as follows: @variable = "an instance variable. To check if an object has an instance variable, you can inspect the object by passing the object to method `p`, or calling inspect on the object, and ouputing the return value. You can also call method `instance_variables` on an object to return an array of instance variables

pineapple = Fruit.new("pineapple")
pizza = Pizza.new("Pepperoni")

puts pizza.inspect
p pineapple

# 6

class Cube
  attr_reader :volume
  def initialize(volume)
    @volume = volume
  end
end

volumen = Cube.new(500)
puts volumen.volume

# we could add a getter method to acess @vulume. We can either create a custom getter method, or create one using either method `attr_accessor`, or `attr_reader`

# 7

class Cat
  attr_accessor :type, :age
  
  def initialize(type)
    @type = type
    @age  = 0
  end
  
  def make_one_year_older
    self.age += 1
  end
end

timmy = Cat.new("tiger")
puts timmy.age
timmy.make_one_year_older
puts timmy.age

# In the `make_one_year_older` instance method, `self` refers to the calling object. So, whichever instance of the class invokes the method will then increment the value of the @age instance variable by 1

# 8

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

puts Cat.cats_count
mr_bigglesworth = Cat.new("siamese")
puts Cat.cats_count


# The value of `self` depeneds on the context where it is invoked. In this case, outside of an instance method, `self` refers to the class. We are defining a class method in this case which really reads:

#    def Cat.cats_count
#       # method body
#    end

# 10 

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end


shopping_bag = Bag.new("brown", "paper")
p shopping_bag.instance_variables
p shopping_bag

To create a new instance of the class, we could need to call `new` on the class, and pass in arguments to initialize the appropriate instance variables using the constructor method `initialize` 

=end