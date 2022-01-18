class RevenuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.current_week_revenue(current_user)

    @this_week_revenue = @reservations.map {|r| {r.updated_at.strftime("%Y-%m-%d") => r.total} }
                                      .inject({}) {|a,b| a.merge(b){|_,x,y| x + y}}
    @this_week_revenue = Date.today().all_week.map{ |date| [date.strftime("%a"), @this_week_revenue[date.strftime("%Y-%m-%d")] || 0 ] }

    @this_month_revenue = @reservations.map {|r| {r.updated_at.strftime("%b-%Y") => r.total} }
                                      .inject({}) {|a,b| a.merge(b){|_,x,y| x + y}}
    @this_month_revenue = Date.today().all_month.map{ |date| [date.strftime("%B"), @this_month_revenue[date.strftime("%b-%Y")] || 0 ] }

    @this_year_revenue = @reservations.map {|r| {r.updated_at.strftime("%b-%Y") => r.total} }
                                      .inject({}) {|a,b| a.merge(b){|_,x,y| x + y}}
    @this_year_revenue = Date.today().all_year.map{ |date| [date.strftime("%b"), @this_year_revenue[date.strftime("%b-%Y")] || 0 ] }
  end
end
