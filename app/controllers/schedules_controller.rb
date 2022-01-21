# frozen_string_literal: true

class SchedulesController < ApplicationController
  before_action :find_schedule

  def update
    if @schedule.update(schedule_params)
      return render json: { message: 'Schedule updated successfully' },
                    status: 200
    end

    render json: { message: 'Could not update the schedule' }, status: 400
  end

  def destroy
    if @schedule.destroy
      return render json: { message: 'Schedule cancelled successfully' },
                    status: 200
    end

    render json: { message: 'Could not cancel the schedule' }, status: 400
  end

  private

  def schedule_params
    params.require(:schedule).permit(:begin_time, :end_time)
  end

  def find_schedule
    @schedule = Schedule.find_by_id(params[:id])
  end
end
