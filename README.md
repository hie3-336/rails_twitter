# README

Railsにより作成したXを模倣したwebアプリです。

# 本番環境

https://floating-springs-01753-38230b9c7601.herokuapp.com/

## 実装の特徴
- Rails 7.0.6 で開発 
- 画像保存はActiveStorageを使用 保存先はAWS S3 
- Herokuでデプロイ
- RSpecを導入しいくつか自動テストを実装
- 現役エンジニアの方にPRを依頼しながら制作しました

## 機能特徴
- deviseによるユーザー管理、フォロー、フォロー解除等
- 画像つきツイート投稿、ツイートへのコメント
- いいね/RT/ブックマーク/DM
- メール配信付きの通知機能

## ER図
![Image](https://github.com/user-attachments/assets/dfda7d80-065c-42bd-84d9-a9db00426a22)

## 関連技術記事
- [通知機能にポリモーフィック関連を導入](https://qiita.com/hie3/items/da83f5a9856f1d58d137)

## 自動テスト
以下の部分にRSpecを実装しております。
- `spec/models/user_spec.rb`に、ユーザーのモデルスペック
- `spec/requests/users_spec.rb`に、ログイン・サインアップのリクエストスペック
- `spec/requests/tweets_spec.rb`に、ツイートのリクエストスペック
- `spec/system/users_spec.rb`に、ログイン・サインアップのシステムスペック
- `spec/system/tweets_spec.rb`に、ツイートのシステムスペック

## ローカル環境で実行する場合のsetup

- dockerが必要です。

```
docker compose build
```

```
docker compose run --rm web bin/setup
```

```
docker compose run --rm web yarn install
```

## run

```
docker compose up
```

http://localhost:3000

