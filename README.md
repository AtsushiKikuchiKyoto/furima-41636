# README

## テーブル名 users
| Column  | Type  | Options |
| --- | --- | --- |
| nickname | string | null: false |
| email | string | null: false, unique: true |
| password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birthday | date | null: false |

### Association
- has_many :items, dependent: :destroy
- has_many :orders


## テーブル名 items
| Column  | Type  | Options |
| --- | --- | --- |
| image | text | null: false |
| name | string | null: false |
| content | text | null: false |
| category_id | integer | null: false, foreign_key: true |
| condition_id | integer | null: false, foreign_key: true |
| postage_id | integer | null: false, foreign_key: true |
| ship_area | string | null: false |
| prefecture_id | integer | null: false, foreign_key: true |
| lead_time | integer | null: false, foreign_key: true |
| price | integer | null: false |
| service_fee | integer | null: false |
| sales_profit | integer | null: false |
| sold_out | boor | null: false |
| user_id | integer | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order


## テーブル名 orders
| Column  | Type  | Options |
| --- | --- | --- |
| user_id | integer | null: false, foreign_key: true |
| item_id | integer | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery

## テーブル名 deliveries
| Column  | Type  | Options |
| --- | --- | --- |
| order_id | integer | null: false, foreign_key: true |
| post_code | string | null: false |
| prefecture_id | integer | null: false, foreign_key: true |
| city | string | null: false |
| street_address | string | null: false |
| building | string |  |