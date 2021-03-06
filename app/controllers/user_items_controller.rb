class UserItemsController < ApplicationController

  # skip_before_action :verify_authenticity_token

  def index
    user = User.first
    items = user.items
    render json: items.to_json
  end

  def create
    itemName = params[:item][:name]
    item = Item.find_by(name: itemName)
    @user_item = UserItem.new
    @user_item.user_id = User.first.id
    @user_item.item_id = item.id
    @user_item.save

    render json: @user_item.to_json
  end

	def destroy
    user = User.first
    user_item = UserItem.find_by(user_id: user.id, item_id: params[:user_item_id])
    # user_item.user_id = User.first.id
    # user_item.item_id = item.id
    user_item.destroy!

    render json: user_item.to_json

	end

end


# Paste to user_items.index.html.erb

# <% @item_list.pluck(:name).each do |item_name| %>
# 	<%= item_name %>

# this part is not right. To delete we need to use user show page.
    # <%= button_to "Delete", {:controller => "user_items"}  %>
# <% end %>
