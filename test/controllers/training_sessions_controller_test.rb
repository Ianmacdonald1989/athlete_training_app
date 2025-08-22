require "test_helper"

class TrainingSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get training_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get training_sessions_create_url
    assert_response :success
  end
end
