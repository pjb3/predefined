require 'test_helper'

class QueryTest < Minitest::Test
  def test_template
    query = Predefined::Query.new("users/find_by_status")
    assert_equal "SELECT username, first_name, last_name, email FROM users WHERE status = :status",
      query.template
  end
end
