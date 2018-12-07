require "peatio/plugin/api/version"

module Peatio
  module Plugin
    module Api
      class Engine < Rails::Engine
        isolate_namespace Api
        # Mount new API resource in hook (friendly with development environment).
        # More about configuration stages: http://guides.rubyonrails.org/configuring.html#configuring-action-dispatch
        config.to_prepare do
          APIv2::Mount.mount APIv2::CustomTrades
        end
      end
    end
  end
end
