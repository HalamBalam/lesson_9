module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_var_name = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}=".to_sym) do |value|
          old_value = instance_variable_get(var_name)
          instance_variable_set(var_name, value)

          if old_value != value
            instance_variable_set(history_var_name, []) if instance_variable_get(history_var_name).nil?
            history = instance_variable_get(history_var_name)
            history << value
            instance_variable_set(history_var_name, history)
          end
        end

        define_method("#{name}_history".to_sym) { instance_variable_get(history_var_name) || [] }
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Неверный тип переменной' unless value.is_a?(type)

        instance_variable_set(var_name, value)
      end
    end
  end
end
