class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  def public_disclosure
    puts "#{self.name} in human years is #{self.human_years}"
  end
  private

  def human_years
    age * DOG_YEARS
  end
end

# sparky = GoodDog.new('Sparky', 4)
# sparky.human_years
# sparky.public_disclosure


class Animal
  def a_public_method
    puts "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
   "Yes, I'm protected!"
  end
end

fido = Animal.new
fido.a_public_method


