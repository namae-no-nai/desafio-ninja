# frozen_string_literal: true

describe 'Schedule validation of' do
  subject do
    test_room = create(:room)
    build(:schedule, begin_time: begin_time, end_time: end_time, room_id: test_room.id)
  end

  describe 'Day' do
    context 'saturdays' do
      let(:begin_time) { DateTime.new(2022, 0o1, 0o1, 13, 0, 0) }
      let(:end_time) { DateTime.new(2022, 0o1, 0o1, 14, 0, 0) }

      it { expect(subject).to be_invalid }
    end
    context 'sundays' do
      let(:begin_time) { DateTime.new(2022, 0o1, 0o2, 13, 0, 0) }
      let(:end_time) { DateTime.new(2022, 0o1, 0o2, 14, 0, 0) }

      it { expect(subject).to be_invalid }
    end
    context 'days apart' do
      let(:begin_time) { DateTime.new(2022, 0o1, 0o3, 13, 0, 0) }
      let(:end_time) { DateTime.new(2022, 0o1, 0o4, 14, 0, 0) }

      it { expect(subject).to be_invalid }
    end
  end
end
