# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :system do
  let(:user) { FactoryBot.create(:user) }

  # ツイート投稿(正常系)
  it '正常にツイートを投稿する' do
    visit new_user_session_path
    fill_in 'メール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    fill_in 'tweet_field', with: 'testのツイートです'
    click_button 'ツイートする'

    expect(page).to have_content 'ツイートを投稿しました'
  end

  # ツイート投稿(異常系)
  it 'ツイートが空白のため投稿に失敗する' do
    visit new_user_session_path
    fill_in 'メール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    fill_in 'tweet_field', with: nil
    click_button 'ツイートする'

    expect(page).to have_content 'ツイートは1文字以上で入力してください'
  end
end
