require 'test_helper'

class CaretakerTest < ActiveSupport::TestCase
  test "can string" do
    matt = caretakers(:matt)
    assert matt.to_s == "Matthew Hummer"
  end
end
