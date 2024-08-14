unless ENV['RFM_ENABLE_LOGGING']

  module Rails
    module Rack
      class Logger

        def call_with_silencer(env)
          if env['PATH_INFO'] == mounted_path
            logger.silence do
              call_without_silencer(env)
            end
          else
            call_without_silencer(env)
          end
        end

        alias_method :call_without_silencer, :call
        alias_method :call, :call_with_silencer

        private

        def mounted_path
          if @_mounted_path.nil?
            @_mounted_path = Ready::For::Migration::Engine.routes.path_for(controller: 'ready/for/migration/health', action: 'readiness')
            @_mounted_path = ActionDispatch::Routing::Mapper.normalize_path(@_mounted_path)
            logger.info "Ready::For::Migration::Engine mounted at #{@_mounted_path}"
          end
          @_mounted_path
        end

      end
    end
  end

end
