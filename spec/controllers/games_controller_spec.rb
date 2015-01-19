require 'rails_helper'

RSpec.describe GamesController, :type => :controller do
  fixtures :games, :users
  let(:new_game) {games(:pending_game)}
  let(:make_game) {intance_double('MakeGame')}
  let(:waiting_user) {users(:bert)}
  # turn on "render views" to test that the view is rendering properly. Otherwise, tests do not render anything.
  let(:user) { double('user') }

  before do
    allow(request.env['warden']).to receive(:authenticate!) { user }
    allow(controller).to receive(:current_user) { user }
  end

  describe "GET #index" do
  	context "when user is logged in" do
      before do 
        allow(user).to receive(:recently_accepted_games)
        allow(user).to receive(:resumable_games)
        allow(user).to receive(:joinable_games)
        allow(user).to receive(:finished_games)
      end
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
    before do
      allow(double('user')).to receive(:pending_game_exists?).and_return false
      allow(MakeGame).to receive(:new).and_return(instance_double(MakeGame, call: true))
    end

    it "adds a new game" do
      post :create
      expect(response).to redirect_to games_path
    end
  end

  describe "#destroy" do
    before do
      allow(waiting_user).to receive(:pending_game).and_return new_game
    end

  	it "redirects to the games index" do
      post :destroy, new_game.id
      expect(response).to redirect_to games_path
    end
  end
  
end
