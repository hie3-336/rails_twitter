# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効なユーザーであること" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end
