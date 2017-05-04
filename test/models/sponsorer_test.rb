require "test_helper"

class SponsorerTest < ActiveSupport::TestCase
  test "must save a new sponsorer with all params" do
    assert_difference 'Sponsorer.count' do
      sponsorer = create(:sponsorer)
    end
  end

  test "email address must be present" do
    sponsorer = build(:sponsorer,:email => nil)
    sponsorer.valid?
    assert_not_empty sponsorer.errors[:email]
  end

  test "name must be present" do
    sponsorer = build(:sponsorer,:name => nil)
    sponsorer.valid?
    assert_not_empty sponsorer.errors[:name]
  end

  test "sponsorer can make one time payment" do
  end

  test "sponsorer can make recurring payments on monthly basis" do
  end

  test "sponsorer can make payments per repository" do
  end
end
