Spree.user_class.class_eval do
  #has_many :friends, -> { where(friendship: {status: 'accepted'}).order('first_name DESC') }, :through => :friendships
  has_many :addresses, -> { where(deleted_at: nil).order("updated_at DESC") }, class_name: 'Spree::Address'
end
