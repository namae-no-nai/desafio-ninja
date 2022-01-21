# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    begin_time { begining_of_week }
    end_time { begining_of_week }
  end
end

def begining_of_week
  Time.new(2022, 0o1, 0o3).utc
end
