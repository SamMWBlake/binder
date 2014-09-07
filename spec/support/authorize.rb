shared_context "sign in as user" do
  let(:user) { create :user }

  before do
    sign_in user
  end
end

shared_context "sign in as admin" do
  let(:admin) { create :admin }

  before do
    sign_in admin
  end
end

shared_examples "redirects unauthenticated user" do
  it { should set_the_flash[:alert] }
  it { should redirect_to new_user_session_path }
end

shared_examples "redirects unauthorized user" do
  it { should set_the_flash[:alert] }
  it { should redirect_to user_jams_path(repertoire_owner) }
end
