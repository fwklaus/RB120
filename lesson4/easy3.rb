# Review: |

# 1
# case 1:
#   We instantiate a `hello` object from class `Hello`, and call instance method `hi` on it. `hi` calls method greet, pasing a single string argument 'Hello'. Ruby looks in the parent class and finds `greet` where it outputs its argument, in this case string `Hello`. 

# case 2:
# We instantiate a `hello` object from class `Hello`, and call instance method `bye` on it. Instance method `bye` is defined in class `Goodbye`, which inherits from class `Greeting` as does class `Hello`. Despite this, `bye` is inaccessible from `Hello` objects. This will throw an exception - undefined method error

# case 3:
#  We instantiate an object named `hello` from class `Hello` and call method `greet` on the object. Since `Hello` derives from class `Greetig`, method greet is available, however, since we do not supply the method an argument at invoaction, the call throws an exception: Argumenet error. Expected 1 argument, 0 received. 

# case 4:
# We instantiate an object named `hello` from class `Hello`, and call method `greet` on it, passing string `Goodbye` as an argument. The method is inherited from class `Greeting`, and outputs the string passed to it, and returns `nil`.

# case 5:
# We attempt to invoke a class method by appending method `hi`, which is an instance method, to class `Hello`. This will throw an exception.  This method does not exist. To call intance method `hi`, we need to call it on an object instance, not a class. Undefined method error

# 2
# we would need to define a class method `self.hi` for the invocation to be valid, and then we would need to call greet on an instance of the class so we can call instance method `greet` on it. Classes define instance methods for instances, not on the class itself. 

# 3
# We would need to instantiate two AngryCat objects, passing each two arguments - age, and name - to initialize the state for the objects. We would save those objects to a variable, otherwise, the objects will no longer exist after instantiation. 

# 4
# Object#to_s is the default implementation for to_s, so if we were to call to_s on an object of type `Cat`, Ruby would traverse the class hierarchy to find to_s in `Object`. We should override to_s in the `Cat` class to create a different implementation for `Cat` objects.

=begin
class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

puts Cat.new("tabby")
=end

# 5
# We instantiate an object named `tv` from class `Television`. We then call instance method `manufacturer` on the object which throwns an exception: NoMethodError. Then we call instance method `model` on `tv` which returns whatever the method returns(`nil` in this case since the body is empty). Then we call class method `self.manufacturer`, which returns whatever that returns. Then we call `self.model`, which doesn't exist, and throws another NoMethodError

=begin
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new

begin
  tv.manufacturer
rescue NoMethodError => e
  puts e.message 
end

p tv.model

p Television.manufacturer

begin
  Television.model
rescue NoMethodError => e
  puts e.message
end
=end

# 6
# The `self` prefix on `line 10` is used to reference the setter method `age`. We could increment the value of the instance variable directly like so: `@age += 1`. As long as we have a getter method, this is not adivised since we would override any functionality the getter method may implement. In this case, working directly on the instance variable has no unintended effect 

# 7
# Presently, we have setter and getter methods created by our `attr_accessor` call which aren't used in any way. The explicit `return` on `line 10` is also useless. If we wanted this code to work, we would also remove the `self` prefix from class method `self.information` to make it an instance method, so we could interpolate getter method calls in the sting the method returns rather than the static string the method currently returns.