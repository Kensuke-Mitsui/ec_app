## アプリ名
ec_app

## 概要
Ruby on Railsの勉強としてのポートフォリオとなります。

ECサイトに関心があり、学んだ技術を使用して現在ポートフォリオとして作成しています。(現在は新規登録/ログイン、pay.jpへの登録機能のみ実装完了しています。)

制作完了の定義としては、サイトを通して商品を購入できるところまでとしています。
## 開発環境
・Ruby 2.5.1

・Rails 5.2.4.2

## 使用言語
・haml/scss/ruby(ruby on rails)/js(jquery)/

## 本番環境
### URl
・http://54.250.10.26/

### testアカウント（ログイン用）
・アドレス test@gmail.com

・パスワード 0000000

## 実装機能
### ユーザー関連
・新規登録機能

・ログイン/ログアウト機能

・例外処理

deviseを使用しています。registarationコントローラを作成して、ユーザー情報のみでなく
商品送付先情報やクレジットの登録もできる様に実装しています。

#### 今後実装予定の機能
・編集機能

・登録情報確認ページ

・APIを用いたSNS認証、登録機能

### クレジットカード関連
・カード登録機能

クレジットカードの決済サービスpay.jpを用いて実装しています。

・フォームに入力されたデータをJSでトークンにすること。

・トークンをpay.jpに送ること。

・pay.jpからデータを受け取ること。

上記三点の実装が中々できず、登録機能の実装に時間がかかりました。

 #### 今後実装予定の機能
 .購入機能

 .削除機能

 .確認及び編集機能

### 商品関連

まだ未実装の段階です。

まずは商品を選んで購入できる様実装し、その次にカテゴリー順に表示される様に実装する予定です。

## その他
データベースはmysqlを使用しています。  
サーバーはAWSのEC2を使用しており、
capistrano用いて自動デプロイできる様にしています。

## DB設計
### usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false, unique: true, index: true|
|encrypted_password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|gender|string|null: false|
|birthday|date|null: false|
#### Association
- has_many :addresses
- has_many :credit_cards

### addressesテーブル
|Column|Type|Options|
|------|----|-------|
|post_code|integer(7)|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string|
|phone_number|string| numericality: { only_integer: true }, allow_blank: true|
|user_id|references|null: false, foreign_key: true|
|destination_family_name|string|
|destination_first_name|string|
|destination_family_name_kana|string|
|destination_first_name_kana|string|
#### Association
- belongs_to :user

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user

## itemsテーブル

