require 'test_helper'

class ReadyForMigration::HealthControllerTest < ActionDispatch::IntegrationTest
  def test_readiness
    get '/healthz'
    assert_response :success
  end
end
