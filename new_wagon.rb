require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

module NewWagon
  TRAIN_TYPES_MENU = %w[Грузовой Пассажирский].freeze

  def create_wagon
    loop do
      show_menu(TRAIN_TYPES_MENU, false)
      wagon_type = gets.chomp.to_i

      next unless [1, 2].include?(wagon_type)

      puts 'Введите объем вагона' if wagon_type == 1
      puts 'Введите общее количество мест' if wagon_type == 2

      wagon_size = gets.to_i

      break if create_wagon_with_options?(wagon_type, wagon_size)
    end
  end

  def create_wagon_with_options?(wagon_type, wagon_size)
    wagon = if wagon_type == 1
              CargoWagon.new(wagon_size)
            else
              PassengerWagon.new(wagon_size)
            end

    puts "Создан вагон: \"#{wagon.description}\""
    @wagons << wagon
    true
  end
end
