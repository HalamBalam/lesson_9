require_relative 'validation'

class CargoTrain < Train
  include Validation

  NUMBER_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i.freeze

  validate :number, :format, NUMBER_FORMAT

  def attachable_wagon?(wagon)
    return false unless wagon.is_a?(CargoWagon)

    wagon.train.nil?
  end
end
