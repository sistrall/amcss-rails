$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

ENV["RAILS_ENV"] ||= "test"

require 'rubygems'

require 'bundler/setup'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

require 'combustion'

Combustion.initialize! :action_controller, :action_view

require 'rspec/rails'

require 'amcss/rails'

RSpec.configure do |config|
  config.before(:each) do
    Amcss.configure do |configuration|
      configuration.prefix = nil
    end

    Amcss::Rails::Engine.configure do |engine|
      engine.config.amcss.style = :amcss
      engine.config.amcss.block_element_separator = '__'
    end
  end
end

