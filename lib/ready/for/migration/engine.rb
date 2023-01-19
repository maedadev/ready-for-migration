module Ready
  module For
    module Migration
      class Engine < ::Rails::Engine

        initializer 'ready-for-migration.initialize_cache' do
          Ready::For::Migration::HealthActionInspectable.cache.write(:first_access_time, Time.now)
        end
      end
    end
  end
end
