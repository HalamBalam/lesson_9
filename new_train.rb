require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'

module NewTrain
  TRAIN_TYPES_MENU = %w[Грузовой Пассажирский].freeze

  def create_train
    loop do
      show_menu(TRAIN_TYPES_MENU, false)
      train_type = gets.chomp.to_i

      next unless [1, 2].include?(train_type)

      puts 'Введите номер поезда'
      train_number = gets.chomp
      break if create_train_with_options?(train_type, train_number)
    end
  end

  def create_train_with_options?(train_type, train_number)
    train = create_train_with_options(train_type, train_number)
    return false if train.nil?

    puts "Создан поезд: \"#{train.description}\""
    @trains << train
    true
  end

  def create_train_with_options(train_type, train_number)
    if train_type == 1
      CargoTrain.new(train_number)
    else
      PassengerTrain.new(train_number)
    end
  rescue RuntimeError => e
    puts "ОШИБКА: \"#{e.message}\""
    puts 'Введите данные повторно'
  end
end
