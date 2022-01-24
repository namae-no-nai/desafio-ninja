# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  it { expect validate_presence_of(:name) }

  it { expect validate_uniqueness_of(:name) }

  it { expect have_many(:schedules) }
end
