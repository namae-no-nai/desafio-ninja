# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :find_room, except: %i[index]

  def index
    render json: Room.all.map(&:as_hash), status: 200
  end

  def add_schedule
    @schedule = @room.schedules.new(schedule_params)
    if @schedule.save
      return render json: { message: 'New schedule created successfully' },
                    status: 201
    end

    render json: { message: 'Could not create new schedule' }, status: 400
  end

  private

  def find_room
    @room = Room.find_by_id(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:begin_time, :end_time)
  end
end
