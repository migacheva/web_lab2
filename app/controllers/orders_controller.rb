class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order = current_user.orders.where(completed: false).last
    if !@order.nil?
      @sum = 0
      @order.order_items.each do |item| 
        @sum = @sum + item.product.price * item.quantity
      end
    end
  end

  def complete
    id = params.permit(:order_id)[:order_id]
    order = current_user.orders.find(id)
    if !order.completed 
      order.completed = true
      order.save
    end
    redirect_to orders_index_path
  end
end
