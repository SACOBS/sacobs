require 'spec_helper'

describe AvailabilityController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'check'" do
    it "returns http success" do
      get 'check'
      response.should be_success
    end
  end

end
