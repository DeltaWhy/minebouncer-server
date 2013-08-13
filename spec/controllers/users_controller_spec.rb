require 'spec_helper'

describe UsersController do
  let(:valid_attributes) { { "email" => "steve@example.com", "password" => "password1",
                             "password_confirmation" => "password1", "username" => "Steve" } }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index, {}, valid_session
      assigns(:users).should eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, {:user => valid_attributes}, valid_session
        { get: response.headers['Location'] }.should route_to(controller: 'users', action: 'show', id: User.last.to_param)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "email" => "invalid value" }}, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "doesn't return success" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "email" => "invalid value" }}, valid_session
        response.should_not be_success
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        User.any_instance.should_receive(:update).with({ "email" => "bob@example.com" })
        put :update, {:id => user.to_param, :user => { "email" => "bob@example.com" }}, valid_session
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "email" => "invalid value" }}, valid_session
        assigns(:user).should eq(user)
      end

      it "doesn't return success" do
        user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "email" => "invalid value" }}, valid_session
        response.should_not be_success
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end
  end
end
