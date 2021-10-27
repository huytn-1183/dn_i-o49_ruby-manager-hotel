module BookingsHelper
  # *_color define to get bootstrap color
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
