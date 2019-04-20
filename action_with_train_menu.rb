require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

module ActionWithTrainMenu
  ACTION_WITH_TRAIN_MENU = ['Действия с составом',
                            'Действия с маршрутом'].freeze

  ACTION_WITH_TRAIN_WAGONS_MENU = ['Прицепить вагон',
                                   'Отцепить вагон',
                                   'Посмотреть состав'].freeze
  ACTION_WITH_TRAIN_ROUTE_MENU = ['Назначить маршрут',
                                  'Отправиться на следующую станцию',
                                  'Вернуться на предыдущую станцию'].freeze

  def action_with_train_menu(train)
    loop do
      puts "\nВыберите раздел действий с поездом \"#{train.description}\""
      show_menu(ACTION_WITH_TRAIN_MENU)

      case gets.to_i
      when 0 then break
      when 1 then action_with_train_wagons_menu(train)
      when 2 then action_with_train_route_menu(train)
      end
    end
  end

  private

  def action_with_train_wagons_menu(train)
    loop do
      puts "\nВыберите действие с составом поезда \"#{train.description}\""
      show_menu(ACTION_WITH_TRAIN_WAGONS_MENU)

      case gets.to_i
      when 0 then break
      when 1 then attach_wagon(train)
      when 2 then detach_wagon(train)
      when 3 then show_wagons(train)
      end
    end
  end

  def action_with_train_route_menu(train)
    loop do
      puts "\nВыберите действие с маршрутом поезда \"#{train.description}\""
      show_menu(ACTION_WITH_TRAIN_ROUTE_MENU)

      case gets.to_i
      when 0 then break
      when 1 then assign_route(train)
      when 2 then train.go_forward
      when 3 then train.go_back
      end
    end
  end

  def attach_wagon(train)
    wagon_class = train.is_a?(CargoTrain) ? CargoWagon : PassengerWagon
    wagon = choose_element(
      @wagons.select { |item| item.train.nil? && item.is_a?(wagon_class) }
    )
    return unless wagon

    train.attach_wagon(wagon)
    puts train.description
  end

  def detach_wagon(train)
    wagon = choose_element(train.wagons)
    return unless wagon

    train.detach_wagon(wagon)
    puts train.description
  end

  def show_wagons(train)
    puts 'Состав:'
    train.wagons.each do |wagon|
      puts "  #{wagon.description}"
    end
  end

  def assign_route(train)
    if @routes.empty?
      puts 'ОШИБКА: Для начала создайте маршрут'
      return
    end

    puts 'Выберите маршрут'
    route = choose_element(@routes)
    train.assign_route(route)
  end
end
