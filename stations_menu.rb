require_relative 'station'

module StationsMenu
  STATIONS_MENU = ['Создать станцию',
                   'Показать поезда на станции',
                   'Показать поезда с вагонами на станции'].freeze

  def stations_menu
    loop do
      show_menu(STATIONS_MENU)
      case gets.to_i
      when 0 then break
      when 1 then create_station
      when 2 then show_station_trains_without_wagons
      when 3 then show_station_trains_with_wagons
      end
    end
  end

  private

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    station = Station.new(name)
    puts "Создана станция: \"#{station.description}\""
    @stations << station
  end

  def show_station_trains_without_wagons
    station = choose_station_with_trains
    return unless station

    show_collection(station.trains)
  end

  def show_station_trains_with_wagons
    station = choose_station_with_trains
    return unless station

    puts "Поезда на станции \"#{station.description}\":"
    station.trains.each.with_index(1) do |train, index|
      puts "#{index}-\"#{train.description}\""
      show_wagons(train)
    end
  end

  def choose_station_with_trains
    station = choose_element(@stations)
    return unless station

    if station.trains.empty?
      puts "На станции \"#{station.description}\" нет поездов"
      return
    end

    station
  end
end
