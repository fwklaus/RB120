# Ruby's answer to multiple inheritance
# All of the mixin modules methods are available in the classes that include it

module Swim
  def swim
    "swimming!"
  end
end

class Dog
  include Swim
  # ...rest of class omitted
end

class Fish
  incude Swim
  # ...rest of class omitted
end



