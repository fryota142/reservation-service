class ReservationsController < ApplicationController
  before_action :correct_fp_user, only: %i(edit)

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
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'Reservation not found'
  end

  def edit
    @reservation = Reservation.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'Reservation not found'
  end

  def update
    @reservation = Reservation.find(reservation_params[:id])
    if @reservation.update(user_id: reservation_params[:user_id], reserved: reservation_params[:reserved])
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
        json_object = @events.map { |event|
          label_color = event.reserved? ? "#63ceef" : "#ffa500"
          {id: event.id, start: event.start_time, end: event.start_time + 1800, color: label_color} }
        render(json: json_object)
      end
    end
  end

  def event_new
    @reservation = Reservation.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { event: @reservation })
  end

  def event_create
    @reservation = Reservation.new(fp_user_id: current_user.id, start_time: params[:start_time])
    if current_user.class == FpUser && @reservation.save
      render :show
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:id, :fp_user_id, :user_id, :start_time, :reserved)
  end

  def correct_fp_user
    @fp_user = FpUser.find(params[:id])
    redirect_to(root_url) unless current_user == @fp_user
  end

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
