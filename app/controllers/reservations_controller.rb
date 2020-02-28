class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
    @user = current_user
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      render :show
    else
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(user_id: current_user.id, reserved: true)
      render :show
    else
      render :new
    end
  end

  def destroy
    Reservation.find(params[:id]).destroy
    redirect_to fp_user_path
  end

  def events
    @events = Reservation.all
    respond_to do |format|
      format.html 
      format.json do
        json_object = @events.map { |event| {start: event.start_time, end: event.start_time} }
        render(json: json_object) 
      end
    end  
  end

  def event_create
    @reservation = Reservation.new(fp_user_id: current_user.id, start_time: params[:start_time])
    if @reservation.save
      render :show
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:fp_user_id, :user_id, :start_time)
  end

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
