# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    begin_time { base_time }
    end_time { base_time + 1.hour }
    room { room.id }
  end
end

def base_time
  Time.new(2022, 0o1, 0o3).utc
end
