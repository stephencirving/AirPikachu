class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    room = Room.find(params[:room_id])

    if current_user == room.user
      flash[:alert] = "You cannot book your own property!"
    elsif current_user.stripe_id.blank?
      flash[:alert] = "Please update your payment method."
      return redirect_to payment_method_path
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date).to_i + 1

      @reservation = current_user.reservations.build(reservation_params)
      @reservation.room = room
      @reservation.price = room.price
      @reservation.total = room.price * days
      #@reservation.save

      if @reservation.Waiting!
        if room.Request?
          flash[:notice] = "Request sent successfully!"
      else
        charge(room, @reservation)
      end
    else
      flash[:alert] = "Cannot make a reservation"
    end

    end
    redirect_to room
  end

  def your_trips
    @trips = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @rooms = current_user.rooms
  end

  def approve
    charge(@reservation.room, @reservation)
    redirect_to your_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to your_reservations_path
  end

  private

  def charge(room, reservation)
    if !reservation.user.stripe_id.blank?
      customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
      charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => reservation.total * 100,
        :description => room.listing_name,
        :currency => "usd",
        :destination => {
          :amount => reservation.total * 80, # 80% of the total amount goes to the Host
          :account => room.user.merchant_id # Host's Stripe customer ID
        }
      )

      if charge
        reservation.Approved!
        flash[:notice] = "Reservation created successfully!"
      else
        reservation.Declined!
        flash[:alert] = "Cannot charge with this payment method!"
      end
    end
    rescue Stripe::CardError => e
      reservation.Declined!
      flash[:alert] = e.message
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date)
    end
end
