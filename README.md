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
* has_many :item_transactions


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
* has_one :item_transaction


## item_transactions
| Column | Type | Options |
|--------|------|---------|
| item_id(FK) | integer | foreign_key: true |
| user_id(FK) | integer | foreign_key: true |

### Association
* belongs_to :user
* belongs_to :item
* has_one :address


## addresses
| Column       | Type    | Options           |
|--------------|---------|-------------------|
| postal_code  | integer | null: false       |
| prefecture   | integer | null: false       |
| city         | string  | null: false       |
| address      | string  | null: false       |
| building     | string  |                   |
| phone_number | string  | null: false       |
| item_transaction_id(FK)  | integer | foreign_key: true |

### Association
* belongs_to :item_transaction