require 'spec_helper'

describe "home" do
	
	it "should be redirect" do
		get '/' 
		expect(last_response).to be_redirect
	end

	it "should be redirect to login" do
		get '/' 
		expect(last_response.location).to end_with('/login')
	end


end