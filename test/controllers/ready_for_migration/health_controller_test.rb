require 'test_helper'

class ReadyForMigration::HealthControllerTest < ActionDispatch::IntegrationTest
  def test_トップ
    get '/healthz'
    assert_response :success
  end
end
