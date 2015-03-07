require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #representation" do
    it "returns http success" do
      get :representation
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #confirmation" do
    it "returns http success" do
      get :confirmation
      expect(response).to have_http_status(:success)
    end
  end

end
