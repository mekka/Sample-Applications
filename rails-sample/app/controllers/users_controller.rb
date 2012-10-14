class UsersController < ApplicationController
  CLEF_ID = 'bc7b3e3fa9ac6ad3f97df4bb03a5a0f6'
  CLEF_SECRET = 'c2d7607f97ba968604f999cd6918aac6'

  def new
  end

  def clef_create
 		code = params[:code]
	  response = JSON.parse(HTTPParty.post("https://clef.io/api/authorize", :query => {:code => code, :app_id => CLEF_ID, :app_secret => CLEF_SECRET}).body)
	  if response['success']
	    token = response['access_token']
	    response = JSON.parse(HTTParty.post("https://clef.io/api/info", :query => {:access_token => token}).body)
	    session[:user] = response
	    redirect '/'
	  else
	  	return response.to_json
	  end
  end

  def show
  end
end