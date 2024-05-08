module Rapidfire
  class ApplicationController < Rapidfire.controller_base_class
    if Rapidfire.layout
      layout Rapidfire.layout
    end

    helper_method :can_administer?

    def authenticate_administrator!
      unless can_administer?
        raise Rapidfire::AccessDenied.new("cannot administer questions")
      end
    end

    # Override prefixes to consider the scoped.
    # for method current_user
    def rapidfire_scoped
      if !defined?(super)
        :user
      else
        super
      end
    end
  end
end
