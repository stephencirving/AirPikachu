class HostReviewsController < ApplicationController

  def create
    # Step 1: Check if the reservation exist (room_id, guest_id, host_id)

    # Step 2: Check if the current host already reviewed the guest in this reservation.

    @reservation = Reservation.where(
                    id: host_review_params[:reservation_id],
                    room_id: host_review_params[:room_id],
                    user_id: host_review_params[:guest_id]
                   ).first

    if !@reservation.nil?

        @has_reviewed = HostReview.where(
                          reservation_id: @reservation.id,
                          guest_id: host_review_params[:guest_id]
                        ).first

      if @has_reviewed.nil?
          # Allow to review
          @host_review = current_user.host_reviews.create(host_review_params)
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
    @host_review = Review.find(params[:id])
    @host_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Removed...!")
  end

  private
    def host_review_params
      params.require(:host_review).permit(:comment, :star, :room_id, :reservation_id, :guest_id)
    end
end
