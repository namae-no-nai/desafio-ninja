# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'Schedule validation of' do
    subject do
      test_room = create(:room)
      build(:schedule, begin_time: begin_time, end_time: end_time, room_id: test_room.id)
    end

    describe 'Time' do
      context 'too early' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 9, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 10, 0, 0) }

        it { expect(subject).to be_invalid }
      end
      context 'beginning too early' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 11, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 12, 0, 0) }

        it { expect(subject).to be_invalid }
      end
      context 'on the window' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 12, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 13, 0, 0) }

        it { expect(subject).to be_valid }
      end
      context 'ending too late' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 12, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 22, 0, 0) }

        it { expect(subject).to be_invalid }
      end
      context 'beggining too late' do
        let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 22, 0, 0) }
        let(:end_time) { DateTime.new(2022, 0o1, 0o3, 23, 0, 0) }

        it { expect(subject).to be_invalid }
      end
    end
  end
end
