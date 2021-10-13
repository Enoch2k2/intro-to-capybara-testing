require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  context "GET index" do
    it "returns status 200 and all of the users as json" do
      get :index

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(User.all)
    end
  end

  context "POST create" do
    it "returns status 201 and a user as json when successful" do
      post :create, params: { first_name: "Bob", last_name: "Test", email: "bob@test.com", password: "testtest" }

      expect(JSON.parse(response.body)["email"]).to eq(User.last.email)
      expect(response.status).to eq(201)
    end

    it "returns json with errors attached, as well as unprocessable_entity when not successful" do
      post :create, params: {}

      expect(JSON.parse(response.body)["errors"]).to_not eq(nil)
      expect(response.status).to eq(422)
    end
  end
end