class BuyController < ApplicationController
  def new
    Order.delete_all
    redirect_to "/buy/show/#{params[:id]}"
  end

  def show
    #Order.delete_all
    @user = User.find(params[:id])
    @products = Product.all
    @orders = Array.new
    @cost = 0.0
    Order.all.each do |order|
      product_chosen = Product.where(id: order.product_id).first
      total = order.quantity*product_chosen.price
      @orders.push([product_chosen.name, order.quantity, total])
      @cost += total
    end
  end

  def add
    item_in_order = Order.where(product_id: params[:product_id]).first
    if item_in_order.nil?
      Order.create product_id: params[:product_id], quantity: 1
    else
      item_in_order.update quantity: (item_in_order.quantity+1)
    end
    redirect_to "/buy/show/#{params[:user_id]}"
  end

  def pay
    @cost = 0.0
    Order.all.each do |order|
      product_chosen = Product.where(id: order.product_id).first
      total = order.quantity*product_chosen.price
      @cost += total
    end
    user = User.find(params[:id])
    user.update balance: (user.balance - @cost)
    Order.delete_all
    redirect_to "/buy/show/#{params[:id]}"
  end

  def edit_picture
      @user = User.find(params[:id])
  end

  def save_picture
      #print("*****************\n")
      #print(params[:image].gsub(/ /, "+"))
      #print("\n*****************\n")
      @user = User.find(params[:id])
      #@user.avatar.attach(params[:image])
      #mytest = "data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
      @user.avatar = { data: params[:image].gsub(/ /, "+") }
      redirect_to "/buy/show/#{params[:id]}"
  end
end
