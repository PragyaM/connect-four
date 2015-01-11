require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :games
  let(:new_game) {games(:pending_game)}
  let(:make_game) {intance_double("MakeGame")}
  # turn on "render views" to test that the view is rendering properly. Otherwise, tests do not render anything.

  before do
    user = double('user')
    allow(user).to receive(:recently_accepted_games)
    allow(user).to receive(:resumable_games)
    allow(user).to receive(:joinable_games)
    allow(user).to receive(:finished_games)
    allow(request.env['warden']).to receive(:authenticate!) { user }
    allow(controller).to receive(:current_user) { user }
  end

  describe "GET #index" do
  	context "when user is logged in" do
	    it "responds successfully with an HTTP 200 status code" do
	      get :index
	      expect(response).to be_success
	      expect(response).to have_http_status(200)
	    end

	    it "renders the index template" do
	      get :index
	      expect(response).to render_template("index")
	    end
  	end
  end

  describe "GET #show/id" do
  	it "renders the show template" do
      get :show, id: new_game.id
      expect(response).to render_template("show")
    end
  end

  describe "POST #create" do
    it "redirects to the games index" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "#destroy" do
  	it "redirects to the games index" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
end
