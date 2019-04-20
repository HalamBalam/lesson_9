require_relative 'action_with_train_menu'
require_relative 'new_train'
require_relative 'new_wagon'

module TrainsMenu
  include ActionWithTrainMenu
  include NewTrain
  include NewWagon

  TRAINS_MENU = ['Создать поезд',
                 'Создать вагон',
                 'Выбрать поезд для дальнейших действий',
                 'Занять место (объем) в вагоне'].freeze

  def trains_menu
    loop do
      show_menu(TRAINS_MENU)
      case gets.to_i
      when 0 then break
      when 1 then create_train
      when 2 then create_wagon
      when 3 then action_with_train
      when 4 then action_with_wagon
      end
    end
  end

  protected

  def action_with_train
    train = choose_element(@trains)
    action_with_train_menu(train) if train
  end

  def action_with_wagon
    wagon = choose_element(@wagons)
    return unless wagon

    fill_space_in_wagon(wagon)

    puts wagon.description
  end

  def fill_space_in_wagon(wagon)
    loop do
      result = if wagon.is_a?(CargoWagon)
                 fill_space_in_cargo_wagon?(wagon)
               else
                 fill_space_in_passenger_wagon?(wagon)
               end
      break if result
    end
  end

  def fill_space_in_cargo_wagon?(wagon)
    puts 'Введите занимаемый объем'
    volume = gets.to_i
    begin
      wagon.fill_space(volume)
      true
    rescue StandardError
      puts "ОШИБКА: \"#{e.message}\""
      false
    end
  end

  def fill_space_in_passenger_wagon?(wagon)
    puts 'Введите занимаемое количество мест'
    number_of_seats = gets.to_i
    begin
      number_of_seats.times { wagon.take_a_seat }
      true
    rescue StandardError
      puts "ОШИБКА: \"#{e.message}\""
      false
    end
  end
end
