=begin

#1

class SecretFile
  def initialize(secret_data, files)
    @data = secret_data
    @files = files 
  end
  
  def data
    @files.create_log_entry(@data)
    self
  end
end

class SecurityLogger
  @@log = {}
  
  def create_log_entry(data)
    if @@log.has_key?(data)
      @@log[data] << Time.now
    else
      @@log[data] = [Time.now]
    end  
  end
  
  def log
    @@log
  end
end

x_files = SecurityLogger.new
sr119 = SecretFile.new("sr119", x_files)
nisei = SecretFile.new("nisei", x_files)

puts sr119.data
puts nisei.data
puts sr119.data
puts x_files.log

# 2

module Driveable
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Vehicle
  attr_accessor :speed, :heading
  
  def initialize(mpg, gallons)
    @fuel_efficiency = mpg
    @fuel_capacity = gallons
  end
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < Vehicle
  include Driveable
  def initialize
    @tires = [30,30,32,32]
    super(28, 9)
  end
end

class Motorcycle < Vehicle
  include Driveable
  def initialize
    @tires = [20,20]
    super(85, 3)
  end
end

class Catamaran < Vehicle
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading
  
  def initialize(num_propellers, num_hulls)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    super(11, 75)
  end
end


plane = Catamaran.new(4, 2)
car = Auto.new
mono = Motorcycle.new

puts plane.propeller_count
puts plane.hull_count
puts car.tire_pressure(1)
puts car.range
puts mono.tire_pressure(1)
puts mono.range
puts plane.range
car.inflate_tire(1, 45)
puts car.tire_pressure(1)
puts car.tire_pressure(0)
puts car.tire_pressure(2)
puts car.tire_pressure(3)

# 3

module Moveable
  attr_accessor :speed, :heading
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
  
end



class WheeledVehicle
  include Moveable
  
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
  
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Moveable
  attr_reader :propeller_count, :hull_count
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end

class Motorboat < Catamaran
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)  
  end
end
=end

# 4

module Moveable
  attr_accessor :speed, :heading
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable
  
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
  
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Seacraft
  include Moveable
  attr_reader :propeller_count, :hull_count, :fuel_efficiency, :fuel_capacity

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end
  
  def range
    super + 10
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)  
  end
end

class Catamaran < Seacraft
end


boat = Catamaran.new(3, 1, 25, 34)
puts boat.propeller_count
puts boat.hull_count
puts boat.fuel_efficiency
puts boat.range