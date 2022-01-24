# frozen_string_literal: true

RSpec.describe 'Rooms', type: :request do
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
end
