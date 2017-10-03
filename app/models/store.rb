class Store < ApplicationRecord
  has_many :store_prices
  has_many :items, through: :store_prices

  def find_users_missing_items(user_list)
    user_list.pluck(:name) - self.items.pluck(:name)
  end

  def users_total_price(user_list)
    StorePrice.where(item: user_list, store: self).pluck(:price).reduce(:+).round(2)
  end

  def closest_store_from_user_location
    YelpAdapter.search(self.name)["businesses"].sort_by { |rest| rest["distance"] }.first
  end

end
