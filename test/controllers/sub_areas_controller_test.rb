require 'test_helper'

class SubAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_area = sub_areas(:one)
  end

  test "should get index" do
    get sub_areas_url, as: :json
    assert_response :success
  end

  test "should create sub_area" do
    assert_difference('SubArea.count') do
      post sub_areas_url, params: { sub_area: { area_id: @sub_area.area_id, name: @sub_area.name, sub_area_id: @sub_area.sub_area_id } }, as: :json
    end

    assert_response 201
  end

  test "should show sub_area" do
    get sub_area_url(@sub_area), as: :json
    assert_response :success
  end

  test "should update sub_area" do
    patch sub_area_url(@sub_area), params: { sub_area: { area_id: @sub_area.area_id, name: @sub_area.name, sub_area_id: @sub_area.sub_area_id } }, as: :json
    assert_response 200
  end

  test "should destroy sub_area" do
    assert_difference('SubArea.count', -1) do
      delete sub_area_url(@sub_area), as: :json
    end

    assert_response 204
  end
end
