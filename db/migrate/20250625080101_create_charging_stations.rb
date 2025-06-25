class CreateChargingStations < ActiveRecord::Migration[8.0]
  def change
    create_table :charging_stations do |t|
      t.string :title
      t.float :latitude
      t.float :longitude
      t.string :address

      t.timestamps
    end
  end
end
