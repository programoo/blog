require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "validates email presence" do
    expect(build(:user, email: nil)).not_to be_valid
  end
end
