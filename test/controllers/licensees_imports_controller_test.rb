require 'test_helper'

class LicenseesImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get licensees_imports_new_url
    assert_response :success
  end

  test "should get create" do
    get licensees_imports_create_url
    assert_response :success
  end

end
