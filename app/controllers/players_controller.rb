class PlayersController < ApplicationController
  def index
    players = Player.all
    render json: players
  end

  def show
    player = Player.find(params[:id])
    render json: player.to_json
  end
end
