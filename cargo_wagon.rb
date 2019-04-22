require_relative 'validation'

class CargoWagon < Wagon
  include Validation

  SIZE_LIMIT_ERROR = 'Занимаемый объем превышает свободный'.freeze
  SIZE_ERROR = 'Объем должен быть положительным числом'.freeze

  validate :size, :format, /^[1-9]{1}[0-9]*$/, SIZE_ERROR

  alias fill_space reserve_space

  def size_limit_error
    SIZE_LIMIT_ERROR
  end
end
