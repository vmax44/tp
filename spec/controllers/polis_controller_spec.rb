require 'spec_helper'

describe PolisController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'add'" do
    it "returns http success" do
      get 'add'
      response.should be_success
    end
  end

end
