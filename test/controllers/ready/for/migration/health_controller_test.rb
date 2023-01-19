require 'test_helper'

class Ready::For::Migration::HealthControllerTest < ActionDispatch::IntegrationTest
  setup do
    Ready::For::Migration::HealthActionInspectable.cache.clear
  end

  def test_readiness
    get '/'
    assert_response :success
  end

  def test_health_action_inspectable_status_and_after_parameters
    get '/?status=503&after=60'
    assert_response :success

    Ready::For::Migration::HealthActionInspectable.cache.write(:first_access_time, 30.seconds.before.to_time)
    get '/?status=503&after=60'
    assert_response :success

    Ready::For::Migration::HealthActionInspectable.cache.write(:first_access_time, 120.seconds.before.to_time)
    get '/?status=503&after=60'
    assert_response 503
  end

  def test_health_action_inspectable_ignored_when_specified_invalid_after_value
    get '/?status=503&after=invalid'
    assert_response :success

    Ready::For::Migration::HealthActionInspectable.cache.write(:first_access_time, 120.seconds.before.to_time)
    get '/?status=503&after=invalid'
    assert_response :success
  end

  def test_health_action_inspectable_status_and_sleep_parameters
    elapsed = measure_elapsed do
      get '/?status=503&sleep=3'
    end
    assert_response 503

    assert_operator elapsed, :>, 3
  end

  def test_health_action_inspectable_ignored_when_specified_invalid_sleep_value
    get '/?status=503&sleep=invalid'
    assert_response 200
  end

  def test_health_action_inspectable_status_and_random_parameters
    Ready::For::Migration::HealthController.any_instance.stubs(:rand).returns(1, 0, 0, 1)

    get '/?status=503&random=2'
    assert_response 200

    get '/?status=503&random=2'
    assert_response 503

    get '/?status=503&random=2'
    assert_response 503

    get '/?status=503&random=2'
    assert_response 200
  end

  def test_health_action_inspectable_ignored_when_specified_invalid_random_value
    Ready::For::Migration::HealthController.any_instance.stubs(:rand).returns(0)
    get '/?status=503&random=invalid'
    assert_response 200
  end

  def test_health_action_inspectable_only_status_parameter
    get '/?status=503'
    assert_response 503

    get '/?status=400'
    assert_response 400

    get '/?status=202'
    assert_response 202

    get '/?status=http'
    assert_response 200
  end

  def test_health_action_inspectable_only_sleep_parameter
    elapsed = measure_elapsed do
      get '/?sleep=3'
    end
    assert_response 200

    assert_operator elapsed, :>, 3
  end

  def test_health_action_inspectable_multiple_parameters
    Ready::For::Migration::HealthController.any_instance.stubs(:rand).returns(1)
    Ready::For::Migration::HealthActionInspectable.cache.write(:first_access_time, 120.seconds.before.to_time)

    elapsed = measure_elapsed do
      get '/?status=503&sleep=3&random=2&after=60'
    end
    assert_response 503

    assert_operator elapsed, :<, 3
  end

  private

    def measure_elapsed
      # see https://techracho.bpsinc.jp/hachi8833/2018_06_01/56612
      starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      yield if block_given?
      ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      ending - starting
    end
end
