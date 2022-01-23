# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it { should validate_presence_of(:begin_time) }

  it { should validate_presence_of(:end_time) }

  it { should belong_to(:room) }
end
