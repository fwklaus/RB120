=begin
 # polymorphism through inheritance

 class Animal
  def move
  end
end

class Fish < Animal
  def move 
    puts "swim"
  end
end

class Cat < Animal
  def move
    puts "walk"
  end
end

# Sponges and Corals don't have a seperate move method - they don't move
class Sponge < Animal; end
class Coral < Animal; end

animals = [Fish.new, Cat.new, Sponge.new, Coral.new]
animals.each { |animal| animal.move }

# polymorphism through duck typing
# how you shouldn't do it

class Wedding 
  attr_reader :guests, :flowers, :songs
  
  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
end

class Chef
  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def decorate_place(flowers)
    #implementation
  end
end

class Musician
  def prepare_performance(songs)
    #implementation
  end
end

# refactored: how you should do it

class Wedding 
  attr_reader :guests, :flowers, :songs
  
  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end
  
  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end
  
  def decorate_place(flowers)
    #implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end
  
  def prepare_performance(songs)
    #implementation
  end
end
=end

# Encapsulation

class Dog
  attr_reader :nickname

  def initialize(n)
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private
    attr_writer :nickname
end

dog = Dog.new("rex")
dog.change_nickname("barny")
puts dog.greeting