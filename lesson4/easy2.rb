# Reviews: |

# 1. 
# On `line 1`, we instantiate object `oracle` of type `Oracle`. We then call instance method `predict_the_future` on the `oracle` object, which returns a string. The string the method returns is the result of concatenating a string with another string returned by calling method `sample` on instance method `choices`, which returns an array of strings. The code, when run, will return some random string. 

# 2.
# We call method `predict_the_future` on our `trip` object. Ruby finds the method in `Oracle`, which sublcasses `RoadTrip`. The method concatenates string `You will` with the value returned by calling method `sample` on the array of string returned by method `choices`. Even though `predict_the_future` is found in `Oracle`, Ruby, looks for method `choices` in the subclass which overrides `choices` in class `Oracle`. The call returns "You will" concatenated with a string from Roadtrip#choices array. 

# 3.
# The method lookup chain tells you where Ruby will look for a method when the method is called. Ruby starts in the class of the calling object. From there, if the method isn't found, it looks in mixin modules if any are included, starting with the last. After that it looks in any inherited classes, and finally, it defaults to the two classes and module that all classes inherit from: `Object`, `Kernel`, and `BasicObject`. An easy way to find the object's ancestors is to call method `ancestors` on the object's class, which will return an array of class and module names describing the method lookup chain. 

# 4.
# You could call method `attr_accessor`, which will create default getter and setter method implementations for the sybol passes as an argument at invocation. In this case `attr_accessor :type` would result in the same functionality as the current class definition. 

# 5.

#excited_dog = "excited dog"   # local variable
#@excited_dog = "excited dog"  # instance variable
#@@excited_dog = "excited dog" # class variable

# We can tell the first variable is a local variable by the exclusion of the `@` symbol. The second variable includes a single `@` symbol so we know it's an instance variable. The third variable includes two `@@` symbols, so we know it's a class variable

# 6.
# `self.manufacturer` is a class method. We can tell by the explicit call to self prefixing the method name. To call a class method we can simply call the method name on the class.

# 7.
# the `@@class_count` variable is a class variable. Each time a `Cat` object is instantiated, the variable is incremented by `1`. The variable tracks the number of instances we've created for class `Cat`. To test the theory we could instantiate a few `Cat` instances, and then call class method `self.cats_count` which returns the value of `@@cats_count`

=begin
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

Cat.new("Tiger")
Cat.new("spotted")
Cat.new("Yorkshire")
Cat.new("Siamese")

p Cat.cats_count
=end

# 8.
# We can simply add the inheritance symbol (<) following the class name followed by the class we'd like to inherit, in this case `Game`. This would give us access to all of the `Game` methods. 

# 9.
# If we added a `play` method to the `Bingo` class the subclass method would override the superclass method. Whenever we call `play`, Ruby would then find the method in `Bingo`, and execute it. Ruby stops method lookup when it finds the method it wants to invoke. 

=begin
 10.
 The benefits of OOP:
      - It allows us to work at a higher level of abstraction by using real world nouns and verbs to represent the states and behaviors we're trying to model for a program
      - It makes it so that our programs function like a multitude of interconnected parts, rather than a single large dependency
      - Through polymorphism and inheritance OOP allows us to define reusable generalized classes that can be sublcassed for specialization. 
               - This helps us keep our code DRY(Don't repeat yourself)
                 which makes it easier to maintain our code and make changes. 
                      - This allows for specialization, since we only need to change our code in one place
                      - It also allows us to resuse re-written code making writing programs much faster
      - Encapsulation lets us hide functionality from  the outside world, choosing how and what state and behavior are available for outside use
              - this keeps our data more secure, and less prone to outside changes


=end