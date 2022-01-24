# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  describe 'GET /rooms' do
    it 'should return success status' do
      get '/rooms'
      expect(response).to have_http_status(200)
    end

    context 'with created rooms' do
      let(:room) { create(:room) }

      it 'should return success status' do
        room
        get '/rooms'
        expect(response.body).to include(room.id.to_s)
        expect(response.body).to include(room.name)
      end
      context do
        let(:schedule) { create(:schedule, room_id: room.id) }
        it 'should return schedules' do
          schedule
          get '/rooms'

          expect(response.body).to include(schedule.begin_time.strftime('%F %T'))
          expect(response.body).to include(schedule.end_time.strftime('%F %T'))
          expect(response.body).to include(schedule.room_id.to_s)
        end
      end
    end
  end

  describe 'POST /rooms/id/add_schedule' do
    context 'should return status and' do
      let(:room) { create(:room) }
      let(:schedule) do
        {
          id: 1,
          begin_time: '2022-01-03 14:00:00',
          end_time: '2022-01-03 15:00:00',
          room_id: room.id,
          created_at: DateTime.now,
          updated_at: DateTime.now
        }
      end

      let(:conflicting) do
        {
          id: 2,
          begin_time: '2022-01-03 14:00:00',
          end_time: '2022-01-03 15:00:00',
          room_id: room.id,
          created_at: DateTime.now,
          updated_at: DateTime.now
        }
      end

      it 'create schedule' do
        room
        post "/rooms/#{room.id}/add_schedule", params: { schedule: schedule }

        expect(response).to have_http_status(201)
      end

      it 'conflicting schedules' do
        room
        post "/rooms/#{room.id}/add_schedule", params: { schedule: schedule }
        post "/rooms/#{room.id}/add_schedule", params: { schedule: conflicting }

        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'PUT /schedule/id' do
    describe 'should return status and' do
      let(:room) { create(:room) }
      let(:schedule) { create(:schedule, id: 1, room_id: room.id) }
      let(:second_schedule) do
        create(:schedule,
               id: 2,
               begin_time: '2022-01-03 15:30:00',
               end_time: '2022-01-03 16:30:00',
               room_id: room.id)
      end

      let(:new_schedule) do
        {
          id: 1,
          begin_time: '2022-01-03 14:00:00',
          end_time: '2022-01-03 15:00:00',
          room_id: room.id,
          created_at: DateTime.now,
          updated_at: DateTime.now
        }
      end

      let(:conflicting) do
        {
          id: 1,
          begin_time: '2022-01-03 12:00:00',
          end_time: '2022-01-03 14:00:00',
          room_id: room.id,
          created_at: DateTime.now,
          updated_at: DateTime.now
        }
      end

      it 'edit schedule' do
        schedule
        put "/schedules/#{schedule.id}", params: { schedule: new_schedule }

        expect(response).to have_http_status(200)
      end

      it 'conflicting schedules' do
        schedule
        second_schedule
        put "/schedules/#{schedule.id}", params: { schedule: conflicting }

        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE /schedules/id' do
    describe 'should delete schedule' do
      let(:room) { create(:room) }
      let(:schedule) { create(:schedule, id: 1, room_id: room.id) }
      let(:second_schedule) do
        create(:schedule,
               id: 2,
               begin_time: '2022-01-03 15:30:00',
               end_time: '2022-01-03 16:30:00',
               room_id: room.id)
      end
      it 'when there is a schedule' do
        schedule
        delete "/schedules/#{schedule.id}"
        expect(response).to have_http_status(200)
      end

      it 'return when schedule is unavailable' do
        delete '/schedules/400'
        expect(response).to have_http_status(404)
      end
    end
  end
end
