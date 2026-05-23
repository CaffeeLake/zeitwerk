# frozen_string_literal: true

require 'test_helper'

class TestConstantPathValidator < LoaderTest
  def setup
    @cpv = Zeitwerk::Loader::ConstantPathValidator.new
  end

  test 'valid constant names return themselves, with leading :: removed if present' do
    assert_equal 'Foo',           @cpv.validate!('Foo')
    assert_equal 'Foo',           @cpv.validate!('::Foo')
    assert_equal 'Foo::Bar::Baz', @cpv.validate!('Foo::Bar::Baz')
    assert_equal 'Foo::Bar::Baz', @cpv.validate!('::Foo::Bar::Baz')
  end

  test 'invalid constant names raise NameError' do
    ['', 'foo', ':Foo', 'Foo:Bar', '#$%'].each do |invalid_cpath|
      error = assert_raises(NameError) { @cpv.validate!(invalid_cpath) }
      assert_equal "wrong constant name #{invalid_cpath}", error.message
    end
  end
end
