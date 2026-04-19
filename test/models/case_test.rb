require 'test_helper'

class CaseTest < ActiveSupport::TestCase
  test "is valid with number and defendant" do
    assert cases(:decided_active).valid?
  end

  test "requires a number" do
    record = cases(:decided_active)
    record.number = nil
    assert_not record.valid?
    assert_includes record.errors[:number], "can't be blank"
  end

  test "search matches by case number" do
    results = Case.search("21 PB 1001")
    assert_includes results, cases(:decided_active)
    assert_not_includes results, cases(:pending_active)
  end

  test "search matches by defendant last name" do
    results = Case.search("doe")
    assert_includes results, cases(:decided_active)
  end

  test "search excludes inactive cases" do
    results = Case.search("20 PB 0500")
    assert_not_includes results, cases(:inactive_hidden)
  end
end
