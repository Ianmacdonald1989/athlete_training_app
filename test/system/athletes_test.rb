require "application_system_test_case"

class AthletesTest < ApplicationSystemTestCase
  setup do
    @user = users(:alice)
    @athlete = athletes(:one)
  end

  def sign_in
    visit new_session_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password123"
    click_on "Sign in"
  end

  test "visiting the index" do
    sign_in
    visit athletes_url
    assert_selector "h1", text: "Athletes"
  end

  test "should create athlete" do
    sign_in
    visit athletes_url
    click_on "New athlete"

    fill_in "Age", with: @athlete.age
    fill_in "Email", with: @athlete.email
    fill_in "Name", with: @athlete.name
    fill_in "Profile", with: @athlete.profile
    fill_in "Sport definition", with: @athlete.sport_definition
    click_on "Create Athlete"

    assert_text "Athlete was successfully created"
    click_on "Back to athletes"
  end

  test "should update Athlete" do
    sign_in
    visit athlete_url(@athlete)
    click_on "Edit athlete", match: :first

    fill_in "Age", with: @athlete.age
    fill_in "Email", with: @athlete.email
    fill_in "Name", with: @athlete.name
    fill_in "Profile", with: @athlete.profile
    fill_in "Sport definition", with: @athlete.sport_definition
    click_on "Update Athlete"

    assert_text "Athlete was successfully updated"
    click_on "Back to athletes"
  end

  test "should destroy Athlete" do
    sign_in
    visit athlete_url(@athlete)
    accept_confirm do
      click_on "Delete athlete", match: :first
    end

    assert_text "Athlete was successfully destroyed"
  end
end
