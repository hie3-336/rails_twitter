# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it "有効なツイートであること" do
    expect(FactoryBot.build(:tweet)).to be_valid
  end
end
