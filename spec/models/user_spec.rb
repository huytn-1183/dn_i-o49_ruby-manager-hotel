require "rails_helper"

RSpec.describe User, type: :model do
  context "attribute" do
    it { should define_enum_for(:role).with([:admin, :staff, :customer]) }

    it { should have_secure_password }
  end

  context "validate" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:password) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

 context "mutation" do
    let (:user){ create(:user) }

    before { user.remember }

    it "generate_token be truthy" do
      expect(User.generate_token).to be_truthy
    end 

    it "remember_digest be truthy" do
      expect(user.remember_digest).to be_truthy
    end

    it "remember_token be truthy" do
      expect(user.remember_token).to be_truthy
    end 

    it ".authenticated? (login success)" do
      status = user.authenticated?(user.remember_token)
      expect(status).to be_truthy
    end

    it ".forget" do
      user.forget
      expect(user.remember_digest).to be_nil
    end
  end
end
