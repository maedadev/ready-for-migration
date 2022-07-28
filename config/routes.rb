Ready::For::Migration::Engine.routes.draw do

  root to: 'ready_for_migration/health#readiness'

end
