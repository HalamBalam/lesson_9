require_relative 'stations_menu'
require_relative 'trains_menu'
require_relative 'routes_menu'

class Main
  include StationsMenu
  include TrainsMenu
  include RoutesMenu

  MAIN_MENU = %w[Станции Поезда Маршруты].freeze

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def run
    loop do
      show_menu(MAIN_MENU)

      case gets.to_i
      when 0 then break
      when 1 then stations_menu
      when 2 then trains_menu
      when 3 then routes_menu
      end
    end
  end

  protected

  def show_menu(menu, show_exit = true)
    puts
    menu.each.with_index(1) do |item, index|
      puts "#{index}-#{item}"
    end
    puts '0-Выход' if show_exit
  end

  def show_collection(elements)
    elements.each.with_index(1) do |element, index|
      puts "#{index}-\"#{element.description}\""
    end
  end

  def choose_element(elements)
    return if elements.empty?

    loop do
      show_collection(elements)

      index = gets.chomp.to_i - 1
      return elements[index] if index >= 0 && !elements[index].nil?
    end
  end
end

main = Main.new
main.run
