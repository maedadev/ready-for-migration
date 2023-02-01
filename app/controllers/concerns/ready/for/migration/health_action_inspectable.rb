require 'active_support/cache/file_store'

module Ready
  module For
    module Migration
      module HealthActionInspectable

        def self.cache
          @cache ||= ActiveSupport::Cache::MemoryStore.new
        end

        def self.sleep_enabled?
          return false if ENV['RFM_ENABLE_SLEEP'].nil?
          b = [ false, 0,
                "0", :"0",
                "f", :f,
                "F", :F,
                "false", :false,
                "FALSE", :FALSE,
                "off", :off,
                "OFF", :OFF,
              ].include?(ENV['RFM_ENABLE_SLEEP'])
          return !b
        end

        def readiness
          if params.has_key?(:status)
            case
            when params.has_key?(:after)
              perform_inspection_with_status_and_after
            when params.has_key?(:sleep)
              perform_inspection_with_status_and_sleep
            when params.has_key?(:random)
              perform_inspection_with_status_and_random
            else
              perform_inspection_with_status
            end
          elsif params.has_key?(:sleep)
            perform_inspection_with_sleep
          end

          super unless performed?
        end

        private

          def get_status_value
            raw = params.dig(:status)
            status = raw.to_i if raw && /^\d{3}$/.match?(raw)
            status
          end

          def get_after_value
            raw = params.dig(:after)
            value = raw.to_i if raw && /^\d+$/.match?(raw)
            value
          end

          def get_random_value
            raw = params.dig(:random)
            value = raw.to_i if raw && /^\d+$/.match?(raw)
            value
          end

          def get_sleep_value
            raw = params.dig(:sleep)
            value = raw.to_i if raw && /^\d+$/.match?(raw)
            value
          end

          def perform_inspection_with_status_and_after
            return unless status = get_status_value
            return unless value = get_after_value

            first_access_time = Ready::For::Migration::HealthActionInspectable.cache.fetch(:first_access_time) { Time.now }
            if first_access_time + value < Time.now
              head status
            end
          end

          def perform_inspection_with_status_and_sleep
            return unless status = get_status_value
            return unless value = get_sleep_value

            sleep(value) if Ready::For::Migration::HealthActionInspectable.sleep_enabled?
            head status
          end

          def perform_inspection_with_status_and_random
            return unless status = get_status_value
            return unless value = get_random_value

            if value == 1 || rand(value - 1) == 0
              head status
            end
          end

          def perform_inspection_with_status
            return unless status = get_status_value
            head status
          end

          def perform_inspection_with_sleep
            return unless value = get_sleep_value

            sleep(value) if Ready::For::Migration::HealthActionInspectable.sleep_enabled?
          end

      end
    end
  end
end
