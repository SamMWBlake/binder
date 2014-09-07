describe JamsController do
  describe 'GET #index' do
    context "/jams" do
      # This route is only available via the authenticated root, and thus should
      # not be available to unauthenticated users.

      context "when user is not signed in" do
        before do
          get :index
        end

        include_examples "redirects unauthenticated user"
      end

      context "when user is signed in" do
        include_context "sign in as user"

        before do
          get :index
        end

        it "should show signed-in user's repertoire" do
          expect(assigns(:singer)).to eq user
        end

        it { should render_template :index }
      end
    end

    context "/users/:user_id/jams" do
      let(:user) { create :user }

      before do
        get :index, user_id: user.id
      end

      it "should show specified user's repertoire" do
        expect(assigns(:singer)).to eq user
      end

      it { should render_template :index }
    end
  end

  describe 'GET #new' do
    def new_jam(user)
      get :new, user_id: user.id
    end

    shared_examples "renders new jam template" do
      it { should render_template :new }
    end

    context "when not signed in" do
      before do
        new_jam create(:user)
      end

      include_examples "redirects unauthenticated user"
    end

    context "when signed in as other user" do
      include_context "sign in as user"
      let(:repertoire_owner) { create :user }

      before do
        new_jam repertoire_owner
      end

      include_examples "redirects unauthorized user"
    end

    context "when signed in as repertoire owner" do
      include_context "sign in as user"

      before do
        new_jam user
      end

      include_examples "renders new jam template"
    end

    context "when signed in as admin" do
      include_context "sign in as admin"
      let(:repertoire_owner) { create :user }

      before do
        new_jam repertoire_owner
      end

      include_examples "renders new jam template"
    end
  end

  describe 'POST #create' do
    def create_jam(user)
      post :create, user_id: user.id, jam: { song_title: "title", artist_name: "name" }
    end

    shared_examples "adds song to repertoire" do
      it "should add song to user's repertoire" do
        expect(repertoire_owner.songs.count).to eq 1
        expect(repertoire_owner.songs.first.title).to eq "title"
        expect(repertoire_owner.songs.first.artist.name).to eq "name"
      end
    end

    context "when not signed in" do
      before do
        create_jam create(:user)
      end

      include_examples "redirects unauthenticated user"
    end

    context "when signed in as other user" do
      include_context "sign in as user"
      let(:repertoire_owner) { create :user }

      before do
        create_jam repertoire_owner
      end

      include_examples "redirects unauthorized user"
    end

    context "when signed in as repertoire owner" do
      include_context "sign in as user"
      let(:repertoire_owner) { user }

      before do
        create_jam repertoire_owner
      end

      include_examples "adds song to repertoire"
    end

    context "when signed in as admin" do
      include_context "sign in as admin"
      let(:repertoire_owner) { create :user }

      before do
        create_jam repertoire_owner
      end

      include_examples "adds song to repertoire"
    end
  end
end
