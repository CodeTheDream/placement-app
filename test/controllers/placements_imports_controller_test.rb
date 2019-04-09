require 'test_helper'

class PlacementsImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get placements_imports_new_url
    assert_response :success
  end

  test "should get create" do
    get placements_imports_create_url
    assert_response :success
  end

end
