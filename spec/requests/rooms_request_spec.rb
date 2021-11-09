require "rails_helper"

RSpec.describe "Rooms", type: :request do
  describe "ACTION INDEX" do
    context "GET /rooms" do
      let (:rooms) { create_list(:room, Settings.digit.length_4) }

      before { get "/rooms" }

      it "render index" do 
        expect(response).to render_template(:index)
      end

      it "return rooms" do
        expect(assigns(:rooms)).to match_array(rooms)
      end
    end
  end

  describe "ACTION SHOW" do
    context "GET /rooms/:valid_id" do
      let (:room) { create(:room) }

      before { get "/rooms/%{id}" % {id: room.id} }

      it "render show" do
        expect(response).to render_template(:show)
      end

      it "return room" do
        expect(assigns(:room)).to eq(room)
      end
    end

    context "GET /rooms/:invalid_id" do
      before { get "/rooms/-1" }

      it "redirect index" do
        expect(response).to redirect_to(root_path)
      end

      it "show flash" do
        expect(flash[:danger]).to eq(I18n.t(:not_found))
      end
    end
  end
end
