# frozen_string_literal: true

(1..4).each do |room_number|
  Room.create(name: "Room #{room_number}")
end
