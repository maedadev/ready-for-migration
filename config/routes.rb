Ready::For::Migration::Engine.routes.draw do

  get 'healthz', to: 'ready_for_migration/health#readiness'

end
