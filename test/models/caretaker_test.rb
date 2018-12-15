require 'test_helper'

class CaretakerTest < ActiveSupport::TestCase
  test "can be converted to string" do
    matt = caretakers(:matt)
    assert matt.to_s == "Matthew Hummer"
  end

  test "should have ability to return time zone" do
    matt = caretakers(:matt)
    assert matt.timezone == "Mountain Time (US & Canada)"
  end

  test "can determine UTC offset" do
    matt = caretakers(:matt)
    assert matt.utc_offset == -7
  end
end
