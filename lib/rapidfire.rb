require 'rapidfire/engine'
require 'rapidfire/admin_engine'
require 'rapidfire/user_engine'

module Rapidfire
  class AccessDenied < StandardError
  end

  DEFAULT_CONTROLLER_BASE_CLASS = '::ApplicationController'.freeze
  DEFAULT_LAYOUT = nil

  # configuration which will be used as delimiter in case answers are bunch
  # of collection values. This is the default delimiter which is used by
  # all the browsers.
  mattr_accessor :answers_delimiter
  self.answers_delimiter = "\r\n"

  # configuration for setting the layout
  mattr_accessor :layout, default: DEFAULT_LAYOUT

  mattr_accessor :controller_base_class, default: DEFAULT_CONTROLLER_BASE_CLASS

  def self.config
    yield(self)
  end
end
