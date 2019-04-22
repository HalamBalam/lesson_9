require_relative 'manufacturer'
require_relative 'accessors'
require_relative 'train'

class Wagon
  include Manufacturer
  include Accessors

  attr_reader :size, :reserved_space

  strong_attr_accessor :train, Train

  def initialize(size)
    @size = size
    @reserved_space = 0
    validate!
  end

  def available_space
    size - reserved_space
  end

  def description
    number_text = wagon_number.nil? ? '' : "№ #{wagon_number} "

    if is_a?(PassengerWagon)
      "Пассажирский вагон #{number_text}на #{size} мест
      (свободно: #{available_space}, занято: #{reserved_space})"
    else
      "Грузовой вагон #{number_text}объемом #{size} кв.м.
      (свободно: #{available_space}, занято: #{reserved_space})"
    end
  end

  def wagon_number
    return if train.nil?

    wagon_index = train.wagons.index(self)
    return if wagon_index.nil?

    train.number + '-' + wagon_index.to_s
  end

  def reserve_space(delta)
    raise size_limit_error if delta > available_space

    @reserved_space += delta
  end
end
