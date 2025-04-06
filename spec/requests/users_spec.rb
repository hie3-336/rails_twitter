# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # ログインのテスト
  describe 'POST /users/sign_in' do
    let(:user) { FactoryBot.create(:user) }

    # ログイン(正常系)
    context '正しいメールアドレス・パスワードの時' do
      before do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
      end

      it 'ログインに成功すること' do
        expect(response).to redirect_to(root_path(tab: 'recommend'))
        follow_redirect!
        expect(response.body).to include('ログインしました')
      end
    end

    # ログイン(異常系)
    context 'メールアドレスが間違っている時' do
      before do
        post user_session_path, params: { user: { email: user.email, password: 'wrongpassword' } }
      end

      it 'ログインに失敗すること' do
        expect(response.body).to include('Eメールまたはパスワードが違います。')
      end
    end
  end

  # サインアップのテスト
  describe 'POST /users' do
    # サインアップ(正常系)
    context 'ユーザー登録に必要な情報が全て揃っている時' do
      before do
        post user_registration_path, params: { user: {
          name: 'newuser',
          email: 'newuser@test.com',
          phone_number: '08000000000',
          birthday: '2024-10-10',
          password: 'password',
          password_confirmation: 'password'
        } }
      end

      it 'サインアップに成功すること' do
        expect(response).to redirect_to(root_path(tab: 'recommend'))
        follow_redirect!
        expect(response.body).to include('本人確認用のメールを送信しました。')
      end
    end
  end

  # サインアップ(異常系)
  context 'ユーザー登録の際、メールアドレスが重複した場合' do
    let(:old_user) { FactoryBot.create(:user) }

    before do
      post user_registration_path, params: { user: {
        name: 'newuser',
        email: old_user.email,
        phone_number: '08000000000',
        birthday: '2024-10-10',
        password: 'password',
        password_confirmation: 'password'
      } }
    end

    it 'サインアップに失敗すること' do
      expect(response.body).to include('Eメールはすでに存在します')
    end
  end
end
