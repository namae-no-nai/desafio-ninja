# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.datetime :begin_time
      t.datetime :end_time
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
