require "test_helper"

class ArmkitTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Armkit::VERSION
  end

  def test_that_template_is_rendered
    assert `ruby ./examples/simple_starting_example.dsl`
  end

end
