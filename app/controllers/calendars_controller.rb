class CalendarsController < ApplicationController
  def index
    @reservations = Reservation.all
  end
end
