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
      validations << {
        name: name,
        validation_type: validation_type,
        args: args
      }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation_type = validation[:validation_type]
        checked_attr = validation[:name]
        method_name = "check_#{validation_type}".to_sym
        send method_name, checked_attr.to_s, send(checked_attr), validation[:args]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def check_presence(attr_name, value, args)
      text_error = args[0] || "Не заполнено значение атрибута \'#{attr_name}\'"
      raise text_error if value.nil? || value == ''
    end

    def check_format(attr_name, value, args)
      text_error = args[1] || "Значение атрибута \'#{attr_name}\' не соответствует формату"
      raise text_error if value.to_s !~ args[0]
    end

    def check_type(attr_name, value, args)
      type = args[0]
      text_error = args[1] || "Значение атрибута \'#{attr_name}\' не соответствует классу \'#{type}\'"
      raise text_error unless value.is_a?(args[0])
    end
  end
end
