class UsersController < ApplicationController
  before_action :authenticate, except: [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation, :username))

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if current_user.admin? || current_user == @user
      if @user.update(params.require(:user).permit(:email, :password, :password_confirmation, :username))
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      head :forbidden
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    if current_user.admin? || current_user == @user
      @user.destroy

      head :no_content
    else
      head :forbidden
    end
  end
end
