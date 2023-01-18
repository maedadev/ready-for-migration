module Ready
  module For
    module Migration
      class Engine < ::Rails::Engine

        initializer 'ready-for-migration.initialize_cache' do
          # When lanched as server, clear cache.
          if defined? Rails::Server || defined? PhusionPassenger
            Ready::For::Migration::HealthActionInspectable.cache.clear
          end
        end
      end
    end
  end
end
