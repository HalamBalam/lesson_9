require_relative 'validation'

class CargoTrain < Train
  include Validation

  def attachable_wagon?(wagon)
    return false unless wagon.is_a?(CargoWagon)

    wagon.train.nil?
  end
end

CargoTrain.validate(:number, :format, /^[\da-z]{3}-?[\da-z]{2}$/i)
