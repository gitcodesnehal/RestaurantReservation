class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :name
      t.integer :people
      t.time :res_time

      t.timestamps
    end
  end
end
