require "test_helper"

class TrainingSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @athlete = athletes(:one)
  end

  test "should get new" do
    get new_athlete_training_session_url(@athlete)
    assert_response :success
  end

  test "should create training session" do
    assert_difference("TrainingSession.count", 1) do
      post athlete_training_sessions_url(@athlete), params: {
        training_session: {
          date: Date.new(2025, 8, 22),
          start_time: Time.zone.parse("2025-08-22 16:00:00"),
          finish_time: Time.zone.parse("2025-08-22 17:00:00"),
          average_speed: 11,
          total_distance: 5.25
        }
      }
    end

    assert_redirected_to athlete_url(@athlete)
  end
end
