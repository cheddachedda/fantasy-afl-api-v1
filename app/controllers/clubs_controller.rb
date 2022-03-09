class ClubsController < ApplicationController
  def index
    clubs = Club.all
    render json: clubs
  end

  def show
    club = Club.find(params[:id])
    render json: club
  end
end
