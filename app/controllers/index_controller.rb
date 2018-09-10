class IndexController < ApplicationController
  def show
    @users = User.all
  end
end
