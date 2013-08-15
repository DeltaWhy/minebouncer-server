class GamesController < ApplicationController
  before_action :authenticate

  def index
    scope = if params[:user_id]
              User.find(params[:user_id]).games
            else
              Game
            end
    @games = scope.all
    render json: @games
  end

  def show
    scope = if params[:user_id]
              User.find(params[:user_id]).games
            else
              Game
            end
    @game = scope.find(params[:id])
    render json: @game
  end

  def create
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    if current_user.admin? || @user == current_user
      @game = @user.games.create
      render json: @game, status: :created, location: @game
    else
      head :forbidden
    end
  end

  def destroy
    scope = if params[:user_id]
              User.find(params[:user_id]).games
            else
              Game
            end
    @game = scope.find(params[:id])
    if current_user.admin? || @game.user == current_user
      @game.destroy
      head :no_content
    else
      head :forbidden
    end
  end
end
