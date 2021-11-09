require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "ACTION SHOW" do
    context "GET /users/:valid_id" do 
      let (:user) { create(:user) }

      before { get "/users/%{id}" % { id: user.id } }

      it "render show" do
        expect(response).to render_template(:show)
      end

      it "return user" do
        expect(assigns(:user)).to eq(user)
      end
    end

    context "GET /users/:invalid_id" do
      before { get "/users/-1" } 

      it "redirect new_user" do
        expect(response).to redirect_to(new_user_path)
      end

      it "flash warning" do
        content = I18n.t("controllers.users_controller.user_not_found")
        expect(flash[:warning]).to eq(content)
      end
    end
  end
end
