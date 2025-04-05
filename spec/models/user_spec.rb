# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "ファクトリで作成したデータは有効なユーザーであること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "メールアドレスがなければ無効であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "名前の文字数が2文字の場合無効であること(最小の境界値)" do
    user = FactoryBot.build(:user, name: "hi")
    user.valid?
    expect(user.errors[:name]).to include("は3文字以上で入力してください")
  end

  it "名前の文字数が26文字の場合無効であること(最大の境界値)" do
    user = FactoryBot.build(:user, name: "AmechaYuuchaKonchaKawaiiii")
    user.valid?
    expect(user.errors[:name]).to include("は25文字以内で入力してください")
  end

  it "名前に全角文字を使用した場合無効であること" do
    user = FactoryBot.build(:user, name: "あめちゃん")
    user.valid?
    expect(user.errors[:name]).to include("は不正な値です")
  end

  it "重複したメールアドレスの場合無効であること" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.build(:user, email: user1.email)
    user2.valid?
    expect(user2.errors[:email]).to include("はすでに存在します")
  end
end
