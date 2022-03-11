class FixturesController < ApplicationController
  def index
    fixtures = Fixture.all
    render json: fixtures
  end

  def round
    fixtures = Fixture.where(round_no: params[:round])
    render json: fixtures
  end

  def show
    fixture = Fixture.find_by(
      id: params[:id],
      round_no: params[:round]
    )
    render json: fixture
  end
end
