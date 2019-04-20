require_relative 'validation'

class PassengerTrain < Train
  include Validation

  def attachable_wagon?(wagon)
    return false unless wagon.is_a?(PassengerWagon)

    wagon.train.nil?
  end
end

PassengerTrain.validate(:number, :format, /^[\da-z]{3}-?[\da-z]{2}$/i)
