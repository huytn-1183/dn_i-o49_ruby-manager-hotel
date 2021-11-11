require "rails_helper"
include SessionsHelper

RSpec.describe "Sessions", type: :request do
  let (:user) { create(:user) }

  it "GET /login render new" do
    get "/login"
    expect(response).to render_template(:new)
  end

  it "DELETE /logout without login" do
    delete "/logout"
    expect(response).to redirect_to(root_url)
  end

  context "POST /login success" do
    before do
      post "/login", params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
    end

    it "redirect_to root_url" do
      expect(response).to redirect_to(root_url)
    end

    it "session user" do
      expect(session[:user_id]).to eq(user.id)
    end
  end

  context "POST /login failure" do
    let (:invalid_login) { I18n.t("controllers.sessions_controller.invalid_login") }

    before do
      post "/login", params: {
        session: {
          email: user.email,
          password: user.password + "."
        }
      }
    end

    it "render new" do
      expect(response).to render_template(:new)
    end

    it "flash invalid" do
      expect(flash.now[:danger]).to eq(invalid_login)
    end
  end
end
