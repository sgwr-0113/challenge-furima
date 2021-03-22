# DB設計

## users
| Column | Type | Options |
|--------|------|---------|
| id | default | null: false |
| nickname | default | null: false, index: true |
| email | default | null: false |
| password | default | null: false |
| first_name | string | null: false |
| last_name | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana | string | null: false |
| birth_date | date | null: false |

### Association
* has_many :items
* has_many :orders


## items
| Column | Type | Options |
|--------|------|---------|
| id | integer | null: false |
| name | string | null: false |
| price | integer | null: false |
| info | text | null: false |
| scheduled_delivery_id(acitve_hash)  | integer    | null: false       |
| shipping_fee_status_id(acitve_hash) | integer    | null: false       |
| prefecture_id(acitve_hash)          | integer    | null: false       |
| sales_status_id(acitve_hash)        | integer    | null: false       |
| category_id(acitve_hash)            | integer    | null: false       |
| user_id(FK) | integer | foreign_key: true |

### Association
* belongs_to :user
* has_one :order

## orders
| Column | Type | Options |
|--------|------|---------|
| item_id(FK) | references | foreign_key: true |
| user_id(FK) | references | foreign_key: true |

### Association
* belongs_to :user
* belongs_to :item
* has_one :address


## addresses
| Column       | Type    | Options           |
|--------------|---------|-------------------|
| postal_code  | string  | null: false       |
| prefecture   | integer | null: false       |
| city         | string  | null: false       |
| address      | string  | null: false       |
| building     | string  |                   |
| phone_number | string  | null: false       |
| order_id(FK)  | integer | foreign_key: true |

### Association
* belongs_to :order




## favorites
| Column | Type | Options |
|--------|------|---------|
| user_id(FK) | references | foreign_key: true |
| item_id(FK) | references | foreign_key: true |

### Association
* belongs_to :user
* belongs_to :item


# RANK
## bronze :0
* 登録時デフォルト
* RGB(196, 112, 34)

## silver :1
* 購入総額30,000円以上
* RGB(174, 179, 181)

## gold :2
* 購入総額50,000円以上
* RGB(219, 180, 0)

## platinum :3
* 購入総額100,000円以上
* 売上総額50,000円以上
* RGB(170, 195, 201)

# color
* #2c3d55 ネイビー
* #8cb2b8 水色
* #e2c8ca ピンク
* #e4b397 肌色
* #a6a6a6 グレー
* #f3efe7 白
* #ea352d オレンジ
* #3ccace 緑