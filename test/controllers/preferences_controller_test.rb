require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @preference = preferences(:one)
  end

  test "should get index" do
    get preferences_url, as: :json
    assert_response :success
  end

  test "should create preference" do
    assert_difference('Preference.count') do
      post preferences_url, params: { preference: { content: @preference.content, creator_id: @preference.creator_id, sub_area_id: @preference.sub_area_id } }, as: :json
    end

    assert_response 201
  end

  test "should show preference" do
    get preference_url(@preference), as: :json
    assert_response :success
  end

  test "should update preference" do
    patch preference_url(@preference), params: { preference: { content: @preference.content, creator_id: @preference.creator_id, sub_area_id: @preference.sub_area_id } }, as: :json
    assert_response 200
  end

  test "should destroy preference" do
    assert_difference('Preference.count', -1) do
      delete preference_url(@preference), as: :json
    end

    assert_response 204
  end
end
