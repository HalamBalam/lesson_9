require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations
  attr_accessor :start, :finish

  SAME_STATIONS = 'Начальные и конечные станции не должны совпадать'.freeze

  def initialize(start, finish)
    @stations = [start, finish]
    @start = start
    @finish = finish
    validate!
    raise SAME_STATIONS if start == finish

    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def delete_station(station)
    return if [@stations.first, @stations.last].include?(station)

    @stations.delete(station)
  end

  def description
    start_name = stations.first.name
    finish_name = stations.last.name
    "#{start_name}-#{finish_name}, станций: #{stations.size}"
  end
end

Route.validate(:start, :type, Station, 'Неверный тип начальной станции')
Route.validate(:finish, :type, Station, 'Неверный тип конечной станции')
