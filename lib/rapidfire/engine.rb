require 'active_model_serializers'

module Rapidfire
  class Engine < ::Rails::Engine
    isolate_namespace Rapidfire

    config.rapidfire = ActiveSupport::OrderedOptions.new
    config.rapidfire.send(:"#{engine_name}=", ActiveSupport::OrderedOptions.new)

    initializer "#{engine_name}.classes" do
      config.after_initialize do |app|
        Rapidfire.controller_base_class = (
          app.config.rapidfire.send(:"#{engine_name}").controller_base_class ||
          app.config.rapidfire.controller_base_class ||
          Rapidfire::DEFAULT_CONTROLLER_BASE_CLASS
        ).constantize
      end
    end

    initializer "#{engine_name}.layout" do
      config.after_initialize do |app|
        Rapidfire.layout = (
          app.config.rapidfire.send(:"#{engine_name}").layout ||
          app.config.rapidfire.layout ||
          Rapidfire::DEFAULT_LAYOUT
        )
      end
    end

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
