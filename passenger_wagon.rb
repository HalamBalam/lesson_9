require_relative 'validation'

class PassengerWagon < Wagon
  include Validation

  SIZE_LIMIT_ERROR = 'Недостаточно свободных мест'.freeze
  SIZE_ERROR = 'Общее количество мест должно быть положительным числом'.freeze

  validate :size, :format, /^[1-9]{1}[0-9]*$/, SIZE_ERROR

  alias take_a_seat reserve_space

  def reserve_space(_value = 1)
    super(1)
  end

  def size_limit_error
    SIZE_LIMIT_ERROR
  end
end
