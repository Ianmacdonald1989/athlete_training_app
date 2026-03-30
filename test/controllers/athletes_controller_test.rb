require "test_helper"

class AthletesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @athlete = athletes(:one)
  end

  test "should get index" do
    get athletes_url
    assert_response :success
  end

  test "should get new" do
    get new_athlete_url
    assert_response :success
  end

  test "should create athlete" do
    assert_difference("Athlete.count") do
      post athletes_url, params: { athlete: { age: @athlete.age, email: @athlete.email, name: @athlete.name, profile: @athlete.profile, sport_definition: @athlete.sport_definition } }
    end

    assert_redirected_to athlete_url(Athlete.last)
  end

  test "should show athlete" do
    get athlete_url(@athlete)
    assert_response :success
  end

  test "should get edit" do
    get edit_athlete_url(@athlete)
    assert_response :success
  end

  test "should update athlete" do
    patch athlete_url(@athlete), params: { athlete: { age: @athlete.age, email: @athlete.email, name: @athlete.name, profile: @athlete.profile, sport_definition: @athlete.sport_definition } }
    assert_redirected_to athlete_url(@athlete)
  end

  test "should destroy athlete" do
    assert_difference("Athlete.count", -1) do
      delete athlete_url(@athlete)
    end

    assert_redirected_to athletes_url
  end

  test "should get stats" do
    get stats_athlete_url(@athlete)
    assert_response :success
  end

  test "stats should reflect training sessions" do
    TrainingSession.create!(
      athlete: @athlete,
      date: Date.new(2025, 8, 22),
      start_time: Time.zone.parse("2025-08-22 10:00:00"),
      finish_time: Time.zone.parse("2025-08-22 11:00:00"),
      average_speed: 8,
      total_distance: 3.0
    )

    TrainingSession.create!(
      athlete: @athlete,
      date: Date.new(2025, 8, 23),
      start_time: Time.zone.parse("2025-08-23 10:00:00"),
      finish_time: Time.zone.parse("2025-08-23 11:00:00"),
      average_speed: 12,
      total_distance: 5.0
    )

    get stats_athlete_url(@athlete)
    assert_response :success

    assert_includes @response.body, "Total Distance"
    assert_includes @response.body, "9.5 km"
    assert_includes @response.body, "Average Speed"
    assert_includes @response.body, "10.0 km/h"
  end
end
