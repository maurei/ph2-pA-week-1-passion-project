require 'spec_helper'
describe "logging in and out" do

	context 'no user logged in' do
	 	let(:user){User.create(handle: "Maurits Moeys", password: "maurits", email: "mau@mail.com", access_level: "member", year: 2012)}
	 	let(:params){ {handle: "Maurits Moeys", password: "maurits"} }
			
			describe "GET /" do
				it "redirects to login" do
					get '/' 
					expect(last_response.location).to end_with('/login')
				end
			end

			describe "GET /login" do
				it "shows the login page" do
					get '/login' 
					expect(last_response.status).to eq(200)
				end
			end

			describe "correct POST /login" do
				it "redirects to /users page" do
					post '/login', params
					expect(last_response.location).to end_with('/users/1')
				end
			end

			describe "bad POST /login" do
				it "redirects to /login page when password is wrong" do
					params = {handle: "Maurits Moeys", password: "maur123its"}
					post '/login', params
					expect(last_response.status).to eq(302)
				end
			end

			describe "POST /login" do
				it "redirects to /login page when username is wrong" do
					params = {handle: "Mauri123ts Moeys", password: "maurits"}
					post '/login', params
					expect(last_response.location).to end_with('/login')
				end
			end

			describe "POST /login" do
				xit "returns status code 401" do
					# still need to fix authorization in code.
					params = {handle: "Maurits Moeys", password: "maur123its"}
					post '/login', params
					expect(last_response.location).to end_with('/login')
				end
			end

	end

	context 'user logged in' do
		let(:user_session){   { 'rack.session' => {:auth_user_id => user.id }} }
			
			describe "get /logout" do
				it "redirects to login" do
					get '/logout'
					expect(last_response.location).to end_with('/login')
				end
			end

			describe "get /logout" do
				it "gives the redirect status code" do
					get '/logout'
					expect(last_response.status).to eq(302)
				end
			end

			describe "get /users/*"	do
				xit "returns unauthorized status code when accessing secret stuff" do
					# still need to fix authorization in code.
					get '/users/1'
					expect(last_response.status).to eq(401)
				end
			end

		end

end
				






# it "should create a new post" do
#   fake_params = { foo: "some foo", bar: "some bar" }
#   fake_session = { 'rack.session' => { baz: 20 } }
#   expect{
#     post '/some_route', fake_params, fake_session
#   }.to change{ Post.count }.by(1)
# end


# describe "articles_controller" do
#   describe "GET /articles" do
#     it "renders a successful status" do
#       # arrange
#       # act
#       get '/articles'
#       # assert
#       expect(last_response.status).to eq(200)
#     end

#     it "renders a list of articles" do
#       # arrange
#       Article.create(title: "My Article")
#       # act
#       get '/articles'
#       # assert
#       expect(last_response.body).to include("My Article")
#     end
#   end

#   describe "GET /articles/:id" do
#     describe "if the article exists" do
#       it "renders a successful status" do
#         # arrange
#         @article = Article.create(title: "Woah awesome article")
#         # act
#         get "/articles/#{@article.id}"
#         # assert
#         expect(last_response.status).to eq(200)
#       end
#     end

#   end

#   describe "POST /articles" do
#     it "create a new article" do
#       #arrange - clean up the test database
#       Article.delete_all

#       expect {
#         post "/articles", title: "That's not cool. Fingers. Come on."
#       }.to change { Article.count }
#     end
#   end
# end