module Ready
  module For
    module Migration
      class HealthController < ::ActionController::Base
        prepend HealthActionInspectable

        def readiness
          if ApplicationRecord.connection.migration_context.needs_migration?
            head 503
          else
            head 200
          end
        end

      end
    end
  end
end
