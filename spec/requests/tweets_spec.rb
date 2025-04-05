# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'POST /tweets' do
    context "ユーザーがサインインしている状況で、正しい内容のツイートの時" do
      before do
        user = FactoryBot.create(:user)
        sign_in user
        post tweets_path, params: { tweet: { content: "testのツイートです"} }
      end
      it "ツイート投稿に成功すること" do
        expect(response).to redirect_to(root_path(tab: 'recommend'))
        follow_redirect!
        expect(response.body).to include("ツイートを投稿しました")
      end
    end
  end
end
