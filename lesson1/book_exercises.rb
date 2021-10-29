=begin
# exercise 1
# How do we create an object in Ruby? Give an example of the creation of an object.

class Table
end

wormy_chestnut = Table.new

# exercise 2
# What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly. 

# A module is a way for differenct classes to share behavior without using inheritance
# To use them with our classes, we have to mix them in using the include method


module Creak
  def creak(sound)
    puts sound
  end
end

class Table
  include Creak
end

wormy_chestnut = Table.new

puts wormy_chestnut.creak("Eeeeiiiiuu")


# Exercise 3

# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :year, :color, :model, :speed
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def current_speed
    if speed > 0 
      puts "I am going #{speed} mph."
    else 
      puts "I am parking the car."
    end
  end
  
  def speed_up(n)
    self.speed += n
    current_speed
  end
  
  def brake(n)
    self.speed -= n
    current_speed
  end
  
  def turn_off
    self.speed = 0
    current_speed
  end
  
  def info
    puts "I drive a #{color} #{year} #{model}."
  end
end

honda = MyCar.new(2013, "blue", "Fit")
puts honda.speed

honda.speed_up(40)

honda.brake(15)

honda.turn_off

# puts honda.year
# puts honda.model
# puts honda.color

puts honda.info

# Exercuse 4

# Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.


class MyCar
  attr_accessor :color, :speed
  attr_reader :year
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def current_speed
    if speed > 0 
      puts "I am going #{speed} mph."
    else 
      puts "I am stopping to park the car."
    end
  end
  
  def speed_up(n)
    self.speed += n
    current_speed
  end
  
  def brake(n)
    self.speed -= n
    current_speed
  end
  
  def turn_off
    self.speed = 0
    current_speed
  end
  
  def info
    puts "I drive a #{color} #{year} #{model}."
  end
end

honda = MyCar.new(2013, "blue", "Fit")

# honda.speed_up(40)
# honda.brake(15)
# honda.turn_off

puts honda.color
honda.color = "Teal"
puts honda.color
puts honda.year

# Exercise 5

# You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.


class MyCar
  attr_accessor :color, :speed
  attr_reader :year
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def spray_paint(new_color)
    self.color = new_color
  end
  
  def speed_up(n)
    self.speed += n
  end
  
  def brake(n)
    self.speed -= n
  end
  
  def turn_off
    self.speed = 0
  end
  
  def info
    puts "I drive a #{color} #{year} #{model}."
  end
end

honda = MyCar.new(2013, "blue", "Fit")

puts honda.color
honda.spray_paint("Candy Red")

puts honda.color


# Exercise 6:

# Add a class method to your MyCar class that calculates the gas mileage of any car.


class MyCar
  attr_accessor :color, :speed
  attr_reader :year
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def self.gas_mileage(miles, gallons)
    "#{miles/gallons} miles per gallon."
  end   
  
  def spray_paint(new_color)
    self.color = new_color
  end
  
  def speed_up(n)
    self.speed += n
  end
  
  def brake(n)
    self.speed -= n
  end
  
  def turn_off
    self.speed = 0
  end
  
  def info
    puts "I drive a #{color} #{year} #{model}."
  end
end


puts MyCar.gas_mileage(345, 9)

# Exercise 7

# Override the to_s method to create a user friendly print out of your object.

class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def self.gas_mileage(miles, gallons)
    "#{miles/gallons} miles per gallon."
  end   
  
  def spray_paint(new_color)
    self.color = new_color
  end
  
  def speed_up(n)
    self.speed += n
  end
  
  def brake(n)
    self.speed -= n
  end
  
  def turn_off
    self.speed = 0
  end
  
  def to_s
    "My #{self.color} #{self.year} #{self.model} is rad!"
  end
  
  def info
    puts "I drive a #{color} #{year} #{model}."
  end
end


# puts MyCar.gas_mileage(345, 9)
honda = MyCar.new(2021, 'blue', 'Fit')
puts honda


# Exercise 8:

#When running the following code...

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
puts bob.name

# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
#   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how do we fix it?

# On line 289 we've invoked method attr_reader and passed it the symbol :name which only creates a getter method which retrieves the object assigned to instance variable @name. If we invoke attr_accessor insteaad, or attr_writer, we would then have access to a setter method name=, which would would then allow us to invoke method name= on line 296 without throwing an error


# Exercise 9-15:

module Flyable
  def fly
    puts "My #{self.model} can fly"
  end
end

class Vehicle
  @@vehicles = 0
  
  attr_accessor :year, :color, :model, :speed
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@vehicles += 1
  end
  
  def self.number_of_vehicles
    puts "I have #{@@vehicles} vehicle(s)..."
  end
  
  def spray_paint(new_color)
    self.color = new_color
  end
  
  def speed_up(n)
    self.speed += n
  end
  
  def brake(n)
    self.speed -= n
  end
  
  def turn_off
    if self.speed > 35
      puts "I'm crashing the car now...Goodbye"
    end
    self.speed = 0
  end
end

class MyCar < Vehicle
  include Flyable
  GALLONS = 9
  
  def gallons
    GALLONS
  end
  
  def self.gas_mileage(miles, gallons)
    "My car gets #{miles/gallons} miles to the gallon."
  end   
  
  def info
    "I drive a #{color} #{year} #{model}."
  end
  
  def to_s
    "My #{self.color} #{self.year} #{self.model} is rad!"
  end
  
  def age
    puts "The car is #{calculate_age} years old."
  end
  
  private
  
  def calculate_age
    current_year = Time.new.year
    current_year - self.year.to_i
  end
end

class MyTruck < Vehicle
  GALLONS = 15
  
  def to_s
    "My #{self.color} #{self.year} #{self.model} is radical!"
  end
  
end

# Vehicle.number_of_vehicles

# fit = MyCar.new("2013", "blue", "fit")
# p fit
# puts fit.info
# puts MyCar.gas_mileage(296, fit.gallons)

# Vehicle.number_of_vehicles


# tacoma = MyTruck.new("2017", "Grey", "tacoma")
# puts tacoma.year
# puts tacoma.speed

# Vehicle.number_of_vehicles

# fit.fly

# # puts Vehicle.ancestors
# # puts MyCar.ancestors
# puts MyTruck.ancestors

# fit = MyCar.new("2013", "blue", "fit")

# fit.speed_up(40)
# puts fit.speed
# fit.brake(20)
# puts fit.speed
# p fit

# truck = MyTruck.new("2019", "purple", "Countache")
# p truck
# truck.speed_up(140)
# truck.turn_off

fit = MyCar.new("2013", "blue", "fit")
fit.age



class Student
  attr_accessor :name
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(stdnt)
    self.grade > stdnt.grade
  end
  
  protected
  
  def grade
    @grade
  end
end


bob = Student.new("Bob", 90)
joe = Student.new("Joe", 101)

puts "Well done!" if joe.better_grade_than?(bob)


# Exercise 16

# Given the following code...

bob = Person.new
bob.hi
=end

# And the corresponding error message...

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how would you go about fixing it?

# The method hi is private, meaning the method hi is defined after the private keyword is declared. This means we do not have access to the method outside of the scope of the class. We can either move the method definition to the top of the private keyword, or we can create a method in the class that calls the hi method from within the class, so that the method returns the message to our invocation in the outermost scope

