require_relative 'route'

module RoutesMenu
  ROUTES_MENU = ['Создать маршрут',
                 'Выбрать маршрут для дальнейших действий'].freeze

  ACTION_WITH_ROUTE_MENU = ['Добавить станцию', 'Удалить станцию'].freeze

  def routes_menu
    loop do
      show_menu(ROUTES_MENU)
      case gets.to_i
      when 0 then break
      when 1 then create_route
      when 2 then choose_route_and_show_menu
      end
    end
  end

  private

  def create_route
    if @stations.size < 2
      puts 'ОШИБКА: Для начала создайте минимум 2 станции'
      return
    end

    puts 'Выберите начальную станцию'
    start = choose_element(@stations)

    puts 'Выберите конечную станцию'
    finish = choose_element(@stations)

    create_route_with_stations(start, finish)
  end

  def choose_route_and_show_menu
    route = choose_element(@routes)
    return unless route

    action_with_route_menu(route)
  end

  def action_with_route_menu(route)
    loop do
      puts "\nВыберите действие с маршрутом \"#{route.description}\""
      show_menu(ACTION_WITH_ROUTE_MENU)

      case gets.to_i
      when 0 then break
      when 1 then add_station(route)
      when 2 then delete_station(route)
      end
    end
  end

  def create_route_with_stations(start, finish)
    return if start == finish

    route = Route.new(start, finish)
    puts "Создан маршрут: \"#{route.description}\""
    @routes << route
  end

  def add_station(route)
    puts 'Выберите добавляемую станцию'
    station = choose_element(@stations)

    route.add_station(station) unless station.nil?
  end

  def delete_station(route)
    if route.stations.size < 3
      puts 'ОШИБКА: У маршрута должно быть больше двух станций'
      return
    end

    puts 'Выберите удаляемую станцию'
    station = choose_element(route.stations[1, route.stations.size - 2])

    route.delete_station(station) unless station.nil?
  end
end
