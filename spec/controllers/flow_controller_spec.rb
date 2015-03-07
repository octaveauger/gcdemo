require 'rails_helper'

RSpec.describe FlowController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
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
