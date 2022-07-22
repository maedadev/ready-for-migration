module ReadyForMigration
  class HealthController < ::ActionController::Base

    def readiness
      if ApplicationRecord.connection.migration_context.needs_migration?
        head 503
      else
        head 200
      end
    end

  end
end