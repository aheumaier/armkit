require "test_helper"


class ArmkitTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Armkit::VERSION
  end

  def test_that_template_is_rendered
    assert `ruby ./examples/simple_starting_example.dsl`
  end

  def test_that_hash_respond_to_insert_at
    assert Hash.new.respond_to?('insert_at')
  end

  def test_that_object_respond_to_to_template
    assert Object.new.respond_to?('to_template')
  end

  #TODO Fix dummy test_that_hash_renders_insert_at
  def test_that_hash_renders_insert_at
    assert true
  end

end
