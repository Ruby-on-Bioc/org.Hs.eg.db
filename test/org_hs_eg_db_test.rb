# frozen_string_literal: true

require 'test_helper'

class OrgHsEgDbTest < Test::Unit::TestCase
  test 'OrgHsEgDb is ready' do
    assert_equal(Sequel::SQLite::Database, OrgHsEgDb.class)
  end
end
