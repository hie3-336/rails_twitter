# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context "ファクトリで作成したデータを使用する時" do
    it "有効なユーザーであること" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  context "メールアドレスが無い場合" do
    let(:user) { FactoryBot.build(:user, email: nil) }
    it "メールアドレスがなければ無効であること" do
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
  end

  context "名前の文字数が2文字の場合(最小の境界値)" do
    let(:user) { FactoryBot.build(:user, name: "hi") }
    it "無効であること" do
      user.valid?
      expect(user.errors[:name]).to include("は3文字以上で入力してください")
    end
  end

  context "名前の文字数が26文字の場合(最大の境界値)" do
    let(:user) { FactoryBot.build(:user, name: "AmechaYuuchaKonchaKawaiiii") }
    it "無効であること" do
      user.valid?
      expect(user.errors[:name]).to include("は25文字以内で入力してください")
    end
  end

  context "名前に全角文字を使用した場合" do
    let(:user) { FactoryBot.build(:user, name: "あめちゃん") }
    it "無効であること" do
      user.valid?
      expect(user.errors[:name]).to include("は不正な値です")
    end
  end

  context "重複したメールアドレスを使用した場合" do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.build(:user, email: user1.email) }
    it "重複したメールアドレスの場合無効であること" do
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end
  end
end
