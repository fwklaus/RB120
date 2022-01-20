# Reviews: |
# 1
=begin
class SecretFile
  def initialize(secret_data, log)
    @secret_data = secret_data
    @log = log
  end
  
  def data
    log.create_entry(secret_data)
    secret_data
  end
  
  private

  attr_reader :secret_data, :log
end

class SecurityLogger
  attr_reader :name, :access
  FILES = %w(A V G H X Y F D C)
  @@log = Hash.new

  def initialize
    @name = FILES.sample + "-files:"
  end

  def self.data
    puts "Data Access:"
    puts "↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕"
    @@log.keys.each do |key|
      puts key
      puts @@log[key]
      puts "↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕↕"
    end
  end

  def get_name(data)
    "#{name}: #{data}"
  end

  def code
    t = Time.new
    t.strftime("on %m/%d/%y: %H:%6N")
  end

  def create_entry(data)
    code_name = get_name(data)

    if @@log.has_key?(code_name)
      @@log[code_name] << code
    else
      @@log[code_name] = [code]
    end
  end
end

log = SecurityLogger.new
secret_file = SecretFile.new("123gr452", log)

secret_file.data
secret_file.data

secret_file2 = SecretFile.new("325@3", log)

secret_file2.data
secret_file2.data

SecurityLogger.data
=end

# 2, # 3, # 4

module Driveable
  attr_accessor :speed, :heading
  attr_writer :fuel_efficiency, :fuel_capacity
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end


class WheeledVehicle
  include Driveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

end

class Auto < WheeledVehicle
  # 4 tires are various tire pressures
  TIRES = [30,30,32,32]

  def initialize
    super(TIRES, 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  # 2 tires are various tire pressures
  TIRES = [20, 20]
  
  def initialize
    super(TIRES, 80, 8.0)
  end
end

class Seacraft
  include Driveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = liters_of_fuel_capacity
    self.fuel_capacity = km_traveled_per_liter
  end

  def range
    super() + 10
  end
end

class Catamaran < Seacraft; end

class Motorboat < Seacraft
  PROPELLERS = 1
  HULLS = 1
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(PROPELLERS, HULLS, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

boat = Motorboat.new(23, 123)
puts boat.range

car = Auto.new
puts car.range

mono = Motorcycle.new
puts mono.range

catamaran = Catamaran.new(2, 2, 12, 75)
puts catamaran.range