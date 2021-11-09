require "rails_helper"

RSpec.describe "Admin::Bookings", type: :request do
  let (:bookings) { create_list(:booking, Settings.digit.length_4) }
  context "GET /admin/bookings without status filter" do
    before { get "/admin/bookings" }

    it "render index" do 
      expect(response).to render_template(:index)
    end

    it "return bookings" do
      expect(assigns(:bookings)).to match_array(bookings)
    end
  end

  context "GET /admin/bookings with status filter" do
    let (:bookings_remove) { create_list(:booking, Settings.digit.length_4, status: :remove) }

    before { get "/admin/bookings", params: { status: "remove" } }
    
    it "render index" do 
      expect(response).to render_template(:index)
    end

    it "return remove_bookings" do
      expect(assigns(:bookings)).to match_array(bookings_remove)
    end
  end
end
