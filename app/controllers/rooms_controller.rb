class RoomsController < ApplicationController

    def index
      render json: Room.all.map(&:as_json), status: 200
    end

end