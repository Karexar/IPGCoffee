class AdminsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(allowed_params)
    if @admin.save
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  private

  def allowed_params
    params.require(:user).permit(:name, :password)
  end
end
