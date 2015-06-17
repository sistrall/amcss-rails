module Amcss::Rails
  class Engine < ::Rails::Engine
    isolate_namespace Amcss::Rails

    config.amcss = ActiveSupport::OrderedOptions.new
    config.amcss.style = :bem

    initializer 'amcss-rails.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        ### (§)
        #
        # Makes all helpers to be avaiblable in the main app.
        #
        # See: http://stackoverflow.com/a/9641149
        #
        helper Amcss::Rails::ApplicationHelper
      end
    end
  end
end

