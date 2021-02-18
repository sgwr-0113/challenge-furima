class Rank < ActiveHash::Base
  self.data = [
    { id: 0, name: 'ブロンズ', image: "rank-bronze.png" },
    { id: 1, name: 'シルバー', image: "rank-silver.png" },
    { id: 2, name: 'ゴールド', image: "rank-gold.png" },
    { id: 3, name: 'プラチナ', image: "rank-platinum.png" }
  ]
  
  include ActiveHash::Associations
  has_many :memberships
end
