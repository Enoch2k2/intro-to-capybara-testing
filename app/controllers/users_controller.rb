class UsersController < ApplicationController
  def index
    render json: User.all, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:first_name, :last_name, :email, :password)
    end
end
