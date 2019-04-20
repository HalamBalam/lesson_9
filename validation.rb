module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validations=(value)
      @validations = value
    end

    def validate(name, validation_type, *args)
      cur_validations = validations
      cur_validations << { name: name,
                           validation_type: validation_type,
                           args: args }
      @validations = cur_validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation_type = validation[:validation_type]
        if validation_type == :presence
          check_presence(validation[:name], validation[:args])
        elsif validation_type == :format
          check_format(validation[:name], validation[:args])
        elsif validation_type == :type
          check_type(validation[:name], validation[:args])
        end
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def check_presence(name, args)
      text_error = args[0] || "Не заполнено значение атрибута \'#{name}\'"
      raise text_error if send(name).nil? || send(name) == ''
    end

    def check_format(name, args)
      text_error = args[1] || "Значение атрибута \'#{name}\' не соответствует формату"
      raise text_error if send(name).to_s !~ args[0]
    end

    def check_type(name, args)
      text_error = args[1] || "Значение атрибута \'#{name}\' не соответствует классу \'#{type}\'"
      raise text_error unless send(name).is_a?(args[0])
    end
  end
end
