=begin
# instance variable initialized in superclass by constructor inherited by subclass
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! Teddy bark! bark!


# instance variable uninitialized in subclass with constructor that overrides superclass 

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! bark! bark!

# uninitialized instance variable unavailable when mixed in with Dog class until method where its initialized is called

module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim
  
  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim                                  # => nil


teddy = Dog.new
teddy.enable_swimming
p teddy.swim                                  # => swimming!

# class variable initialized in superclass is available to subclass
class Animal
  @@total_animals = 0
  
  def initialize
    @@total_animals += 1
  end
end

class Dog < Animal
  def total_animals
    @@total_animals
  end
end

spike = Dog.new
p spike.total_animals                           # => 1

# Only one copy of a class variable across all subclasses. Makes the combination of class inheritance and class variables a dangerous one

class Vehicle
  @@wheels = 4
  
  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels                              # => 4

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels                           # => 2
p Vehicle.wheels                              # => 2  Yikes!

class Car < Vehicle
end

p Car.wheels                                  # => 2  Not what we expected!


# attempt to reference a constant initialized in another class throws an error
class Dog
  LEGS = 4
end

class Cat
  def legs
    LEGS
  end
end

kitty = Cat.new
kitty.legs                                  # => NameError: uninitialized constant Cat::LEGS

# accessing a constant initialized in another class using the namespace resolution operator (::)
class Dog
  LEGS = 4
end

class Cat
  def legs
    Dog::LEGS                               # added the :: namespace resolution operator
  end
end

kitty = Cat.new
p kitty.legs                                  # => 4

# The constant initialized in a superclass is inherited, and available to the subclass by both class and instance methods 

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  def self.wheels
    WHEELS
  end
  
  def wheels
    WHEELS
  end
end

p Car.wheels                                  # => 4

a_car = Car.new
p a_car.wheels                                # => 4

# the WHEELS constant is unavailable to the instance method in the module mixed in with the class that inherits from the class where the constant was initialized

module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
p a_car.change_tires                          # => NameError: uninitialized constant Maintenance::WHEELS
=end

# the following fixes will work

module Maintenance
  def change_tires
    "Changing #{Vehicle::WHEELS} tires."    # this fix works
  end
end

# or

module Maintenance
  def change_tires
    "Changing #{Car::WHEELS} tires."        # surprisingly, this also works
  end
end


class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
p a_car.change_tires