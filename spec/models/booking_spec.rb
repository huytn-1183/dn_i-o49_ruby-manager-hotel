require "rails_helper"

RSpec.describe Booking, type: :model do
  context "mutation" do
    let (:bookings) { create_list(:booking, Settings.digit.length_4) }

    it "create right default status" do
      expect(Booking.inactive).to match_array(bookings)
    end

    it "create details in reverse chronologically" do
      room = create(:room)
      booking = create(:booking)

      first = booking.booking_details.create!(
        date_in: "Sat, 01 Jan 2000",
        date_out: "Sun, 02 Jan 2000",
        room_id: room.id
      )

      second = booking.booking_details.create!(
        date_in: "Mon, 03 Jan 2000",
        date_out: "Tue, 04 Jan 2000",
        room_id: room.id
      )

      expect(booking.reload.booking_details).to match_array([
        second,
        first
      ])
    end
  end

  context "query" do
    it "pagination invalid page" do
      bookings = Booking.all_as_admin(page: 1)
      expect(bookings.count).to eq(0)
    end

    it "status filter by invalid string value" do
      bookings = Booking.status_is "xxxx"
      expect(bookings.count).to eq(0)
    end
  end
end
