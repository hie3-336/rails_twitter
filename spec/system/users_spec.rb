# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }

  # ログイン(正常系)
  it '正常にログインする' do
    visit new_user_session_path
    fill_in 'メール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  # ログイン(異常系)
  it 'パスワードが間違っているためログインに失敗する' do
    visit new_user_session_path
    fill_in 'メール', with: user.email
    fill_in 'パスワード', with: 'wrongpassword'
    click_button 'ログイン'
    expect(page).to have_content 'Eメールまたはパスワードが違います。'
  end

  # サインアップ(正常系)
  it '正常にサインアップする' do
    visit new_user_registration_path
    fill_in '名前', with: 'newuser'
    fill_in 'メール', with: 'newuser@test.com'
    fill_in '電話番号', with: '08000000000'
    fill_in '生年月日', with: '2024-10-10'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード(確認)', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content '本人確認用のメールを送信しました。'
  end

  # サインアップ(異常系)
  it 'メールアドレスが重複しているためサインアップに失敗する' do
    visit new_user_registration_path
    fill_in '名前', with: 'newuser'
    fill_in 'メール', with: user.email
    fill_in '電話番号', with: '08000000000'
    fill_in '生年月日', with: '2024-10-10'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード(確認)', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Eメールはすでに存在します'
  end
end
