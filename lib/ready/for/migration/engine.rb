module Ready
  module For
    module Migration
      class Engine < ::Rails::Engine

        initializer 'ready-for-migration.initialize_cache' do
          require config.root.join('app/controllers/concerns/ready/for/migration/health_action_inspectable')
          Ready::For::Migration::HealthActionInspectable.cache.write(:first_access_time, Time.now)
        end
      end
    end
  end
end
