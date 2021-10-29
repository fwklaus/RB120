=begin
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

# sparky = GoodDog.new
# sparky.speak("Arf!")    # => Arf!
# bob = HumanBeing.new 
# bob.speak("Hello!")    # => Hello!

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors
=end

# Initializing a new object


# class GoodDog
#   def initialize
#     puts "This object was initialized"
#   end
# end

# sparky = GoodDog.new 

# class GoodDog
#   def initialize(name)
#     @name = name
#   end
  
#   def name
#     @name
#   end

#   def name=(name)
#     @name = name
#   end

#   def speak
#     "#{@name} says Arf!"
#   end
# end

class GoodDog
  # attr_accessor :name
  attr_accessor :name, :height, :weight

  # def initialize(name)
  #   @name = name
  # end

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end
  # def speak
  #   "#{@name} says arf!"
  # end

  def speak 
    "#{name} says arf!"
  end

  # def change_info(n, h, w)
  #   @name = n
  #   @height = h
  #   @weight = w
  # end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def self.what_am_i
    "I'm a GoodDog class!"
  end

  def what_is_self
    self
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


# sparky = GoodDog.new("Sparky")
# puts sparky.speak
# puts sparky.name
# sparky.name = "Spartacus"
# puts sparky.name

# fido = GoodDog.new("Fido")
# puts fido.speak

# sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")
# puts sparky.info

# sparky.change_info('Spartacus', '24 inches', '45 lbs')
# puts sparky.info

# puts GoodDog.what_am_i

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self