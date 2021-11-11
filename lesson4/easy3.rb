=begin
#1

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

# case 1
# hello = Hello.new
# hello.hi

# We are instantiating a new instance of class `Hello``
# We then call instance method `hi` on the `Hello` object which calls
#     method `greet` inherited from class `Greeting`, which outputs the 
#         argument : string `Hello`.

# case 2
# hello = Hello.new
# hello.bye

# We instantiate a new instance of class `Hello` which is assigned to local variable `hello` . We then call instance method `bye` on `hello`. Instance method `bye` is defined in class `Goodbye`, which class `Hello` does not inherit from. The method is unavailable to class `Hello`, so some kind of exception will be thrown, maybe a `NoMethodError`

# case 3
# hello = Hello.new
# hello.greet

# We again instantiate a `Hello` object and assign it to local variable `hello`. We then call instance method `greet` inherited from class `Greeting` on the object referenced by `hello`. The method expects an argument, so an exception will likely be thrown: "ArgumentError"; Exepected 1 argument, received 0

# case 4

hello = Hello.new
hello.greet("Goodbye")

# We instantiate a `Hello` object and assign it to local variable `hello`. We then call instance method `greet`, inherited from class `Greeting` and pass it a single string agumetn `Goodbye`, which is what the body of the method call outputs

# case 5

Hello.hi

# Here we are invoking class mehtod self.hi of class `Hello`, which is undefined. This will throw an exception: "NoMethodError"


# 2

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# hello = Hello.new
# hello.hi

Hello.hi

# We are calling instance method `hi` on class `Hello`. To call the method, we first need to instantiate a `Hello` object 

# Alternatively, we could redefine method `hi` as a class method which requires that we instantiate a new object of class `Greeting` within the method before calling method `greet` on it, as method `greet` is defined as an instance method, and is unaccessable to the class method 

# 3

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end
  
  def age
    puts @age
  end
  
  def name
    puts @name
  end
  
  def hiss
    puts "Hisssss!!!"
  end
end


tom = AngryCat.new(75, "Tom")
garfield = AngryCat.new(63, "Garfield")

tom.age
garfield.age
tom.hiss
garfield.name

# 4

class Cat
  attr_reader :type
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{type} cat"
  end
end

tabby = Cat.new("tabby")
puts tabby


# 5

class Television
  def self.manufacturer
    # method logic
  end
  
  def model
    # method logic
  end
end



tv = Television.new  # instantiating a new class object
tv.manufacturer    # NoMethodError
tv.model    # executes body of instance method `model`

Television.manufacturer  # executes body of class method `self.manufacturer`
Television.model # NoMethodError

class Cat
  attr_accessor :type, :age
  
  def initialize(type)
    @type = type
    @age  = 0
  end
  
  def make_one_year_older
    @age += 1  
  end
end

# we can just remove the `self` prefix. In this context it refers to the calling object. The `self` prefex here is used to disambiguate a reference to a local variable from in invocation to a setter method, which it is. Without the use of `self`, we can instead just call the instance variable directly 
=end

# 7

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

# The `return` keyword in class method `information` is redundant as the string would be returned implicitly in this case. Also we never use the setter or getter methods which are created by the call to `attr_accessor` on the first line of the class