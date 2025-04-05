# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'POST /tweet' do
    context "ユーザーがサインインしている状況で" do
      context "正しい内容のツイートの時" do
        before do
          user = FactoryBot.create(:user)
          sign_in user
          post tweets_path, params: { tweet: { content: "testのツイートです"} } # 問題の箇所
        end
        it "ツイート投稿に成功すること" do
          expect(response).to redirect_to(root_path(tab: 'recommend'))
          follow_redirect!
          expect(response.body).to include("ツイートを投稿しました")
        end
      end
    end
  end
end
