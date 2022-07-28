require 'test_helper'

class Ready::For::Migration::HealthControllerTest < ActionDispatch::IntegrationTest
  def test_readiness
    get '/'
    assert_response :success
  end
end
