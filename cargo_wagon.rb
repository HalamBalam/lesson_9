require_relative 'validation'

class CargoWagon < Wagon
  include Validation

  SIZE_LIMIT_ERROR = 'Занимаемый объем превышает свободный'.freeze

  alias fill_space reserve_space

  def size_limit_error
    SIZE_LIMIT_ERROR
  end
end

size_error = 'Объем должен быть положительным числом'

CargoWagon.validate(:size, :format, /^[1-9]{1}[0-9]*$/, size_error)
