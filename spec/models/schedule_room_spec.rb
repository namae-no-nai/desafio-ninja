# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'Schedule validation of' do
    let(:test_room) { create(:room, id: 1) }
    let(:second_room) { create(:room, name: 'second', id: 2) }
    let(:scheduled_time) do
      create(:schedule,
             begin_time: DateTime.new(2022, 0o1, 0o3, 12, 0, 0),
             end_time: DateTime.new(2022, 0o1, 0o3, 13, 0, 0),
             room_id: test_room.id)
    end
    subject do
      build(:schedule, begin_time: begin_time, end_time: end_time, room_id: room_id)
    end

    describe 'Room' do
      context 'same but different time' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 16, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 18, 0, 0) }
        let(:room_id) { test_room.id }

        it { expect(subject).to be_valid }
      end
      context 'same but conflicting time' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 12, 30, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 13, 0, 0) }
        let(:room_id) { test_room.id }
        before do
          scheduled_time
        end

        it { expect(subject).to be_invalid }
      end
      context 'different and same time' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 12, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 13, 0, 0) }
        let(:room_id) { second_room.id }

        it { expect(subject).to be_valid }
      end
      context 'all different' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 13, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 20, 0, 0) }
        let(:room_id) { second_room.id }
        it { expect(subject).to be_valid }
      end
    end
  end
end
