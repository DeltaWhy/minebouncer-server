require 'spec_helper'

describe GamesController do
  let!(:game) { FactoryGirl.create(:game, user: user) }

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user, email: "user2@example.com", username: "User2") }
  let(:admin) { FactoryGirl.create(:admin) }

  describe '#index' do
    it 'lists all games' do
      sign_in user
      get :index
      assigns(:games).should eq([game])
    end
    
    it 'requires login' do
      get :index
      response.status.should eq(401)
    end

    describe 'with user scope' do
      it "finds a user's games" do
        sign_in user
        game1 = FactoryGirl.create(:game, user: user)
        get :index, user_id: user.to_param
        assigns(:games).should include(game1)
      end

      it "doesn't find another user's games" do
        sign_in user
        game2 = FactoryGirl.create(:game, user: user2)
        get :index, user_id: user.to_param
        assigns(:games).should_not include(game2)
      end
    end
  end

  describe '#show' do
    it 'finds a game' do
      sign_in user
      get :show, id: game.to_param
      assigns(:game).should eq(game)
    end
    
    it 'requires login' do
      get :show, id: game.to_param
      response.status.should eq(401)
    end

    describe 'with user scope' do
      it "finds a user's games" do
        sign_in user
        game1 = FactoryGirl.create(:game, user: user)
        get :show, user_id: user.to_param, id: game1.to_param
        assigns(:game).should eq(game1)
      end

      it "doesn't find another user's games" do
        sign_in user
        game2 = FactoryGirl.create(:game, user: user2)
        expect {
          get :show, user_id: user.to_param, id: game2.to_param
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#create' do
    it 'creates a game' do
      sign_in user
      post :create
      assigns(:game).should be_a(Game)
      assigns(:game).user.should eq(user)
      assigns(:game).should be_persisted
    end

    it 'chooses a port' do
      sign_in user
      post :create
      (1024..65535).should include(assigns(:game).port)
    end
  end

  describe '#destroy' do
    it "destroys the requested game" do
      sign_in user
      expect {
        delete :destroy, :id => game.to_param
      }.to change(Game, :count).by(-1)
    end

    describe "without authorization" do
      it "doesn't return success" do
        sign_in user2
        expect {
          delete :destroy, :id => game.to_param
        }.to_not change(Game, :count).by(-1)
        response.should_not be_success
      end
    end

    describe "as an admin" do
      it "allows updating other users" do
        sign_in admin
        expect {
          delete :destroy, :id => game.to_param
        }.to change(Game, :count).by(-1)
      end
    end
  end
end
