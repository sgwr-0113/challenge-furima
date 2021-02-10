class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  
  validates :nickname, presence: true, uniqueness: {case_sensitive: true}
  validates :birth_date, presence: true
  validates :password, presence: true, format: {with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d_-]{6,}+\z/} 

  with_options presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]+\z/} do
  validates :first_name
  validates :last_name
  end

  with_options presence: true, format: {with: /\A([ァ-ン]|ー)+\z/} do
  validates :first_name_kana
  validates :last_name_kana
  end

  has_many :items
  has_many :orders
  has_many :comments
  has_one :card, dependent: :destroy
  has_one :address_preset
  has_many :sns_credentials
  has_many :favorites, dependent: :destroy
  has_many :items, through: :favorites
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # 最終的にuserのインスタンスを返すクラスメソッド
  # SNSと同emailのユーザが存在すればそのユーザを返す。いなければuserを作成し返す。
  def self.from_sns_credential(sns, auth)
    # snsの情報が既にDBにあった場合は、2回目以降のログインなので紐づくuserを返す
    return sns.user if sns.persisted?
    # snsの情報がDBにない場合
    # 既存ユーザへSNSサービス連携or新規ユーザ登録
    user = User.where(email: auth.info.email).first_or_initialize
    if user.persisted?
      user.sns_credentials << sns
      user.save
    else
      user.nickname = auth.info.name
    end
    user
  end
end
