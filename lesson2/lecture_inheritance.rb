class Pet
  def run
    "running!"
  end

  def jump
    "jumping!"
  end

  def eat
    "eating"
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    "fetching!"
  end
end

class Bulldog < Dog
  def swim
    "can't swim"
  end
end

class Cat < Pet
  def speak
    "meoow..."
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

karl = Bulldog.new
puts karl.speak
puts karl.swim
puts karl.eat

kitty = Cat.new
puts kitty.run
puts kitty.speak
puts kitty.eat
puts kitty.jump

# The method lookup path is the order in which Ruby checks for a method in its classes whenever a method is invoked

p Bulldog.ancestors