# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    begin_time { base_time + 12.hour }
    end_time { base_time + 13.hour }
    room { room.id }
  end
end

def base_time
  DateTime.new(2022, 0o1, 0o3).utc
end
