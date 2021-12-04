class GuestReviewsController < ApplicationController

  def create
    # Step 1: Check if the reservation exist (room_id, guest_id, host_id)

    # Step 2: Check if the current host already reviewed the guest in this reservation.

    @reservation = Reservation.where(
                    id: guest_review_params[:reservation_id],
                    room_id: guest_review_params[:room_id]
                   ).first

    if !@reservation.nil? && @reservation.room.user.id == guest_review_params[:host_id].to_i

      @has_reviewed = GuestReview.where(
                        reservation_id: @reservation.id,
                        host_id: guest_review_params[:host_id]
                      ).first

        if @has_reviewed.nil?
            # Allow to review
            @guest_review = current_user.guest_reviews.create(guest_review_params)
            flash[:success] = "Review created..."
        else
            # Already reviewed
            flash[:success] = "You already reviewed this Reservation"
        end
      else
        flash[:alert] = "Not found this reservation"
      end

      redirect_back(fallback_location: request.referer)
    end

    def destroy
      @guest_review = Review.find(params[:id])
      @guest_review.destroy

      redirect_back(fallback_location: request.referer, notice: "Removed...!")
    end

    private
      def guest_review_params
        params.require(:guest_review).permit(:comment, :star, :room_id, :reservation_id, :host_id)
      end
  end
