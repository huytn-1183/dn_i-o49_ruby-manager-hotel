module Staff::BookingsHelper
  def room_status_color room
    maps = {"available" => :success, "unavailable" => :danger}
    maps[room.status]
  end

  def booking_status_color booking
    maps = {
      "inactive" => :warning,
      "active" => :success,
      "accept" => :info,
      "remove" => :danger
    }
    maps[booking.status]
  end
end
