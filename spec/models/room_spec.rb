require "rails_helper"

RSpec.describe Room, type: :model do
  let (:rooms) { create_list(:room, Settings.digit.length_4) }
  context "query" do
    it "match array" do
      expect(Room.all).to match_array(rooms)
    end

    it "search with nil keyword" do
      expect(Room.name_search(nil).count).to eq(Room.count)
    end

    it "query empty attributes" do
      expect(Room.has_attributes([]).count).to eq(0)
    end

    it "query invalid pagination" do 
      expect(Room.pagination_at(
        Settings.digit.length_4 + 1
      ).count).to eq(0)
    end
  end
end
