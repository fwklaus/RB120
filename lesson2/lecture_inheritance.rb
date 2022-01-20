=begin
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim 
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
=end

class  Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
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
    'fetching!'
  end
end

class Bulldog < Dog
  def swim 
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"

begin
  pete.speak              # => NoMethodError
rescue NoMethodError => e
  puts e.message
end

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"

begin
  kitty.fetch             # => NoMethodError
rescue NoMethodError => e
  puts e.message
end

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"

# The method lookup path is the linear order in which Ruby searches for a method when it is called. The first place it looks is in the calling object, then in the included modules(last included first), then the inherited classes. If the inherited class mixes in a module, that is inherited as well, and would be searched through after the inherited class, and so on. Ruby stops looking through the class hierarchy when a method is found, or when there are no more classes to search